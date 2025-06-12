module.exports = (db, sequelize) => {
  const payment = db.define('payment', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    amount: {
      type: sequelize.INTEGER,
      allowNull: false
    },
    paymentDate: {
      type: sequelize.DATE,
      defaultValue: sequelize.NOW
    },
    paymentStatus: {
      type: sequelize.ENUM('Success', 'Failed'),
      defaultValue: 'Success',
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
      tableName: 'payment', schema: 'railway_system'
    });
  payment.associate = (models) => {
    payment.belongsTo(models.booking, { foreignKey: 'bookingId' });
  }
  return payment;
}