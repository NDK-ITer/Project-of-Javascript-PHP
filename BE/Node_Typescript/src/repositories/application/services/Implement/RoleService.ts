import { User } from "../../../data/models/User";
import BaseService from "../BaseService";

export default class RoleService extends BaseService {
    constructor() {
        super();
    }

    public async GetAll(): Promise<{ state: number, data: any }> {
        const role = await this.ImportRole()
        return {
            state: 1,
            data: {
                admin: role.Admin,
                employer: role.Employer,
                employee: role.Employee
            }
        }
    }

    public async CheckIsAdmin(userId: string): Promise<boolean> {
        const role = await this.ImportRole()
        const user: any = await this.uow.UserRepository.getById(userId)
        if (user) {
            if(user.RoleId === role.Admin.id){
                return true;
            }
        }
        return false;
    }

    public async CheckIsEmployee(userId: string): Promise<boolean> {
        const role = await this.ImportRole()
        const user: any = await this.uow.UserRepository.getById(userId)
        if (user) {
            if(user.RoleId === role.Employee.id){
                return true;
            }
        }
        return false;

    }

    public async CheckIsEmployer(userId: string): Promise<boolean> {
        const role = await this.ImportRole()
        const user: any = await this.uow.UserRepository.getById(userId)
        if (user) {
            if(user.RoleId === role.Employer.id){
                return true;
            }
        }
        return false;
    }
}