const Booking = require('../../models').booking;
const PersonDetails = require('../../models').person;
const Account = require('../../models').account;
const Payment = require('../../models').payment;
const Train = require('../../models').train;
const Person = require('../../models').person;
const SeatAvailability = require('../../models').seatAvailability;
const { to, TE } = require('../../globalfunctions');

const createBooking = async function (body) {
  const bookingDetails = { ...body.payment, trainId: body.trainId, userId: body.userId, scheduleId: body.scheduleId };
  console.log('bookingDetails', bookingDetails);
  const [err1, bookingData] = await to(Booking.create(bookingDetails));
  if (err1) {
    console.log("err1", err1);
    return TE(err1.message);
  }
  if (bookingData) {
    const personsData = body.persons.map(person => ({
      ...person,
      bookingId: bookingData.id // Assign the bookingId to each person
    }));
    const [err2, personDetails] = await to(PersonDetails.bulkCreate(personsData));
    if (err2) {
      console.log("err2", err2);
      return TE(err2.message);
    }
    const accountData = { ...body.account, bookingId: bookingData.id };
    const [err3, accountDetails] = await to(Account.create(accountData));
    if (err3) {
      console.log("err3", err3);
      return TE(err3.message);
    }
    const [err4, seatAvailability] = await to(SeatAvailability.findOne({
      where: {
        trainId: body.trainId,
        scheduleId: body.scheduleId
      }
    }));
    if (err4) {
      console.log("err4", err4);
      return TE(err4.message);
    }
    const bookedSeats = body.persons.length;
    const newAvailableSeats = seatAvailability.availableSeats - bookedSeats;
    if (seatAvailability) {
      const [err5, updatedSeatAvailability] = await to(SeatAvailability.update({
        availableSeats: newAvailableSeats
      },
        {
          where: {
            trainId: body.trainId,
            scheduleId: body.scheduleId
          }
        }));
      if (err5) {
        console.log("err5", err5);
        return TE(err5.message);
      }
      console.log('updatedSeatAvailability', updatedSeatAvailability);

    }
    return { bookingData, personDetails, accountDetails };
  }
}
module.exports.createBooking = createBooking;

const createPayment = async function (data) {
  const [err, paymentDetails] = await to(Payment.create(data));
  if (err) {
    return TE(err.message);
  }
  return paymentDetails;
}
module.exports.createPayment = createPayment;

const getBookingDetails = async function (data) {
  const [err, bookingDetails] = await to(Booking.findAll({
    where: { userId: data },
    include: [
      {
        model: Train,
      }, {
        model: Person
      }
    ]
  }));
  if (err) {
    return TE(err.message);
  }
  return bookingDetails;
};
module.exports.getBookingDetails = getBookingDetails;