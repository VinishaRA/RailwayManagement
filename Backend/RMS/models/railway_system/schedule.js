module.exports = (db, sequelize) => {
  const schedule = db.define('schedule', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    date: {
      type: sequelize.DATEONLY,
      allowNull: false,
      defaultValue: sequelize.NOW,
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
      tableName: 'schedule', schema: 'railway_system'
    });
  schedule.associate = (models) => {
    schedule.belongsTo(models.train, { foreignKey: 'trainId' });
    schedule.belongsTo(models.routes, { foreignKey: 'routesId' });
    schedule.hasMany(models.booking, { foreignKey: 'scheduleId' });
    schedule.hasMany(models.seatAvailability, { foreignKey: 'scheduleId' });
    schedule.hasMany(models.price, { foreignKey: 'scheduleId' });
  }
  return schedule;
}