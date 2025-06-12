const BookingService = require('../../services/RailwaySystem/booking.service');
const { ReE, ReS, to } = require('../../globalfunctions');
const router = require('express').Router({ mergeParams: true });

const createBooking = async function (req, res) {
  const [err, data] = await to(BookingService.createBooking(req.body));
  if (err) {
    return ReE(res, err, 422);
  }
  else {
    console.log('Booking created successfully : ', data);
    return ReS(res, data, 200);
  }
};

const createPayment = async function (req, res) {
  const [err, data] = await to(BookingService.createPayment(req.body));
  if (err) {
    return ReE(res, err, 422);
  }
  else {
    console.log('Payment created successfully : ', data);
    return ReS(res, data, 200);
  }
};

const getBookingDetails = async function (req, res) {
  const [err, data] = await to(BookingService.getBookingDetails(req.params.id));
  if (err) {
    return ReE(res, err, 422);
  }
  else {
    console.log('Booking details fetched successfully : ', data);
    return ReS(res, data, 200);
  }
}

router.post('/book', createBooking);
router.post('/pay', createPayment);
router.get('/booking-details/:id', getBookingDetails);
module.exports.router = router;