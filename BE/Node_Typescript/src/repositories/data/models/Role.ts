import { Table, Column, Model, HasMany,DataType } from 'sequelize-typescript';
import { User } from './User';

@Table
class Role extends Model{
    @Column({ primaryKey: true, type: DataType.STRING })
    Id!: string;

    @Column({type: DataType.STRING})
    Name!: string;

    @Column({type: DataType.STRING})
    NormalizeName!: string;

    @HasMany(() => User)
    User!: User[]
}

export {Role}