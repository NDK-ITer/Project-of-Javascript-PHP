import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService";

export default class EmployeeController {
    static async Edit(req: any, res: Response): Promise<any> {
        try {
            const data = req.body
            const user = req.user
            const result = await UOWService.EmployeeService.Edit(user.id, {
                fullName: data.fullName,
                avatar: data.avatar,
                phoneNumber: data.phoneNumber,
                introduction: data.introduction,
                gender: data.gender,
                address: data.address,
                born: data.born
            })
            if (result.state == 1) {
                const data = result.data
                res.status(200).json({
                    state: result.state,
                    mess: result.mess,
                    data: {
                        avatar: data.Avatar,
                        fullName: data.FullName,
                        introduction: data.Introduction,
                        born: data.Born,
                        gender: data.Gender,
                        email: data.Email,
                        address: data.Address,
                        phoneNumber: data.PhoneNumber,
                    }
                })
            }
            res.status(200).json({
                state: result.state,
                mess: result.mess
            })
        } catch (error) {
            res.status(500)
        }
    }

    static async GetById(req: any, res: Response): Promise<any> {
        try {
            const user = req.user
            const result = await UOWService.EmployeeService.GetById(user.id)
            if (result.state == 1) {
                const data = result.data
                res.status(200).json({
                    state: result.state,
                    data: {
                        avatar: data.Avatar,
                        fullName: data.FullName,
                        introduction: data.Introduction,
                        born: data.Born,
                        gender: data.Gender,
                        email: data.Email,
                        address: data.Address,
                        phoneNumber: data.PhoneNumber,
                        certification: data.Certification,
                        historyApply: data.historyApply,
                    }
                })
            }
            res.status(200).json({
                state: result.state,
                mess: result.mess
            })
        } catch (error) {
            res.status(500)
        }
    }
}