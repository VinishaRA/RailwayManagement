const User = require('../../models').user;
const { to, TE } = require('../../globalfunctions');

const createUserDetails = async function (data) {
  const [err, userDetails] = await to(User.create(data));
  if (err) return TE(err.message);
  if (userDetails) return userDetails;
};
module.exports.createUserDetails = createUserDetails;

const checkUserDetails = async function (data) {
  const [err, userDetails] = await to(User.findOne({
    where: {
      email: data.email,
      password: data.password,
      role: data.role
    }
  }));
  if (err) return TE(err.message);
  if (userDetails) return userDetails;
};
module.exports.checkUserDetails = checkUserDetails;