import { Table, Column, Model, DataType, BeforeSave, BelongsTo, BelongsToMany } from 'sequelize-typescript';
import { Field } from './Field';
import { User } from './User';
import { RecruitmentArticle } from './RecruitmentArticle';
import { Enjoy } from './Enjoy';

@Table
class Employee extends Model {
    @Column({ primaryKey: true, type: DataType.STRING })
    Id!: string;

    @Column({ allowNull: true,type: DataType.STRING })
    Certification!: string;

    @Column({ allowNull: true,type: DataType.STRING })
    CV!: string;

    @Column({type: DataType.DATE})
    Born!: Date;

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
