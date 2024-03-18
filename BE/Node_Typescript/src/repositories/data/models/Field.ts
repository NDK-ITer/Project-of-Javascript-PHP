import { Table, Column, Model, HasMany, DataType } from 'sequelize-typescript';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class Field extends Model {
    @Column({ primaryKey: true, type: DataType.STRING })
    Id!: string;

    @Column({type: DataType.STRING})
    Name!: string;

    @HasMany(() => RecruitmentArticle)
    ListRecruitmentArticle!: RecruitmentArticle[];
}

export { Field };
