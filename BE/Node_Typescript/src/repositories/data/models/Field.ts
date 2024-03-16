import { Table, Column, Model, PrimaryKey, ForeignKey, HasMany } from 'sequelize-typescript';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class Field extends Model {
    @Column
    @PrimaryKey 
    Id!: string;

    @Column
    Name!: string;

    @HasMany(() => RecruitmentArticle)
    ListRecruitmentArticle!: RecruitmentArticle[];
}

export { Field };
