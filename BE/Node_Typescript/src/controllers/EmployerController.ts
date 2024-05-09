import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService";

export default class EmployerController {
    static async Edit(req: any, res: Response): Promise<any> {
        try {
            const data = req.body
            const user = req.user
            const result = await UOWService.EmployerService.Edit(user.id, {
                companyName: data.companyName,
                logo: data.logo,
                description: data.description,
                hotLine: data.hotLine,
                address: data.address
            })
            if (result.state == 1) {
                const data = result.data
                res.status(200).json({
                    state: result.state,
                    mess: result.mess,
                    data: {
                        companyName: data.employer.CompanyName,
                        logo: data.employer.Logo,
                        description: data.employer.Description,
                        hotLine: data.employer.Hotline,
                        address: data.employer.Address,
                        listRA: data.listRA
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
            const result = await UOWService.EmployerService.GetById(user.id)
            if (result.state == 1) {
                const data = result.data
                res.status(200).json({
                    state: result.state,
                    data: {
                        companyName: data.employer.CompanyName,
                        logo: data.employer.Logo,
                        description: data.employer.Description,
                        hotLine: data.employer.Hotline,
                        address: data.employer.Address,
                        listRA: data.listRA
                    }
                })
            }
        } catch (error) {
            res.status(500)
        }
    }
}