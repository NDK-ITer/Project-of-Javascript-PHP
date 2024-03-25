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
        const role: any = await this.ImportRole()
        const user: any = await this.uow.UserRepository.find({Email: data.email})
        if(user){return{
            state: 1,
            mess: `email: ${data.email} is exist`
        }}
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
                    mess: 'some error when create user'
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
                    mess: 'some error when create user'
                }
            }
            return {
                state: 1,
                data: result
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
        const user = await this.uow.UserRepository.find({ Email: data.email })
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

        if (!jwt) {
            return {
                state: 0,
                mess: `Error get jwt`
            }
        }
        let userData: any
        if (user.RoleId == role.Employee.id) {
            const employee:any = await this.uow.EmployeeRepository.getById(user.Id)
            const parts = employee.FullName.split(' ');
            const lastName = parts[parts.length - 1];
            userData = {
                displayName: lastName,
                avatar: employee.Avatar
            }
        } else if (user.RoleId == role.Employer.id) {
            const employer:any = await this.uow.EmployerRepository.getById(user.Id)
            userData = {
                displayName: employer.CompanyName,
                avatar: employer.Logo
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
        const user = await this.uow.UserRepository.getById(id)
        if (!user) {
            return {
                state: 0,
                mess: `not found user with id: ${id}`
            }
        }
        const role = await this.ImportRole()
        if (user.RoleId == role.Employee.id) {
            return {
                state: 1,
                data: {
                    id: user.Id,
                    avatar: user.Employee.Avatar,
                    fullName: user.Employee.FullName,
                    born: user.Employee.Born,
                    gender: user.Employee.Gender,
                    email: user.Email,
                    phoneNumber: user.Employee.PhoneNumber,
                    address: user.Employee.Address
                }
            }
        } else if (user.RoleId == role.Employer.id) {
            return {
                state: 1,
                data: {
                    id: user.Id,
                }
            }
        } else {

        }
    }

    public async GetAll(): Promise<any> {

    }

    public async Block(id: string): Promise<any> {

    }
}