import { Table, Column, Model, DataType, BelongsTo, BelongsToMany, ForeignKey } from 'sequelize-typescript';
import { Employer } from './Employer';
import { Field } from './Field';
import { Employee } from './Employee';
import { Enjoy } from './Enjoy';
import { DetailRecruitment } from './DetailRecruitment';

@Table({ timestamps: false })
class RecruitmentArticle extends Model {
    @Column({ primaryKey: true, type: DataType.STRING })
    Id!: string;

    @Column({type: DataType.STRING})
    Name!: string;

    @Column({type: DataType.STRING})
    Description!: string;

    @Column({type: DataType.DATE})
    DateUpload!: Date;

    @Column({type: DataType.STRING})
    Requirement!: string;

    @Column({type: DataType.STRING})
    Image!: string;

    @Column({type: DataType.STRING})
    Salary!: string;

    @Column({type: DataType.STRING})
    Position!: string;

    @Column({type: DataType.STRING})
    AddressWork!: string;

    @Column({type: DataType.BOOLEAN})
    IsApproved!: boolean;

    @Column({type: DataType.NUMBER})
    View!: number;

    @Column({type: DataType.DATE})
    EndSubmission!: Date;

    @Column({type: DataType.STRING})
    AgeEmployee!: string;

    @Column({type: DataType.NUMBER})
    CountEmployee!: number;

    @Column({type: DataType.STRING})
    FormOfWork!: string;

    @Column({type: DataType.NUMBER})
    YearOfExpensive!: number;

    @Column({type: DataType.STRING})
    Degree!: string;
    //
    @Column({type: DataType.STRING})
    @ForeignKey(() => Employer)
    EmployerId!: string
    
    @Column({type: DataType.STRING})
    @ForeignKey(() => Field)
    FieldId!: string
    //
    @BelongsTo(() => Employer, { foreignKey: 'EmployerId' })
    Employer!: Employer;

    @BelongsTo(() => Field, { foreignKey: 'FieldId' })
    Field!: Field;

    @BelongsToMany(() => Employee, () => Enjoy)
    ListBeEnjoyed!: Employee[]

    @BelongsToMany(() => Employee, () => DetailRecruitment)
    ListBeDR!: Employee[]
}

export { RecruitmentArticle }