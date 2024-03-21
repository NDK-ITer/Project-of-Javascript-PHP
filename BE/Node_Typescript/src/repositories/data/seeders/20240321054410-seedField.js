'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('fields', [
      {
        Id: '16fcd2f3-bb5b-4b71-845f-cd9b3247ac2c',
        Name: 'Information Technology',
      },
      {
        Id: 'fbe32343-f370-4145-8920-3da594956d24',
        Name: 'Marketing',
      },
      {
        Id: '8756fedb-89c6-44a2-bfd7-094eb28e03bb',
        Name: 'Education',
      },
      {
        Id: 'ebc83ba6-6603-486b-939f-579b0e4155a4',
        Name: 'Car technology',
      }
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('Fields');
  }
};
