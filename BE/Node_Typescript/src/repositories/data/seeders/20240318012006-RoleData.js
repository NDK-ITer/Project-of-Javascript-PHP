'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('roles', [
      {
        Id: '0325ed0a-d2dd-4de5-9ce6-1e0a51b9791c',
        Name: 'Admin',
        NormalizeName: 'ADMIN'
      },
      {
        Id: 'f09b3e4e-86bb-4367-a84f-1f14acddc4bc',
        Name: 'Employer',
        NormalizeName: 'EMPLOYER'
      },
      {
        Id: 'b947a44b-a827-412a-8d1d-8def7df24d12',
        Name: 'Employee',
        NormalizeName: 'EMPLOYEE'
      }
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('Roles');
  }
};
