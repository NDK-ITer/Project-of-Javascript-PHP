import BaseService from "../BaseService";

export default class RoleService extends BaseService {
    constructor() {
        super();
    }

    public async GetAll(): Promise<any> {
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
}