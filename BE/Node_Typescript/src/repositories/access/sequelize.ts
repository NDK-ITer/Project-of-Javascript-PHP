import { Sequelize } from 'sequelize-typescript';

const sequelize = new Sequelize('mssql://localhost:1433/your_database?dialectOptions=trustedConnection:true');

export { sequelize };
