import { Table, Column, Model, BelongsTo, HasMany } from 'sequelize-typescript';
import { User } from './User';
import { RecruitmentArticle } from './RecruitmentArticle';

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

    @HasMany(() => RecruitmentArticle)
    ListRecruitmentArticle!: RecruitmentArticle[];
}

export { Employer };
