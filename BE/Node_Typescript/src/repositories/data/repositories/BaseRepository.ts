import { Model, ModelCtor, Sequelize } from 'sequelize-typescript';

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

    // async update(id: string, data: any): Promise<[number, T[]]> {
    //     return await this.model.update(data, { where: { id } });
    // }

    // async delete(id: string): Promise<number> {
    //     const result = await this.model.destroy({ where: { id } });
    //     return result;
    // }
}

export { BaseRepository };