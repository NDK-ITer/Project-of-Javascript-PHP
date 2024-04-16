import BaseService from "../BaseService";


export default class DRService extends BaseService {
    constructor() {
        super();
    }

    public async Apply(employeeId: string, RAId: string): Promise<any> {
        console.log("ndk: ",employeeId, RAId);

        if (employeeId == null || RAId == null) {
            return {
                state: 0,
                mess: `Ứng tuyển không thành công`
            }
        }
        const employee = await this.uow.EmployeeRepository.getById(employeeId);
        if (employee == null) {
            return {
                state: 0,
                mess: `Người dùng không tồn tại`
            }
        }
        if(!employee?.CV){
            return {
                state: 0,
                mess: `Vui lòng thêm CV `
            }
        }
        const applyData: any = {
            EmployeeId: employeeId,
            RA_Id: RAId,
            CVApply: employee.CV,
            DateApply: new Date(),
        }
        if(await this.uow.EnjoyRepository.filter({EmployeeId: employeeId, RA_Id: RAId})) {
            return {
                state: 0,
                mess: `Bạn đã ứng tuyển tại công ty này!`
            }
        }
        const applyAction = await this.uow.EnjoyRepository.create(applyData)
        console.log("ndk: ", applyAction)
        if(applyAction){
            return {
                state: 1,
                data: applyAction,
                mess: `Ứng tuyển thành công`
            }
        }
        return {
            state: 0,
            mess: `Ứng tuyển không thành công`
        }
    }
}