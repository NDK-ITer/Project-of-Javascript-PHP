import BaseService from "../BaseService";


export default class EmployerService extends BaseService{

    constructor() {
        super();
    }
    
    public async Edit(userId: string, data:{
        companyName: string,
        logo: string,
        description: string,
        hotLine: string,
        address: string
    }): Promise<any>{
        const result = await this.uow.EmployerRepository.update(userId, {
            CompanyName: data.companyName,
            Logo: data.logo,
            Description: data.description,
            Hotline: data.hotLine,
            Address: data.address
        })

        if(!result){
            return{
                state: 0,
                mess: `Cập nhập thông tin không thành công.`
            }
        }
        return{
            state: 1,
            data: result,
            mess: `Cập nhập thông tin thành công.`
        }
    }
}