import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService"
import { Authenticate } from "../repositories/application/libs/Authenticate";
import cache from 'memory-cache';
import { MailSender } from "../repositories/application/libs/MailSender";

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

    static async ForgotPassword(req: any, res: Response,): Promise<any> {
        try {
            const use = await UOWService.UserService.GetByEmail(req.body.email)
            if (use.state == 0) {
                res.status(200).json({
                    state: 0,
                    data: {
                        mess: `Không tìm thấy người dùng với mail: ${req.body.email}`
                    }
                })
            }
            const otp = await Authenticate.CreateOPTCode()

            const key = otp;
            const value = use.data.id;
            const durationMs = 30 * 1000; // 30s
            const checkSendEmail = await MailSender.Send(use.data.email,
                "OTP Code",
                `OTP của bạn là: ${otp}`
            )
            if (checkSendEmail) {
                cache.put(key, value, durationMs);
                res.status(200).json({
                    state: 1,
                    data: {
                        mess: `Đã gửi OTP, vui lòng kiểm tra email của bạn`
                    }
                });
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: `Lỗi gửi OTP vui lòng nhập lại email của bạn`
                }
            })
        } catch (error) {
            res.status(500)
        }
    }

    static async VerifyOTPCode(req: any, res: Response): Promise<any> {
        try {
            const otp = req.body.otp;
            if (otp || otp === "") {
                res.status(200).json({
                    state: 0,
                    data: {
                        mess: "Vui lòng nhập OTP"
                    }
                })
            }
            const userId = await cache.get(otp)
            if (userId) {
                res.status(200).json({
                    state: 1,
                    data: {
                        userId: userId
                    }
                })
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: `OTP sai hoặc đã quá hạn`
                }
            })
        } catch (error) {
            res.status(500)
        }
    }

    static async ResetPassword(req: any, res: Response): Promise<any> {
        try {
            const data = req.body
            if (req.user) {
                const user = req.user
                const result = await UOWService.UserService.ResetPassword(user.id, data.newPassword)
                res.status(200).json({
                    state: result.state,
                    mess: result.mess
                })
            }else if(data.userId){
                const result = await UOWService.UserService.ResetPassword(data.userId, data.newPassword)
                res.status(200).json({
                    state: result.state,
                    mess: result.mess
                })
            }
            res.status(200).json({
                state: 0,
                data:{
                    mess: `Yêu cầu không được xác thực hoặc ko hợp lệ`
                }
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

    static async GetAllRole(req: any, res: Response): Promise<any> {
        try {
            const result = await UOWService.RoleService.GetAll()
            res.status(200).json({
                state: result.state,
                data: result.data
            })
            res.json(result);
        } catch (error) {
            res.status(500)
        }
    }
}