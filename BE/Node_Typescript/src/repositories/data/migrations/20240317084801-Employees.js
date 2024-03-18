'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('Employees', {
      Id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      Certification: {
        type: Sequelize.STRING,
        allowNull: true
      },
      CV: {
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
    await queryInterface.dropTable('Employees');
  }
};
