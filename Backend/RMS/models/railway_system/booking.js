module.exports = (db, sequelize) => {
  const booking = db.define('booking', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    bookingDate: {
      type: sequelize.DATE,
      defaultValue: sequelize.NOW
    },
    personsCount: {
      type: sequelize.INTEGER,
      allowNull: false
    },
    totalFare: {
      type: sequelize.INTEGER,
      allowNull: false
    },
    price: {
      type: sequelize.INTEGER,
      allowNull: false
    },
    additionalCharge: {
      type: sequelize.INTEGER,
      allowNull: false
    },
    createdAt: {
      type: sequelize.DATE,
      defaultValue: sequelize.NOW
    },
    modifiedAt: {
      type: sequelize.DATE,
      defaultValue: sequelize.NOW
    },
    isDeleted: {
      type: sequelize.BOOLEAN,
      defaultValue: false
    }
  },
    {
      tableName: 'booking', schema: 'railway_system'
    });
  booking.associate = (models) => {
    booking.belongsTo(models.train, { foreignKey: 'trainId' });
    booking.belongsTo(models.user, { foreignKey: 'userId' });
    booking.belongsTo(models.schedule, { foreignKey: 'scheduleId' });
    booking.hasMany(models.person, { foreignKey: 'bookingId' });
    booking.hasOne(models.account, { foreignKey: 'bookingId' });
    booking.hasMany(models.payment, { foreignKey: 'bookingId' });
  }
  return booking;
}