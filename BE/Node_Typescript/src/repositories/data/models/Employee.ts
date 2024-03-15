import { Table, Column, Model, ForeignKey, BeforeSave, BelongsTo, BelongsToMany } from 'sequelize-typescript';
import { Field } from './Field';
import { User } from './User';
import { RecruitmentArticle } from './RecruitmentArticle';
import { Enjoy } from './Enjoy';

@Table
class Employee extends Model {
    @Column({ primaryKey: true })
    Id!: string;

    @Column({ allowNull: true })
    Certification!: string;

    @Column({ allowNull: true })
    CV!: string;

    @Column
    Born!: Date;

    @Column
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
}

export { Employee };
