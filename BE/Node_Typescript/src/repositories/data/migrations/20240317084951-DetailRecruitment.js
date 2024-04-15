'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('DetailRecruitment', {
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
      },
      DateRecruitment: {
        type: Sequelize.DATE,
        allowNull: false
      },
      CVApply: {
        type: Sequelize.STRING,
        allowNull: false
      }
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('DetailRecruitment');
  }
};
