'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('Employers', {
      Id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      CompanyName: {
        allowNull: true,
        type: Sequelize.STRING
      },
      Logo: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Description: {
        type: Sequelize.STRING,
        allowNull: true
      },
      Hotline: {
        type: Sequelize.STRING,
        allowNull: true
      },
      Address: {
        type: Sequelize.STRING,
        allowNull: true
      },
      UserId: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Users',
          key: 'Id'
        }
      }
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('Employers');
  }
};
