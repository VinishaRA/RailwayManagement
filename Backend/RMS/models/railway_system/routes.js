module.exports = (db, sequelize) => {
  const routes = db.define('routes', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    arrivalTime: {
      type: sequelize.DATE,
    },
    departureTime: {
      type: sequelize.DATE,
    },
    sequenceNumber: {
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
    tableName: 'routes', schema: 'railway_system'
    });
  routes.associate = (models) => {
    routes.belongsTo(models.train, { foreignKey: 'trainId' });
    routes.belongsTo(models.stations, { foreignKey: 'stationId' });
    routes.hasMany(models.schedule, { foreignKey: 'routesId' });
  };
  return routes;
}