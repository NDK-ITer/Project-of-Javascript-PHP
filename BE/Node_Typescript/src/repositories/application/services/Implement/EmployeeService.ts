import BaseService from "../BaseService";


export default class EmployeeService extends BaseService {

    constructor() {
        super();
    }

    public async Edit(userId: string, data:{
        fullName: string,
        avatar: string,
        phoneNumber: string,
        introduction: string,
        gender: string,
        address: string,
        born: Date
    }): Promise<any> {
        const result = await this.uow.EmployeeRepository.update(userId, {
            FullName: data.fullName,
            Avatar: data.avatar,
            PhoneNumber: data.phoneNumber,
            Introduction: data.introduction,
            Gender: data.gender,
            Address: data.address,
            Born: data.born
        })
        if(!result){
            return{
                state:0,
                mess:`Cập nhập thông tin không thành công.`
            }
        }
        return{
            state: 1,
            data: result,
            mess: `Cập nhập thông tin thành công.`
        }
    }
}