import { Sequelize } from 'sequelize-typescript';
import { User } from '../data/models/User';
import { Role } from '../data/models/Role';
import { RecruitmentArticle } from '../data/models/RecruitmentArticle';
import { Field } from '../data/models/Field';
import { Enjoy } from '../data/models/Enjoy';
import { Employer } from '../data/models/Employer';
import { Employee } from '../data/models/Employee';
import { DetailRecruitment } from '../data/models/DetailRecruitment';

// const sequelize = new Sequelize({
//     database: 'FindJob',
//     username:'sa',
//     password: 'sa',
//     host: 'NDK-LAPTOP',
//     port: 1433,
//     dialect: 'mssql',
//     models: [User, Role, RecruitmentArticle, Field, Enjoy, Employer, Employee, DetailRecruitment]
// });

const sequelize = new Sequelize();

sequelize.addModels([User]);
sequelize.addModels([Role]);
sequelize.addModels([RecruitmentArticle]);
sequelize.addModels([Field]);
sequelize.addModels([Enjoy]);
sequelize.addModels([Employer]);
sequelize.addModels([Employee]);
sequelize.addModels([DetailRecruitment]);

let ConnectDatabase = async() =>{
    await sequelize.authenticate().then(() => {
        console.log('Database synchronized');
    }).catch((error: any) => {
        console.error('Error synchronizing database:', error);
    });
}


export { ConnectDatabase };
