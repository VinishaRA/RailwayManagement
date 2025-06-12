
const Train = require('../../models').train;
const Station = require('../../models').stations;
const Schedule = require('../../models').schedule;
const Routes = require('../../models').routes;
const ClassType = require('../../models').classType;
const SeatAvailability = require('../../models').seatAvailability;
const Price = require('../../models').price;
const { to, TE } = require('../../globalfunctions');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;

/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createTrainDetails
 * Async function, create train details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createTrainDetails = async function (data) {
  const [err, trainDetails] = await to(Train.create(data));
  if (err) return TE(err.message);
  if (trainDetails) return trainDetails;
};
module.exports.createTrainDetails = createTrainDetails;

const createStation = async function (data) {
  const [err, stationDetails] = await to(Station.create(data));
  if (err) return TE(err.message);
  if (stationDetails) return stationDetails;
};
module.exports.createStation = createStation;

const createScheduleDetails = async function (data) {
  const [err, scheduleDetails] = await to(Schedule.create(data));
  if (err) return TE(err.message);
  if (scheduleDetails) return scheduleDetails;
};
module.exports.createScheduleDetails = createScheduleDetails;

const createRoutesDetails = async function (data) {
  const [err, routesDetails] = await to(Routes.create(data));
  if (err) return TE(err.message);
  if (routesDetails) return routesDetails;
};
module.exports.createRoutesDetails = createRoutesDetails;

const createClassType = async function (data) {
  const [err, classTypeDetails] = await to(ClassType.create(data));
  if (err) return TE(err.message);
  if (classTypeDetails) return classTypeDetails;
};
module.exports.createClassType = createClassType;

const createSeatAvailability = async function (data) {
  const [err, scheduleDetails] = await to(SeatAvailability.create(data));
  if (err) return TE(err.message);
  if (scheduleDetails) return scheduleDetails;
};
module.exports.createSeatAvailability = createSeatAvailability;

const createPriceDetail = async function (data) {
  const [err, priceDetails] = await to(Price.create(data));
  if (err) return TE(err.message);
  if (priceDetails) return priceDetails;
};
module.exports.createPriceDetail = createPriceDetail;

const getTrainDetails = async function (data) {
  let srcTrainIDs = [], desTrainIDs = [], result = {};
  console.log('data', data);
  //using src name,des name get the stations and its train routes.
  const [err, stationData] = await to(getRoutesWithStation(data));
  if (err) { return TE(err.message); }
  if (stationData.length) {
    // Check train availability between source and destination.
    for (let i = 0; i < stationData.length; i++) {
      if (stationData[i].stationName === data.srcName) {
        srcTrainIDs = stationData[i].routes.map(route => ({
          trainId: route.trainId,
          departureTime: route.departureTime,
          srcStopNumber: route.sequenceNumber
        }));
        result['srcName'] = data.srcName; //update in result
      } else if (stationData[i].stationName === data.desName) {
        desTrainIDs = stationData[i].routes.map(route => ({
          trainId: route.trainId,
          arrivalTime: route.arrivalTime,
          desStopNumber: route.sequenceNumber
        }));
        result['desName'] = data.desName; //update in result
      }
      else {
        console.log("No Train routes between this stations.");
      }
    }
    // if src trainID and des trainID same means get arr time, dep time and order sequence of stop.
    if (srcTrainIDs.length && desTrainIDs.length) {
      const commonTrainDetails = srcTrainIDs.filter(srcTrain =>
        desTrainIDs.some(desTrain =>
          desTrain.trainId === srcTrain.trainId && srcTrain.srcStopNumber < desTrain.desStopNumber
        )
      ).map(srcTrain => {
        const desTrain = desTrainIDs.find(desTrain => desTrain.trainId === srcTrain.trainId);
        return {
          trainId: srcTrain.trainId,
          departureTime: srcTrain.departureTime,
          arrivalTime: desTrain.arrivalTime,
          srcStopNumber: srcTrain.srcStopNumber,
          desStopNumber: desTrain.desStopNumber
        };
      }
      );
      result['TrainDetails'] = commonTrainDetails; //update in result
      if (commonTrainDetails.length) {
        for (let i = 0; i < commonTrainDetails.length; i++) {
          console.log('commonTrainDetails', commonTrainDetails);
          //get train number ,name and its type.
          const [er, trainData] = await to(getOneTrainDetail(commonTrainDetails[i].trainId));
          if (er) return TE(er.message);
          result.TrainDetails[i]['TrainNumber'] = trainData.trainNumber;
          result.TrainDetails[i]['TrainName'] = trainData.name;
          result.TrainDetails[i]['TrainType'] = trainData.trainType;
          //after getting train details - check schedule date for train availability.
          const [err, scheduleData] = await to(getScheduleDate({
            trainId: commonTrainDetails[i].trainId,
            scheduleDate: data.scheduleDate
          }));
          if (err) { return TE(err.message); }
          console.log("scheduleData", scheduleData);

          result.TrainDetails[i]['scheduleId'] = scheduleData.dataValues.scheduleId; //update in result
          result.TrainDetails[i]['scheduleDate'] = scheduleData.date; //update in result
          //after checking schedule date - we need to check seats availability.
          const [error, seatAvailability] = await to(getAvailableSeats({
            scheduleId: scheduleData.dataValues.scheduleId,
            trainId: commonTrainDetails[i].trainId,
          }));
          if (error) return TE(error.message);
          result.TrainDetails[i]['seatsDetails'] = seatAvailability; //update in result
          //after checking seats - check its classtypes and its price.
          const [errr, priceDetails] = await to(getPriceForClassType({
            scheduleId: scheduleData.dataValues.scheduleId,
          }));
          if (errr) return TE(errr.message);
          // combine seats and its price detail
          result.TrainDetails[i].seatsDetails = result.TrainDetails[i].seatsDetails.map(seat => {
            const priceDetail = priceDetails.find(price => price.classType.className === seat.className);
            return {
              ...seat,
              price: priceDetail ? priceDetail.price : null // Add price 
            };
          });
        }
      } else {
        return TE('No common trains found between source and destination.');
      }
    } else {
      return TE('No trains found for the given source or destination.');
    }
    return result;
  }
};
module.exports.getTrainDetails = getTrainDetails;

