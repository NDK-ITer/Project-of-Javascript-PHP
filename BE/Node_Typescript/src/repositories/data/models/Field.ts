import { Table, Column, Model, PrimaryKey, ForeignKey } from 'sequelize-typescript';

@Table
class Field extends Model {
    @Column
    @PrimaryKey 
    Id!: string;

    @Column
    Name!: string;
}

export { Field };
