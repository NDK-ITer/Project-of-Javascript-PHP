import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService"

export default class AuthController {
    static async Register(req: any, res: Response): Promise<any> {
        try {
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
        } catch (error) {
            res.status(500)
        }
    }

    static async Login(req: any, res: Response): Promise<any> {
        try {
            const data = req.body
            const loginData: any = {
                email: data.email,
                password: data.password
            }
            const result = await UOWService.UserService.GetJWT(loginData)
            res.status(200).json(result)
        } catch (error) {
            res.status(500)
        }
    }

    static async ResetPassword(req: any, res: Response): Promise<any> {
        try {
            const data = req.body
            const user = req.user
            const result = await UOWService.UserService.ResetPassword(user.id, data.newPassword)
            res.status(200).json({
                state: result.state,
                mess: result.mess
            })
        } catch (error) {
            res.status(500)
        }

    }

    static async ChangeEmail(req: any, res: Response): Promise<any> {
        try {
            const data = req.body
            const user = req.user
            const result = await UOWService.UserService.ChangeEmail(user.id, data.newEmail)
            res.status(200).json({
                state: result.state,
                mess: result.mess
            })
        } catch (error) {
            res.status(500)
        }
    }
}