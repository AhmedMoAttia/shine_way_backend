/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_voucher_junctions', {
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    },
    serial: {
      type: DataTypes.STRING(100),
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
    voucherId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'vouchers',
        key: 'id'
      }
    }
  }, {
    tableName: 'user_voucher_junctions',
    timestamps: false
  });
};
