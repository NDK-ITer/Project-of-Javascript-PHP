import { Sequelize } from 'sequelize-typescript';
import { User } from '../data/models/User';
import { Role } from '../data/models/Role';
import { RecruitmentArticle } from '../data/models/RecruitmentArticle';
import { Field } from '../data/models/Field';
import { Enjoy } from '../data/models/Enjoy';
import { Employer } from '../data/models/Employer';
import { Employee } from '../data/models/Employee';
import { DetailRecruitment } from '../data/models/DetailRecruitment';
const config = require('../../../config.json');

const sequelize = new Sequelize(config.development.database, config.development.username, config.development.password, {
    host: config.development.host,
    port: config.development.port,
    dialect: 'mysql'
});

const models = [
    User,
    Role,
    RecruitmentArticle,
    Field,
    Enjoy,
    Employer,
    Employee,
    DetailRecruitment
];

sequelize.addModels(models);


let ConnectDatabase = async () => {
    await sequelize.authenticate().then(() => {
        console.log('Connect data is successful');
    }).catch((error: any) => {
        console.error('Error synchronizing database:', error);
    });
}


export { ConnectDatabase };
