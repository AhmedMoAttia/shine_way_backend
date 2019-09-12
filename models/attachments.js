/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('attachments', {
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
    url: {
      type: DataTypes.STRING(200),
      allowNull: false
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
    },
    advertisementId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'advertisements',
        key: 'id'
      }
    },
    visitId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'visits',
        key: 'id'
      }
    }
  }, {
    tableName: 'attachments',
    timestamps: false
  });
};
