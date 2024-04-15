import BaseService from "../BaseService";


export default class DRService extends BaseService {
    constructor() {
        super();
    }

    public async Apply(employeeId: string, RAId: string): Promise<any> {
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
            DateRecruitment: Date.now(),
            CVApply: employee?.CV,
        }
        const applyAction = await this.uow.DRRepository.create(applyData)
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