module.exports = (db, sequelize) => {
  const classType = db.define('classType', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    className: {
      type: sequelize.ENUM('AC','General', 'Sleeper','Ladies'),
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
    tableName: 'class_type', schema: 'railway_system'
    });
  classType.associate = (model) => {
    classType.hasMany(model.seatAvailability,{foreignKey : 'classTypeId'})
    classType.hasMany(model.price,{foreignKey : 'classTypeId'})
    }
  return classType;
}