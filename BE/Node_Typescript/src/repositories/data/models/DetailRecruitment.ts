import { Table, Column, Model, ForeignKey, DataType} from 'sequelize-typescript';
import { Employee } from './Employee';
import { RecruitmentArticle } from './RecruitmentArticle';

@Table({ timestamps: false })
class DetailRecruitment extends Model {
    @ForeignKey(() => Employee)
    @Column({ primaryKey: true, type: DataType.STRING })
    EmployeeId!: string;

    @ForeignKey(() => RecruitmentArticle)
    @Column({ primaryKey: true, type: DataType.STRING })
    RA_Id!: string;

    @Column({type: DataType.DATE})
    DateApply!: Date;

    @Column({type: DataType.STRING})
    CVApply!: string;
}

export { DetailRecruitment }