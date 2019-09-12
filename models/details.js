/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('details', {
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
    title: {
      type: DataTypes.STRING(64),
      allowNull: false
    },
    description: {
      type: DataTypes.STRING(1000),
      allowNull: true
    },
    language: {
      type: "UNSIGNED int",
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
    },
    subscriptionId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'subscriptions',
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
    voucherId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'vouchers',
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
    tableName: 'details',
    timestamps: false
  });
};
