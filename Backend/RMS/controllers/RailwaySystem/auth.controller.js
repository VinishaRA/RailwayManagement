const AuthService = require('../../services/RailwaySystem/auth.service');
const { to, ReE, ReS } = require('../../globalfunctions');
const router = require('express').Router({ mergeParams: true });
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 11-09-2024
 * Modified on     : 11-09-2024
 * Function        : createUserDetails
 * Async function, create user details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const createUserDetails = async function (req, res) {
  if (req.body) {
    const [err, userDetails] = await to(AuthService.createUserDetails(req.body));
    if (err) { return ReE(res, err, 422); }
    if (userDetails) { return ReS(res, userDetails, 201); }
  }
};
/**
 * Original Author : Vinisha R (CEN413)
 * Author          : Vinisha R (CEN413)
 * Created On      : 11-09-2024
 * Modified on     : 11-09-2024
 * Function        : checkUserDetails
 * Async function, check  user details.
 * @param {*} req have data to be insert.
 * @return res returns an response
*/
const checkUserDetails = async function (req, res) {
  if (req.query) {
    const [err, userDetails] = await to(AuthService.checkUserDetails(req.query));
    if (err) { return ReE(res, err, 422); }
    if (userDetails) { return ReS(res, userDetails, 201); }
  }
};

router.post('/signup', createUserDetails);
router.get('/signin', checkUserDetails);
module.exports.router = router;