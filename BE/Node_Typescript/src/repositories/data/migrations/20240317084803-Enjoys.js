'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('Enjoys', {
      EmployeeId: {
        type: Sequelize.STRING,
        primaryKey: true,
        references: {
          model: 'Employees',
          key: 'Id'
        }
      },
      RA_Id: {
        type: Sequelize.STRING,
        primaryKey: true,
        references: {
          model: 'RecruitmentArticles',
          key: 'Id'
        }
      }
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('Enjoys');
  }
};
