module.exports = (db, sequelize) => {
  const seatAvailability = db.define('seatAvailability', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    availableSeats: {
      type: sequelize.STRING,
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
    tableName: 'seat_availability', schema: 'railway_system'
    });
    seatAvailability.associate = (models) => {
      seatAvailability.belongsTo(models.train, { foreignKey: 'trainId' });
      seatAvailability.belongsTo(models.classType, { foreignKey: 'classTypeId' });
      seatAvailability.belongsTo(models.booking, { foreignKey: 'scheduleId' });
    }
  return seatAvailability;
}