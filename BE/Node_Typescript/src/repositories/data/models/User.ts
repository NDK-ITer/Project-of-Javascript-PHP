import { Table, Column, Model, PrimaryKey, ForeignKey, HasOne, BelongsTo } from 'sequelize-typescript';
import { Role } from './Role';
import { Employee } from './Employee';
import { Employer } from './Employer';

@Table
class User extends Model {
    @Column({ primaryKey: true })
    Id!: string;

    @Column
    FullName!: string;

    @Column
    Email!: string;
    
    @Column
    Born!: Date;

    @Column
    Password!: string;

    @Column
    IsBlock!: boolean;

    @Column
    CreateDate!: Date;

    @Column
    UpdateDate!: Date;

    @HasOne(() => Employee, {foreignKey: 'Id'})
    Employee!: Employee

    @HasOne(() => Employer, {foreignKey: 'Id'})
    Employer!: Employer

    @BelongsTo(() => Role, {foreignKey: 'RoleId'})
    Role!: Role
}

export { User };
