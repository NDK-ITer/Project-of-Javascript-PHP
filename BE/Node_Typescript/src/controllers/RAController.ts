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

    static async GetPublic(req: any, res: Response): Promise<any> {
        try {
            const limit = req.query.limit ? parseInt(req.query.limit as string) : parseInt(process.env.LIMIT_ELEMENT as string);
            const page = req.query.page ? parseInt(req.query.page as string) : 1;

            const result = await UOWService.RAService.GetPublic(limit, page)
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
        try {
            const checkIsEmployer = await UOWService.RoleService.CheckIsEmployer(req.user.id)
            if (!checkIsEmployer) {
                res.status(200).json({
                    state: 0,
                    data: {
                        mess: "Người dùng không phải nhà tuyển dụng",
                    }
                })
            }
            const data: any = {
                name: req.body.name,
                description: req.body.description,
                requirement: req.body.requirement,
                image: req.body.image,
                salary: req.body.salary,
                addressWork: req.body.addressWork,
                endSubmission: req.body.endSubmission,
                ageEmployee: req.body.ageEmployee,
                countEmployee: req.body.countEmployee,
                formOfWork: req.body.formOfWork,
                yearOfExpensive: req.body.yearOfExpensive,
                degree: req.body.degree,
            }
            const result = await UOWService.RAService.Create(req.user.id, req.body.fieldId, data)
            if (result.state === 1) {
                res.status(200).json({
                    state: 1,
                    data: {
                        mess: result.mess,
                    }
                })
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: result.mess,
                }
            })
        } catch (error) {
            res.status(500)
        }
    }

    static async Edit(req: any, res: Response): Promise<any> {
        try {
            const userId = req.user.id
            const raId = req.body.raId
            const data: any = {
                name: req.body.name,
                description: req.body.description,
                requirement: req.body.requirement,
                image: req.body.image,
                salary: req.body.salary,
                addressWork: req.body.addressWork,
                endSubmission: req.body.endSubmission,
                ageEmployee: req.body.ageEmployee,
                countEmployee: req.body.countEmployee,
                formOfWork: req.body.formOfWork,
                yearOfExpensive: req.body.yearOfExpensive,
                degree: req.body.degree,
            }
            const result = await UOWService.RAService.Update(raId, userId, data)
            if (result.state === 1) {
                res.status(200).json({
                    state: 1,
                    data: {
                        mess: result.mess,
                    }
                })
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: result.mess,
                }
            })
        } catch (error) {
            res.status(500)
        }
    }
    //employee
    static async Apply(req: any, res: Response): Promise<any> {
        try {
            const userId = req.user.id
            const isEmployee = await UOWService.RoleService.CheckIsEmployee(userId);
        
        } catch (error) {
            res.status(500)
        }
    }
    //admin
    static async SetApproved(req: any, res: Response): Promise<any> {
        try {
            const userId = req.user.id
            const CheckIsAdmin = await UOWService.RoleService.CheckIsAdmin(userId);
            
        } catch (error) {
            res.status(500)
        }
    }
}