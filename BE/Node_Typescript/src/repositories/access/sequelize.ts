import { Sequelize } from 'sequelize-typescript';

const sequelize = new Sequelize({
    database: 'FindJob',
    dialect: 'mssql',
    host: 'localhost',
    port: 1433,
    username:'sa',
    password: 'sa',
    dialectOptions: {
        trustedConnection: true
    }
});

export { sequelize };
