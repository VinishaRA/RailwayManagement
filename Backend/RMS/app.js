var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
models = require("./models/index.js"); // Import database models
var indexRouter = require('./routes/index');
const cors = require('cors');
app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/v1', indexRouter);

//DB connection and schema & table creation
models.sequelize.authenticate()
  .then(() => {
    console.log("Connected to postgres database:", CONFIG.db_name);
    const shema = models.schemaCreate.then(() => {
      models.sequelize.sync().then(async () => {
      });
    });
  })
  .catch((err) => {
    console.error(
      "Unable to connect to Postgres database:",
      CONFIG.db_name,
      err.message
    );
  });

app.use(function (req, res, next) {
  // Website you wish to allow to connect
  res.setHeader("Access-Control-Allow-Origin", "*");
  // Request methods you wish to allow
  res.setHeader("Access-Control-Allow-Methods", "GET, POST,PUT, , OPTIONS");
  // Request headers you wish to allow
  res.setHeader(
    "Access-Control-Allow-Headers",
    "X-Requested-With, content-type, Authorization, Content-Type"
  );
  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  res.setHeader("Access-Control-Allow-Credentials", true);
  // Disable option for catch the response
  res.setHeader("Cache-Control", "no-cache ,no-store");
  // Pass to next layer of middleware
  next();
});


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
