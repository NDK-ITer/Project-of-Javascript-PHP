import { Table, Column, Model, BelongsTo } from 'sequelize-typescript';
import { User } from './User';

@Table
class Employer extends Model {
    @Column({ primaryKey: true })
    Id!: string;

    @Column
    Logo!: string;

    @Column
    Description!: string;

    @Column
    Hotline!: string;

    @Column
    Address!: string;

    @BelongsTo(() => User, {foreignKey: 'Id'})
    User!: User
}

export { Employer };
