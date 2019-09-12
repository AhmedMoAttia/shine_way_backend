/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('visits', {
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
    live: {
      type: "bool",
      allowNull: false,
      defaultValue: '0'
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'users',
        key: 'id'
      }
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
    tableName: 'visits',
    timestamps: false
  });
};
