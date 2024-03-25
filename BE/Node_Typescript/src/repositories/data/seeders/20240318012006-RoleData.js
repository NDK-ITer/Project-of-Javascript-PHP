'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('roles', [
      {
        Id: '0325ed0a-d2dd-4de5-9ce6-1e0a51b9791c',
        Name: 'ADMIN',
        NormalizeName: 'Admin'
      },
      {
        Id: 'f09b3e4e-86bb-4367-a84f-1f14acddc4bc',
        Name: 'EMPLOYER',
        NormalizeName: 'Employer'
      },
      {
        Id: 'b947a44b-a827-412a-8d1d-8def7df24d12',
        Name: 'EMPLOYEE',
        NormalizeName: 'Employee'
      }
    ]);
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
