var fs = require('fs');
var path = require('path');
const Sequelize = require('sequelize');
var basename = path.basename(__filename);
require('../config/config');
require('../config/constants');
// console.log(path);
const db = {};
//database name, user, password
const sequelize = new Sequelize(CONFIG.db_name, CONFIG.db_user, CONFIG.db_password, {
  //'mysql', 'sqlite', 'postgres', 'mssql'
  dialect: 'postgres',
  //default is localhost
  host: CONFIG.db_host,
  //optional, default value is 3306
  port: CONFIG.db_port,
  //default value is console.log
  logging: console.log,
  define: {
    timestamps: false,
    // paranoid: true,
    underscored: true
  }
});
console.log('basename', basename);
console.log(__dirname);
const schemaCreate = async function () {
  var schemas = await sequelize.showAllSchemas().then(
    (s) => {
      console.log("s", s);
      CONSTANT.SCHEMAS.forEach((item) => {
        if (s.indexOf(item) < 0) {
          console.log("item", item);
          sequelize.createSchema(item).then((res) => { });
        }
      });
    },
    (err) => {
      console.log("in err", err);
    }
  );
  return schemas;
};
CONSTANT.SCHEMAS.forEach((item) => {
  console.log("item", item);
  fs.readdirSync(__dirname + "/" + item)
    .filter((file) => {
      // console.log(fs.readdirSync(__dirname + "/" + item));
      // console.log("file", file);

      return (
        file.indexOf(".") !== 0 &&
        file !== basename &&
        file.slice(-3) === ".js"
      );
    })
    .forEach((file) => {
      // console.log(file, "in file val");
      // if (file.indexOf('users.js') >= 0) {
      var model = require(path.join(__dirname + "/" + item, file))(
        sequelize,
        Sequelize.DataTypes
      );
      // console.log('model',model);
      
      // console.log(path.join(__dirname + "/" + item, file));
      // console.log(db[file.slice(0, -3)] = model);
      db[file.slice(0, -3)] = model;
      // }
    });
});
// console.log(db);
Object.keys(db).forEach(modelName => {
  // console.log('modelName',modelName);
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});
db.schemaCreate = schemaCreate();
db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
