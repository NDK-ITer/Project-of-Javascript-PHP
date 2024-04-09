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
                        companyName: data.CompanyName,
                        logo: data.Logo,
                        description: data.Description,
                        hotLine: data.Hotline,
                        address: data.Address
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