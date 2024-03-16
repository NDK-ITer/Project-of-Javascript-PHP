import { Table, Column, Model, HasOne, BelongsTo, BelongsToMany } from 'sequelize-typescript';
import { Employer } from './Employer';
import { Field } from './Field';
import { Employee } from './Employee';
import { Enjoy } from './Enjoy';

@Table
class RecruitmentArticle extends Model {
    @Column({ primaryKey: true })
    Id!: string;

    @Column
    Name!: string;

    @Column
    DateUpload!: Date;

    @Column
    Requirement!: string;

    @Column
    Image!: string;

    @Column
    Salary!: string;

    @Column
    AddressWork!: string;

    @Column
    IsApproved!: boolean;

    @Column
    View!: number;

    @Column
    EndSubmission!: Date;

    @Column
    AgeEmployee!: string;

    @Column
    CountEmployee!: number;

    @Column
    FormOfWork!: string;

    @Column
    YearOfExpensive!: number;

    @Column
    Degree!: string;

    //

    @BelongsTo(() => Employer, { foreignKey: 'EmployerId' })
    Employer!: Employer;

    @BelongsTo(() => Field, { foreignKey: 'FieldId' })
    Field!: Field;

    @BelongsToMany(() => Employee, () => Enjoy)
    ListBeEnjoyed!: Employee[]
}

export { RecruitmentArticle }