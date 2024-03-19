'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('Users', {
      Id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      Email: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Password: {
        type: Sequelize.STRING,
        allowNull: false
      },
      IsBlock: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
        defaultValue: false
      },
      CreateDate: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },
      UpdateDate: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },
      RoleId: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'roles',
          key: 'id'
        }
      }
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('Users');
  }
};
