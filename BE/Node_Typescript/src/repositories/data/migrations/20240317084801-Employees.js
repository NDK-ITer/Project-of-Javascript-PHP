'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('Employees', {
      Id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING,
        references: {
          model: 'Users',
          key: 'Id'
        }
      },
      FullName: {
        type: Sequelize.STRING,
        allowNull: false
      },
      Avatar: {
        type: Sequelize.STRING,
        allowNull: true
      },
      PhoneNumber: {
        type: Sequelize.STRING,
        allowNull: true
      },
      Introduction: {
        type: Sequelize.STRING,
        allowNull: true
      },
      Certification: {
        type: Sequelize.STRING,
        allowNull: true
      },
      CV: {
        type: Sequelize.STRING,
        allowNull: true
      },
      Gender:{
        type: Sequelize.STRING,
        allowNull: true
      },
      Address:{
        type: Sequelize.STRING,
        allowNull: true
      },
      Born: {
        type: Sequelize.DATE,
        allowNull: false
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
    await queryInterface.dropTable('Employees');
  }
};
