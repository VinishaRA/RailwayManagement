module.exports = (db, sequelize) => {
  const stations = db.define('stations', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    stationName: {
      type: sequelize.STRING,
      allowNull: false
    },
    Location: {
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
    tableName: 'stations', schema: 'railway_system'
    });
    stations.associate = (models) => {
      stations.hasMany(models.routes, { foreignKey: 'stationId' });
   }
  return stations;
}