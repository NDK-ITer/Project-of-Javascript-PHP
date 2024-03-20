import { v4 as uuidv4 } from 'uuid';
import BaseService from "../BaseService";
import { Authenticate } from '../../libs/Authenticate';

export default class UserService extends BaseService {

    constructor() {
        super();
    }

    public async Create(data: {
        email: string,
        password: string,
        employee?: {
            fullName: string,
            born: Date,
            address: string,
            phoneNumber: string,
            avatar: string,
        },
        employer?: {
            companyName: string,
            address: string,
            hotline: string,
            logo: string
        }
    }): Promise<any> {
        const role: any = this.ImportRole()
        let newUser: any = {
            Id: uuidv4().toString(),
            Email: data.email,
            Password: Authenticate.HashingPassword(data.password),
            IsBlock: false,
            CreateDate: new Date(),
            UpdateDate: new Date(),
        }
        if (data.employee != null) {
            newUser.RoleId = role.Employee
            newUser.Employee = {
                Id: newUser.Id,
                FullName: data.employee.fullName,
                Born: data.employee.born,
                Address: data.employee.address,
                PhoneNumber: data.employee.phoneNumber,
                Avatar: data.employee.avatar
            }
        } else if (data.employer != null) {
            newUser.RoleId = role.Employer
            newUser.Employer = {
                Id: newUser.Id,
                CompanyName: data.employer.companyName,
                Logo: data.employer.logo,
                Hotline: data.employer.hotline,
                Address: data.employer.address
            }
        } else {
            return {
                state: 0,
                mess: 'cannot create new user !'
            }
        }
        const result = await this.uow.UserRepository.create(newUser);
        if (!result) {
            return {
                state: 0,
                mess: 'some error when create user'
            }
        }
        return {
            state: 1,
            data: result
        }
    }

    public async GetJWT(data: {
        email: string,
        password: string
    }): Promise<any> {
        const role = await this.ImportRole()
        const user: any = await this.uow.UserRepository.findByProperties({ Email: data.email })
        if (!user) {
            return {
                state: 0,
                mess: `Not found user with email: ${data.email}`
            }
        }
        const checkPassword = await Authenticate.ComparePasswords(data.password, user.Password)
        if (!checkPassword) {
            return {
                state: 0,
                mess: `Password Invalid!`
            }
        }
        const secretKey = String(process.env.SECRET_KEY)
        const jwt = await Authenticate.GenerateJWT({
            id: user.Id
        }, secretKey)

        if (jwt) {
            return {
                state: 0,
                mess: `Error get jwt`
            }
        }
        let userData: any
        if (user.RoleId == role.Employee) {
            const parts = user.Employee.FullName.split(' ');
            const lastName = parts[parts.length - 1];
            userData = {
                displayName: lastName,
                avatar: user.Employee.Avatar
            }
        } else if (user.RoleId == role.Employer) {
            userData = {
                displayName: user.Employer.CompanyName,
                avatar: user.Employer.Logo
            }
        } else {
            userData = {
                displayName: user.Email
            }
        }
        return {
            state: 1,
            data: userData,
            jwt: jwt
        }
    }

    public async GetById(id: string): Promise<any> {

    }

    public async GetAll(): Promise<any> {

    }

    public async Block(id: string): Promise<any> {

    }
}