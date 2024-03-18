import { Table, Column, Model, HasMany } from 'sequelize-typescript';
import { User } from './User';

@Table
class Role extends Model{
    @Column({ primaryKey: true })
    Id!: string;

    @Column
    Name!: string;

    @Column
    NormalizeName!: string;

    @HasMany(() => User)
    User!: User[]
}

export {Role}