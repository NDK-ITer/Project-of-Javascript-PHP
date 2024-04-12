import { v4 as uuidv4 } from 'uuid';
import BaseService from "../BaseService";
import { Authenticate } from '../../libs/Authenticate';
import { Employee } from '../../../data/models/Employee';
import { Employer } from '../../../data/models/Employer';

export default class UserService extends BaseService {

    constructor() {
        super();
    }

    public async Create(data: {
        email: string,
        password: string,
        roleId: string,
        employee?: {
            fullName: string,
            gender: string,
            born: Date,
            address: string,
            phoneNumber: string,
            fieldId: string
            avatar: string,
        },
        employer?: {
            companyName: string,
            address: string,
            hotline: string,
            logo: string
        }
    }): Promise<any> {
        const role: any = await this.ImportRole()
        const user: any = await this.uow.UserRepository.find({ Email: data.email })
        if (user) {
            return {
                state: 1,
                mess: `email: ${data.email} is exist`
            }
        }
        let newUser: any = {
            Id: uuidv4().toString(),
            Email: data.email,
            Password: await Authenticate.HashingPassword(data.password),
            IsBlock: false,
            CreateDate: new Date(),
            UpdateDate: new Date(),
        }
        if (data.employee != null && data.roleId == role.Employee.id) {
            newUser.RoleId = role.Employee.id
            newUser.Employee = {
                Id: newUser.Id,
                FullName: data.employee.fullName,
                Born: data.employee.born,
                Gender: data.employee.gender,
                FieldId: data.employee.fieldId,
                Address: data.employee.address,
                PhoneNumber: data.employee.phoneNumber,
                Avatar: data.employee.avatar
            }
            const result = await this.uow.UserRepository.create(newUser, Employee);
            if (!result) {
                return {
                    state: 0,
                    mess: 'Đăng ký không thành công'
                }
            }
            return {
                state: 1,
                data: result
            }

        } else if (data.employer != null && data.roleId == role.Employer.id) {
            newUser.RoleId = role.Employer.id
            newUser.Employer = {
                Id: newUser.Id,
                CompanyName: data.employer.companyName,
                Logo: data.employer.logo,
                Hotline: data.employer.hotline,
                Address: data.employer.address
            }
            const result = await this.uow.UserRepository.create(newUser, Employer);
            if (!result) {
                return {
                    state: 0,
                    mess: 'Đăng ký không thành công'
                }
            }
            return {
                state: 1,
                data: result
            }

        } else {
            return {
                state: 0,
                mess: 'Không thể đăng ký'
            }
        }
    }

    public async GetJWT(data: {
        email: string,
        password: string
    }): Promise<any> {
        const role = await this.ImportRole()
        const user = await this.uow.UserRepository.find({ Email: data.email })
        if (!user) {
            return {
                state: 0,
                mess: `Không tìm thấy người dùng với email: ${data.email}`
            }
        }
        const checkPassword = await Authenticate.ComparePasswords(data.password, user.Password)
        if (!checkPassword) {
            return {
                state: 0,
                mess: `Sai mất khẩu`
            }
        }
        const secretKey = String(process.env.SECRET_KEY)
        const jwt = await Authenticate.GenerateJWT({
            id: user.Id,
            roleId: user.RoleId
        }, secretKey)

        if (!jwt) {
            return {
                state: 0,
                mess: `Lỗi lấy token`
            }
        }
        let userData: any = {}
        if (user.RoleId == role.Employee.id) {
            const employee: any = await this.uow.EmployeeRepository.getById(user.Id)
            const parts = employee.FullName.split(' ');
            const lastName = parts[parts.length - 1];
            userData = {
                displayName: lastName,
                avatar: employee.Avatar,
            }
        } else if (user.RoleId == role.Employer.id) {
            const employer: any = await this.uow.EmployerRepository.getById(user.Id)
            userData = {
                displayName: employer.CompanyName,
                avatar: employer.Logo
            }
        } else {
            userData = {
                displayName: user.Email
            }
        }
        userData.roleId = user.RoleId
        return {
            state: 1,
            data: userData,
            token: jwt
        }
    }

    public async GetById(id: string): Promise<any> {
        const user = await this.uow.UserRepository.getById(id)
        if (!user) {
            return {
                state: 0,
                mess: `Không tìm thấy người dùng với mã: ${id}`
            }
        }
        const role = await this.ImportRole()
        if (user.RoleId == role.Employee.id) {
            const employee: any = await this.uow.EmployeeRepository.getById(user.Id)
            const fieldEmployee: any = await this.uow.FieldRepository.getById(employee.FieldId)
            return {
                state: 1,
                data: {
                    id: user.Id,
                    email: user.Email,
                    avatar: employee.Avatar,
                    fullName: employee.FullName,
                    born: employee.Born,
                    gender: employee.Gender,
                    phoneNumber: employee.PhoneNumber,
                    address: employee.Address,
                    field: fieldEmployee.Name
                }
            }
        } else if (user.RoleId == role.Employer.id) {
            const employer: any = await this.uow.EmployerRepository.getById(user.Id)
            return {
                state: 1,
                data: {
                    id: user.Id,
                    email: user.Email,
                    companyName: employer.CompanyName,
                    logo: employer.Logo,
                    description: employer.Description,
                    hotLine: employer.Hotline,
                    address: employer.Address,
                }
            }
        } else {
            return {
                state: 1,
                data: {
                    id: user.Id,
                    email: user.Email
                }
            }
        }
    }

    public async GetAll(): Promise<any> {
        const result = await this.uow.UserRepository.getAll()
        if (!result) {
            return {
                state: 0,
                mess: `Không thể lấy dánh sách người dùng.`
            }
        }
        return {
            state: 1,
            data: result,
        }
    }

    public async Block(id: string): Promise<any> {
        const result = await this.uow.UserRepository.update(id, { IsBlock: true })
        if (!result) {
            return {
                state: 0,
                mess: `Có lỗi khi khóa người dùng: ${id}`
            }
        }
        return {
            state: 1,
            mess: `Khóa người dùng thành công`,
            data: result
        }
    }

    public async ResetPassword(id: string, newPassword: string): Promise<any> {
        const result = await this.uow.UserRepository.update(id, { Password: await Authenticate.HashingPassword(newPassword) })
        if (!result) {
            return {
                state: 0,
                mess: `Đổi mật khẩu không thành công.`
            }
        }
        return {
            state: 1,
            mess: `Đổi mật khẩu thành công.`
        }
    }

    public async ChangeEmail(id: string, newEmail: string): Promise<any> {
        const result = await this.uow.UserRepository.update(id, { Email: newEmail })
        if (!result) {
            return {
                state: 0,
                mess: `Cập nhập Email không thành công.`
            }
        }
        return {
            state: 1,
            data: result,
            mess: `Cập nhập Email thành công.`
        }
    }
}