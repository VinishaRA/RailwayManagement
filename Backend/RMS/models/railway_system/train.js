module.exports = (db, sequelize) => {
  const train = db.define('train', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    name: {
      type: sequelize.STRING,
      allowNull: false
    },
    trainNumber: {
      type: sequelize.STRING,
      allowNull: false
    },
    trainType: {
      type: sequelize.ENUM('Express', 'Passenger', 'Local'),
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
      tableName: 'train', schema: 'railway_system'
    });
  train.associate = (models) => {
    train.hasMany(models.routes, { foreignKey: 'trainId' });
    train.hasMany(models.schedule, { foreignKey: 'trainId' });
    train.hasMany(models.booking, { foreignKey: 'trainId' });
    train.hasMany(models.seatAvailability, { foreignKey: 'trainId' });
  }
  return train;
}