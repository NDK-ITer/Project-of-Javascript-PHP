import { Sequelize } from 'sequelize-typescript';
import { User } from '../data/models/User';
import { Role } from '../data/models/Role';
import { RecruitmentArticle } from '../data/models/RecruitmentArticle';
import { Field } from '../data/models/Field';
import { Enjoy } from '../data/models/Enjoy';
import { Employer } from '../data/models/Employer';
import { Employee } from '../data/models/Employee';
import { DetailRecruitment } from '../data/models/DetailRecruitment';

const ConnectDatabase = new Sequelize({
    database: 'FindJob',
    username:'root',
    password: '',
    host: 'localhost',
    port: 1433,
    dialect: 'mssql',
});

ConnectDatabase.addModels([User]);
ConnectDatabase.addModels([Role]);
ConnectDatabase.addModels([RecruitmentArticle]);
ConnectDatabase.addModels([Field]);
ConnectDatabase.addModels([Enjoy]);
ConnectDatabase.addModels([Employer]);
ConnectDatabase.addModels([Employee]);
ConnectDatabase.addModels([DetailRecruitment]);

export { ConnectDatabase };
