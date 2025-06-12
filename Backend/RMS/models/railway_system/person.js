
module.exports = (db, sequelize) => {
  const person = db.define('person', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    personName: {
      type: sequelize.STRING,
      allowNull: false
    },
    personAge: {
      type: sequelize.INTEGER,
      allowNull: false
    },
    gender: {
      type: sequelize.ENUM('Female', 'Male', 'Transgender'),
      allowNull: false
    },
    berthChoice: {
      type: sequelize.ENUM('Upper', 'Middle', 'Lower'),
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
      tableName: 'person', schema: 'railway_system'
    });
  person.associate = (models) => {
    person.belongsTo(models.booking, { foreignKey: 'bookingId' });
  }
  return person;
}