import { Table, Column, Model, PrimaryKey, HasMany } from 'sequelize-typescript';
import { User } from './User';

@Table
class Role extends Model{
    @Column
    @PrimaryKey 
    Id!: string;

    @Column
    Name!: string;

    @Column
    NormalizeName!: string;

    @HasMany(() => User)
    User!: User[]
}

export {Role}