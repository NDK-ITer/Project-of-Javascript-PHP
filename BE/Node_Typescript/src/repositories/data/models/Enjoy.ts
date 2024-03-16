import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { Employee } from './Employee';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class Enjoy extends Model {
    @ForeignKey(() => Employee)
    @Column
    EmployeeId!: string;

    @ForeignKey(() => RecruitmentArticle)
    @Column
    RA_Id!: string;
}

export { Enjoy }