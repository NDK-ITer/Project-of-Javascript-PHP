import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { Employee } from './Employee';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class DetailRecruitment extends Model {
    @ForeignKey(() => Employee)
    @Column({ primaryKey: true })
    EmployeeId!: string;

    @ForeignKey(() => RecruitmentArticle)
    @Column({ primaryKey: true })
    RA_Id!: string;

    @Column
    DateRecruitment!: Date;
}

export { DetailRecruitment }