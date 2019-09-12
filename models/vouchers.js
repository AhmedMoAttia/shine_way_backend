/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('vouchers', {
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
    number: {
      type: "UNSIGNED INTEGER",
      allowNull: false
    },
    placeId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'places',
        key: 'id'
      }
    }
  }, {
    tableName: 'vouchers',
    timestamps: false
  });
};
