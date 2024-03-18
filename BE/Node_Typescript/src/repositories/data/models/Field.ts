import { Table, Column, Model, HasMany } from 'sequelize-typescript';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class Field extends Model {
    @Column({ primaryKey: true })
    Id!: string;

    @Column
    Name!: string;

    @HasMany(() => RecruitmentArticle)
    ListRecruitmentArticle!: RecruitmentArticle[];
}

export { Field };
