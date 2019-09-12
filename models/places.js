/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('places', {
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
    type: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: '0'
    },
    address: {
      type: DataTypes.STRING(200),
      allowNull: false
    },
    siteUrl: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    mapUrl: {
      type: DataTypes.STRING(200),
      allowNull: true
    }
  }, {
    tableName: 'places',
    timestamps: false
  });
};
