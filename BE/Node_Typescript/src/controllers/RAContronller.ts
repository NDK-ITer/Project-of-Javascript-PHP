import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService";

export default class RAController {
    //common
    static async GetById(req: any, res: Response): Promise<any> {
        try {
            const RAId = req.query.id
            const RA = await UOWService.RAService.GetById(RAId)
            const employer = await UOWService.EmployerService.GetById(RA.EmployerId)
            let data: any = {
                id: RA.Id,
                name: RA.Name,
                image: RA.Image,
                dateUpload: RA.DateUpload,
                
            }
        } catch (error) {
            res.status(500)
        }
    }

    static async GetAll(req: any, res: Response): Promise<any> {
        try {
            const limit = req.query.limit ? parseInt(req.query.limit as string) : parseInt(process.env.LIMIT_ELEMENT as string);
            const page = req.query.page ? parseInt(req.query.page as string) : 1;

            const result = await UOWService.RAService.GetAll(limit, page)
            let listRA: any[] = new Array
            if (result.state == 1) {
                result.data.array.forEach(async (item: any) => {
                    const employer = await UOWService.EmployerService.GetById(item.EmployerId)
                    listRA.push({
                        id: item.Id,
                        companyName: employer.CompanyName,
                        companyLogo: employer.Logo,
                        name: item.Name,
                        description: item.Description,
                        salary: item.Salary,
                        image: item.Image,
                    })
                });
            }
            res.status(200).json({
                state: result.state,
                data: listRA
            })
        } catch (error) {
            res.status(500)
        }
    }
    //employer
    static async Upload(req: any, res: Response): Promise<any> {

    }

    static async Edit(req: any, res: Response): Promise<any> {

    }
    //employee
    static async Apply(req: any, res: Response): Promise<any> {

    }
    //admin
    static async SetApproved(req: any, res: Response): Promise<any> {

    }
}