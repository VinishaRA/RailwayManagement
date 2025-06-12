var express = require('express');
var router = express.Router();

/* GET home page. */
router.use('/train', require('../controllers/RailwaySystem/train.controller').router);
router.use('/auth', require('../controllers/RailwaySystem/auth.controller').router);
router.use('/ticket', require('../controllers/RailwaySystem/booking.controller').router);

module.exports = router;
