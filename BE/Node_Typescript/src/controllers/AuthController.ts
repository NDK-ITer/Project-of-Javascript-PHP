import UOWService from "../repositories/application/services/UOWService"

export default class AuthController {
    static async Register(req: any, res: any): Promise<any> {
        const data = req.body
        const newUser: any = {
            email: data.email,
            password: data.password,
            roleId: data.roleId,
        }
        if (data.employee) {
            const employee = data.employee
            const [day, month, year] = employee.born.split('/').map(Number);
            const dateObject = new Date(year, month - 1, day + 1);
            newUser.employee = {
                fullName: employee.fullName,
                gender: employee.gender,
                born: dateObject,
                address: employee.address,
                phoneNumber: employee.phoneNumber,
                fieldId: employee.fieldId,
                avatar: ''
            }
        } else if (data.employer) {
            const employer = data.employer
            newUser.employer = {
                companyName: employer.companyName,
                address: employer.address,
                hotline: employer.hotline,
                logo: ''
            }
        }
        const result = await UOWService.UserService.Create(newUser)
        res.json(result)
    }
    static async Login(req: any, res: any): Promise<any> {
        const data = req.body
        const loginData:any = {
            email: data.email,
            password: data.password
        }
        const result = await UOWService.UserService.GetJWT(loginData)
        res.json(result)
    }
}