const getRoutesWithStation = async function (data) {
  const [err, stationDetails] = await to(Station.findAll({
    where: {
      [Op.or]: [
        { stationName: { [Op.iLike]: data.srcName } },
        { stationName: { [Op.iLike]: data.desName } }
      ]
    },
    attributes: ['id', 'stationName'],
    include:
    {
      model: Routes,
      attributes: ['trainId', 'arrivalTime', 'departureTime', 'sequenceNumber']
    }
  }));
  if (err) { return TE(err.message) }
  if (stationDetails) {
    return stationDetails;
  }
};
module.exports.getRoutesWithStation = getRoutesWithStation;

const getAvailableSeats = async function (data) {
  let result = [];
  const [err, seatData] = await to(
    SeatAvailability.findAll({
      where: {
        scheduleId: data.scheduleId,
        trainId: data.trainId
      },
      attributes: ['availableSeats'],
      include: [
        {
          model: ClassType,
          attributes: ['className']
        }
      ]
    })
  );

  if (err) {
    console.error('Error fetching seat data:', err.message);
    return TE(err.message);
  }
  if (seatData.length > 0) {
    seatData.forEach((seat) => {
      result.push({
        className: seat.classType.className,
        availableSeats: seat.availableSeats
      });
    });
  } else {
    console.log('No seat data found for the given scheduleId and trainId.');
  }
  console.log('result', result);

  return result;
};
module.exports.getAvailableSeats = getAvailableSeats;

const getScheduleDate = async function (data) {
  const [err, scheduleData] = await to(Schedule.findOne({
    where: {
      date: data.scheduleDate,
      trainId: data.trainId
    },
    attributes: ['date', 'trainId', 'routesId', ['id', 'scheduleId']]
  }));
  if (err) { return TE(err.message) };
  if (scheduleData) { return scheduleData };
};
module.exports.getScheduleDate = getScheduleDate;

const getPriceForClassType = async function (data) {
  let result = [];
  const [err, priceDetails] = await to(Price.findAll({
    where: {
      scheduleId: data.scheduleId
    },
    attributes: ['price'],
    include: [
      {
        model: ClassType,
        attributes: ['className']
      }
    ]
  }));
  if (err) { return TE(err.message); }
  if (priceDetails) {
    console.log('pricedetails', priceDetails);
    if (priceDetails.length > 0) {
      priceDetails.forEach((p) => {
        result.push({
          price: p.price,
          classType: p.classType
        })
      })
    }
    console.log('result', result);
    return result;
  }
};
module.exports.getPriceForClassType = getPriceForClassType;

const getOneTrainDetail = async function (trainID) {
  console.log('trainID', trainID);
  const [err, data] = await to(Train.findOne({
    where: {
      id: trainID
    },
    attributes: ['name', 'trainNumber', 'trainType']
  }));
  if (err) { return TE(err.message); }
  if (data) { return data; }
};

const getAllStations = async function () {
  const [err, stations] = await to(Station.findAll());
  if (err) {
    return TE(err.message);
  }
  else {
    return stations;
  }
};
module.exports.getAllStations = getAllStations;

const getTrainStops = async function (data) {
  const [err, stops] = await to(Routes.findAll(
    {
      where: {
        trainId: data,
      },
      attributes: ['sequenceNumber', 'departureTime', 'arrivalTime'],
      include: [{
        model: Station,
        attributes: ['stationName']
      }]
    }
  ));
  if (err) {
    return TE(err.message);
  }
  else {
    const transformedStops = stops.map(stop => ({
      sequenceNumber: stop.sequenceNumber,
      departureTime: stop.departureTime,
      arrivalTime: stop.arrivalTime,
      station: stop.station.stationName
    }));
    return transformedStops;
  }
};
module.exports.getTrainStops = getTrainStops;

const getTrainDetailById = async function (trainId, scheduleDate) {
  console.log(typeof (trainId), trainId);
  const [err, trainDetails] = await to(Train.findOne({
    where: {
      id: Number(trainId)
    },
    include: [
      {
        model: Schedule,
        attributes: ['id'],
        where: { date: scheduleDate },
        include: [{
          model: Price,
          attributes: ['price'],
          include: [{
            model: ClassType,
            attributes: ['className'],

          }]
        }]
      }
    ],
    attributes: ['id', 'trainNumber', 'name', 'trainType']
  }));
  if (err) {
    return TE(err.message);
  } else if (!trainDetails) {
    return TE('No train found with the provided ID and schedule date.');
  }
  // Constructing the desired response format
  let result = {
    id: trainDetails.id,
    trainNumber: trainDetails.trainNumber,
    name: trainDetails.name,
    trainType: trainDetails.trainType,
    prices: []
  };

  // Looping through the schedules and their prices
  const schedule = trainDetails.schedules[0];  // Assuming 1 schedule per train
  if (schedule && Array.isArray(schedule.prices)) {
    schedule.prices.forEach(priceData => {
      result.prices.push({
        price: priceData.price,
        classType: priceData.classType ? priceData.classType.className : null
      });
    });
  } else {
    console.log("No price data found for the schedule.");
  }

  return result;
};
module.exports.getTrainDetailById = getTrainDetailById;


