'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('RecruitmentArticles', {
      Id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      Name: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Description: {
        type: Sequelize.STRING,
        allowNull: false
      },
      DateUpload: {
        type: Sequelize.DATE,
        allowNull: false
      },
      Requirement: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Image: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Salary: {
        type: Sequelize.STRING,
        allowNull: false
      },
      AddressWork: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Position: {
        type: Sequelize.STRING,
        allowNull: false
      },
      IsApproved: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
        defaultValue: false
      },
      View: {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 0
      },
      EndSubmission: {
        type: Sequelize.DATE,
        allowNull: false
      },
      AgeEmployee: {
        type: Sequelize.STRING,
        allowNull: false
      },
      CountEmployee: {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 0
      },
      FormOfWork: {
        type: Sequelize.STRING,
        allowNull: false
      },
      YearOfExpensive: {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 0
      },
      Degree: {
        type: Sequelize.STRING,
        allowNull: false
      },
      EmployerId: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Employers',
          key: 'Id'
        }
      },
      FieldId: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Fields',
          key: 'Id'
        }
      }
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('RecruitmentArticles');
  }
};
