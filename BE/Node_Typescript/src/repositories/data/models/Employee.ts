import { Table, Column, Model, DataType, BeforeSave, BelongsTo, BelongsToMany, ForeignKey } from 'sequelize-typescript';

import { Field } from './Field';
import { User } from './User';
import { RecruitmentArticle } from './RecruitmentArticle';
import { Enjoy } from './Enjoy';
import { DetailRecruitment } from './DetailRecruitment';

@Table({ timestamps: false })
class Employee extends Model {
    @Column({ primaryKey: true, type: DataType.STRING })
    @ForeignKey(() => User)
    Id!: string;

    @Column({type: DataType.STRING})
    FullName!: string;

    @Column({type: DataType.STRING})
    PhoneNumber!: string;

    @Column({type: DataType.STRING})
    Avatar!: string;

    @Column({type: DataType.STRING})
    Introduction!: string;

    @Column({ allowNull: true,type: DataType.STRING })
    Certification!: string;

    @Column({ allowNull: true,type: DataType.STRING })
    CV!: string;

    @Column({type: DataType.DATE})
    Born!: Date;

    @Column({type: DataType.STRING})
    Gender!: string;

    @Column({type: DataType.STRING})
    Address!: string;

    @BelongsTo(() => Field, { foreignKey: 'FieldId' })
    Field!: Field;

    @BelongsTo(() => User, { foreignKey: 'Id' })
    User!: User
    //
    @BeforeSave
    static async processCertification(instance: Employee) {
        if (instance.Certification && Array.isArray(instance.Certification)) {
            instance.Certification = instance.Certification.join(',');
        }
    }

    getCertificationArray(): string[] | null {
        if (this.Certification) {
            return this.Certification.split(',');
        }
        return null;
    }

    @BelongsToMany(() => RecruitmentArticle, () => Enjoy)
    ListEnjoy!: RecruitmentArticle[];

    @BelongsToMany(() => RecruitmentArticle, () => DetailRecruitment)
    ListDR!: RecruitmentArticle[];
}

export { Employee };
