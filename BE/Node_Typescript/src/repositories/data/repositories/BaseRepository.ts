import { Model, ModelCtor } from 'sequelize-typescript';

abstract class BaseRepository<T extends Model>{
    protected model: ModelCtor<T>;

    constructor(model: ModelCtor<T>) {
        this.model = model;
    }

    async create(data: any): Promise<T> {
        return await this.model.create(data);
    }

    async findAll(): Promise<T[]> {
        return await this.model.findAll();
    }

    async findById(id: string): Promise<T | null> {
        return await this.model.findByPk(id);
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

    async delete(id: string): Promise<boolean> {
        const result = await this.model.destroy({ where: { id: id as any } });
        return !!result;
    }
}

export { BaseRepository };