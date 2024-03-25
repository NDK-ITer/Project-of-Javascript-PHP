import { Table, Column, Model,HasOne, BelongsTo,DataType, ForeignKey } from 'sequelize-typescript';
import { Role } from './Role';
import { Employee } from './Employee';
import { Employer } from './Employer';

@Table({ timestamps: false })
export class User extends Model {
    @Column({ primaryKey: true, type: DataType.STRING })
    @ForeignKey(() => Employee)
    @ForeignKey(() => Employer)
    Id!: string;

    @Column({type: DataType.STRING})
    Email!: string;

    @Column({type: DataType.STRING})
    Password!: string;

    @Column({type: DataType.BOOLEAN})
    IsBlock!: boolean;

    @Column({type: DataType.DATE})
    CreateDate!: Date;

    @Column({type: DataType.DATE})
    UpdateDate!: Date;
    //
    @Column({type: DataType.STRING})
    @ForeignKey(() => Role)
    RoleId!: string;
    //
    @HasOne(() => Employee, {foreignKey: 'Id'})
    Employee!: Employee

    @HasOne(() => Employer, {foreignKey: 'Id'})
    Employer!: Employer

    @BelongsTo(() => Role, {foreignKey: 'RoleId'})
    Role!: Role
}