import { Table, Column, Model, BelongsTo, HasMany, DataType} from 'sequelize-typescript';
import { User } from './User';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table
class Employer extends Model {
    @Column({ primaryKey: true, type: DataType.STRING })
    Id!: string;

    @Column({type: DataType.STRING})
    Logo!: string;

    @Column({type: DataType.STRING})
    Description!: string;

    @Column({type: DataType.STRING})
    Hotline!: string;

    @Column({type: DataType.STRING})
    Address!: string;

    @BelongsTo(() => User, {foreignKey: 'Id'})
    User!: User

    @HasMany(() => RecruitmentArticle)
    ListRecruitmentArticle!: RecruitmentArticle[];
}

export { Employer };
