const TrainService = require('../../services/RailwaySystem/train.service');
const { to, ReE, ReS } = require('../../globalfunctions');
const router = require('express').Router({ mergeParams: true });

/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createTraindetails
 * Async function, create train details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createTrainDetails = async function (req, res) {
  if (req.body) {
    const [err, trainDetails] = await to(TrainService.createTrainDetails(req.body));
    if (err) { return ReE(res, err, 422); }
    if (trainDetails) { return ReS(res, trainDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createStation
 * Async function, create station details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createStation = async function (req, res) {
  if (req.body) {
    const [err, stationDetails] = await to(TrainService.createStation(req.body));
    if (err) { return ReE(res, err, 422); }
    if (stationDetails) { return ReS(res, stationDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createScheduleDetails
 * Async function, create schedule details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createScheduleDetails = async function (req, res) {
  if (req.body) {
    const [err, scheduleDetails] = await to(TrainService.createScheduleDetails(req.body));
    if (err) { return ReE(res, err, 422); }
    if (scheduleDetails) { return ReS(res, scheduleDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createRoutesDetails
 * Async function, create routes details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createRoutesDetails = async function (req, res) {
  if (req.body) {
    const [err, routesDetails] = await to(TrainService.createRoutesDetails(req.body));
    if (err) { return ReE(res, err, 422); }
    if (routesDetails) { return ReS(res, routesDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createClassType
 * Async function, create class type details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createClassType = async function (req, res) {
  if (req.body) {
    const [err, classTypeDetails] = await to(TrainService.createClassType(req.body));
    if (err) { return ReE(res, err, 422); }
    if (classTypeDetails) { return ReS(res, classTypeDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createSeatAvailability
 * Async function, create seat availability.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createSeatAvailability = async function (req, res) {
  if (req.body) {
    const [err, scheduleDetails] = await to(TrainService.createSeatAvailability(req.body));
    if (err) { return ReE(res, err, 422); }
    if (scheduleDetails) { return ReS(res, scheduleDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : createPriceDetail
 * Async function, create price details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createPriceDetail = async function (req, res) {
  if (req.body) {
    const [err, priceDetails] = await to(TrainService.createPriceDetail(req.body));
    if (err) { return ReE(res, err, 422); }
    if (priceDetails) { return ReS(res, priceDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 21-08-2024
 * Modified on     : 21-08-2024
 * Function        : getTraindetails
 * Async function, get train data.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const getTrainDetails = async function (req, res) {
  console.log("query", req.query);
  if (req.query) {
    const { srcName, desName, scheduleDate } = req.query;
    const data = {
      srcName,
      desName,
      scheduleDate
    };
    const [err, traindata] = await to(TrainService.getTrainDetails(data));
    if (err) {
      console.log('1111111111111', err);
      return ReE(res, err, 422);
    }
    console.log("traindata", traindata);
    if (traindata) { return ReS(res, traindata, 200); }
  }
};

const getAllStations = async function (req, res) {
  const [err, data] = await to(TrainService.getAllStations());
  if (err) {
    return ReE(res, err, 422);
  }
  if (data) {
    return ReS(res, data, 200);
  }
};

const getTrainStops = async function (req, res) {
  console.log(req.query);
  const [err, data] = await to(TrainService.getTrainStops(req.query.trainID));
  if (err) {
    return ReE(res, err, 422);
  }
  if (data) {
    return ReS(res, data, 200);
  }
};

const getTrainDetailById = async function (req, res) {
  const [err, data] = await to(TrainService.getTrainDetailById(req.params.id,req.query.scheduleDate));
  if (err) {
    return ReE(res, err, 422);
  }
  else {
    return ReS(res, data, 200);
  }
};

router.get('/details', getTrainDetails);
router.get('/stations', getAllStations);
router.get('/stops', getTrainStops);
router.get('/details/:id', getTrainDetailById);

module.exports.router = router;