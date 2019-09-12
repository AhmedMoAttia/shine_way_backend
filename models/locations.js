/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('locations', {
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
    latitude: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    longitude: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    area: {
      type: "UNSIGNED float",
      allowNull: true
    },
    placeId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'places',
        key: 'id'
      }
    },
    advertisementId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'advertisements',
        key: 'id'
      }
    }
  }, {
    tableName: 'locations',
    timestamps: false
  });
};
