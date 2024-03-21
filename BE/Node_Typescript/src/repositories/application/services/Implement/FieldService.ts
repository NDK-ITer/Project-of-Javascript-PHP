import BaseService from "../BaseService";

export default class FieldService extends BaseService {
    constructor() {
        super();
    }

    public async GetAllField(): Promise<any> {
        const allField = await this.uow.FieldRepository.getAll();
        if (allField && allField.length > 0) {
            let listField: any[] = []
            allField.forEach((item)=>{
                listField.push({
                    id: item.Id,
                    name: item.Name
                })
            })
            return{
                state: 1,
                data:{
                    fields: listField
                }
            }
        }
        return{
            state:0,
            mess: `field is empty`
        }
    }
}