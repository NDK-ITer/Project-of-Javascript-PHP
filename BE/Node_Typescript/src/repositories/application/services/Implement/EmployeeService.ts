import { Enjoy } from "../../../data/models/Enjoy";
import BaseService from "../BaseService";


export default class EmployeeService extends BaseService {

    constructor() {
        super();
    }

    public async Edit(userId: string, data: {
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
        if (!result) {
            return {
                state: 0,
                mess: `Cập nhập thông tin không thành công.`
            }
        }
        return {
            state: 1,
            data: result,
            mess: `Cập nhập thông tin thành công.`
        }
    }

    public async UpdateCV(userId: string, newCV: string): Promise<any> {
        const result = await this.uow.EmployeeRepository.update(userId, {
            CV: newCV
        })
        if (!result) {
            return {
                state: 0,
                mess: `Cập nhập CV không thành công.`
            }
        }
        return {
            state: 1,
            data: result,
            mess: `Cập nhập CV thành công.`
        }
    }

    public async GetById(id: string): Promise<any> {
        let employee: any = await this.uow.EmployeeRepository.getById(id)
        if (!employee) {
            return {
                state: 0,
                mess: `không tìm thấy người tuyển dụng với id: ${id}`
            }
        }
        const enjoy = await this.uow.EnjoyRepository.filter({
            EmployeeId: employee.Id
        })

        let listRA: any[] = []
        enjoy.forEach(async (item: Enjoy) => {
            const ra = await this.uow.RARepository.find({ Id: item.RA_Id })
            listRA.push(ra)
        })
        employee.listRA = listRA
        return {
            state: 1,
            data: employee,
        }
    }
}