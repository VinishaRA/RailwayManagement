module.exports = (db,sequelize) => {
  const user = db.define('user', {
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: sequelize.INTEGER
    },
    name: {
      type: sequelize.STRING,
      allowNull: false
    },
    email: {
      type: sequelize.STRING,
      allowNull: false
    },
    password: {
      type: sequelize.STRING,
      allowNull: false
    },
    role: {
      type: sequelize.ENUM('Admin', 'User'),
      allowNull: false
    },
    phoneNumber: {
      type: sequelize.STRING,
      allowNull: false
    },
    address: {
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
      tableName: 'user', schema: 'railway_system'
    }
  );
  user.associate = (models) => {
    user.hasMany(models.booking, { foreignKey: 'userId' });
 }
  return user;
}
