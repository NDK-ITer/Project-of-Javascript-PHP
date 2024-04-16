import UOWRep from "../../data/repositories/UOWRepository";

export default abstract class BaseService {
    protected uow: UOWRep;

    protected async ImportRole(): Promise<any> {
        let role: any = {
            Admin: {},
            Employer: {},
            Employee: {}
        }
        const roles = await this.uow.RoleRepository.getAll();
        roles.forEach((item) => {
            if (item.NormalizeName === 'ADMIN') {
                role.Admin = {
                    id: item.Id,
                    name: item.Name,
                    normalizeName: item.NormalizeName
                };
            } else if (item.NormalizeName === 'EMPLOYEE') {
                role.Employee = {
                    id: item.Id,
                    name: item.Name,
                    normalizeName: item.NormalizeName
                };
            } else if (item.NormalizeName === 'EMPLOYER') {
                role.Employer = {
                    id: item.Id,
                    name: item.Name,
                    normalizeName: item.NormalizeName
                };
            }
        });
        return role
    }

    constructor() {
        this.uow = new UOWRep();
    }
}
