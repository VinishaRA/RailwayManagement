module.exports = (db, sequelize) => {
  const price = db.define('price', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    price: {
      type: sequelize.INTEGER,
      allowNull : false
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
    tableName: 'price', schema: 'railway_system'
    });
  price.associate = (models) => {
    price.belongsTo(models.schedule, { foreignKey: 'scheduleId' });
    price.belongsTo(models.classType, { foreignKey: 'classTypeId' });
  };
  return price;
}