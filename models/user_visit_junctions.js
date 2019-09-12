/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_visit_junctions', {
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'users',
        key: 'id'
      }
    },
    visitId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'visits',
        key: 'id'
      }
    }
  }, {
    tableName: 'user_visit_junctions',
    timestamps: false
  });
};
