import { FindOptions } from 'sequelize';
import { Model, ModelCtor } from 'sequelize-typescript';

abstract class BaseRepository<T extends Model>{
    protected model: ModelCtor<T>;

    constructor(model: ModelCtor<T>) {
        this.model = model;
    }

    async create(data: any, include?: FindOptions['include']): Promise<T | null> {
        return await this.model.create(data, { include });
    }

    async getAll(): Promise<T[]> {
        return await this.model.findAll();
    }

    async update(id: string, data: Partial<T>): Promise<T | null> {
        const [affectedCount] = await this.model.update(data, { where: { id: id as any } });
        if (affectedCount === 0) {
            return null;
        } else {
            const updatedRecord = await this.model.findByPk(id as any);
            return updatedRecord || null;
        }
    }

    async getById(id: string, include?: FindOptions['include']): Promise<T | null> {
        return await this.model.findByPk(id, { include });
    }

    async find(properties: Partial<T>): Promise<T | null> {
        const whereClause: any = {};
        for (const key in properties) {
            whereClause[key] = properties[key];
        }
        return await this.model.findOne({ where: whereClause });
    }
    
    async filter(filterObj: Partial<T>): Promise<T[]> {
        const whereClause: any = {};
        for (const key in filterObj) {
            whereClause[key] = filterObj[key];
        }
        return await this.model.findAll({ where: whereClause });
    }

    async delete(id: string): Promise<boolean> {
        const result = await this.model.destroy({ where: { id: id as any } });
        return !!result;
    }
}

export { BaseRepository };