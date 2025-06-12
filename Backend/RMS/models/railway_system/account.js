
module.exports = (db, sequelize) => {
  const account = db.define('account', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    bankName: {
      type: sequelize.STRING,
      allowNull: false
    },
    accountNumber: {
      type: sequelize.STRING,
      allowNull: false
    },
    ifscCode: {
      type: sequelize.STRING,
      allowNull: false
    },
    accountHolderName: {
      type: sequelize.STRING,
      allowNull: false
    },
    phoneNumber: {
      type: sequelize.STRING,
      allowNull: false
    },
    email: {
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
      tableName: 'account', schema: 'railway_system'
    });
  account.associate = (models) => {
    account.belongsTo(models.booking, { foreignKey: 'bookingId' });
  }
  return account;

}