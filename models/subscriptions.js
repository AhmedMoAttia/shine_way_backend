/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('subscriptions', {
    id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      primaryKey: true
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    },
    price: {
      type: "UNSIGNED float",
      allowNull: false
    },
    duration: {
      type: DataTypes.DATE,
      allowNull: false
    }
  }, {
    tableName: 'subscriptions',
    timestamps: false
  });
};
