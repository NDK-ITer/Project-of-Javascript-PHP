import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { Employee } from './Employee';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class Enjoy extends Model {
    @ForeignKey(() => Employee)
    @Column({ primaryKey: true })
    EmployeeId!: string;

    @ForeignKey(() => RecruitmentArticle)
    @Column({ primaryKey: true })
    RA_Id!: string;
}

export { Enjoy }