import { v4 } from "uuid";
import BaseService from "../BaseService";

export default class FieldService extends BaseService {
    constructor() {
        super();
    }

    public async GetAllField(): Promise<any> {
        const allField = await this.uow.FieldRepository.getAll();
        if (allField && allField.length > 0) {
            let listField: any[] = []
            allField.forEach((item) => {
                listField.push({
                    id: item.Id,
                    name: item.Name
                })
            })
            return {
                state: 1,
                data: {
                    fields: listField
                }
            }
        }
        return {
            state: 0,
            mess: `field is empty`
        }
    }

    public async Create(data: {
        name: string
    }): Promise<any> {
        let newField: any = {
            Id: v4.toString(),
            Name: data.name
        }
        const result = await this.uow.FieldRepository.create(newField)
        if (result) {
            return {
                state: 1,
                mess: `Thêm thành lĩnh vực thành công`,
                data: {
                    id: result.Id,
                    name: result.Name
                }
            }
        }
        return {
            state: 0,
            mess: `Thêm lĩnh vực không thành công! `
        }
    }

    public async Update(data: { id: string,name: string }): Promise<any> {
        let updateField = {
            Name: data.name
        }
        const result = await this.uow.FieldRepository.update(data.id, updateField)
        if (result) {
            return {
                state: 1,
                mess: `Cập nhập thành công`,
                data: {
                    id: result.Id,
                    name: result.Name
                }
            }
        }
        return {
            state: 0,
            mess: `Cập nhập thất bại`
        }
    }

    public async GetById(id: string): Promise<any> {
        const field = await this.uow.FieldRepository.getById(id)
        if(field) {
            return{
                state: 1,
                data: field
            }
        }
        return{
            state: 0,
            mess: `Không tìm thấy`
        }
    }
}