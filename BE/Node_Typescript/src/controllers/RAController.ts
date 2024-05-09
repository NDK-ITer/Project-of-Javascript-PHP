import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService";

export default class RAController {
    //common
    static async GetById(req: any, res: Response): Promise<any> {
        try {
            const RAId = req.query.id
            let RA = await UOWService.RAService.GetById(RAId)
            if (RA.state === 1) {
                RA = RA.data
                let employer = await UOWService.EmployerService.GetById(RA.EmployerId)
                let fieldRA = await UOWService.FieldService.GetById(RA.FieldId)
                employer = employer.data
                fieldRA = fieldRA.data
                let data: any = {
                    id: RA.Id,
                    name: RA.Name,
                    image: RA.Image,
                    dateUpload: RA.DateUpload,
                    position: RA.Position,
                    countEmployee: RA.CountEmployee,
                    ageEmployee: RA.AgeEmployee,
                    degree: RA.Degree,
                    yearOfExpensive: RA.YearOfExpensive,
                    formOfWork: RA.FormOfWork,
                    fieldName: fieldRA.Name,
                    salary: RA.Salary,
                    endSubmission: RA.EndSubmission,
                    addressWork: RA.AddressWork,
                    description: RA.Description,
                }
                res.status(200).json({
                    state: 1,
                    data: data,
                })
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: RA.mess,
                }
            })
        } catch (error) {
            res.status(500)
        }
    }

    static async GetPublic(req: any, res: Response): Promise<any> {
        try {
            const limit = req.query.limit ? parseInt(req.query.limit as string) : parseInt(process.env.LIMIT_ELEMENT as string);
            const page = req.query.page ? parseInt(req.query.page as string) : 1;
            const result = await UOWService.RAService.GetPublic(limit, page)
            const listRA: any[] = []
            if (result.state == 1) {
                for (const item of result.data) {
                    let employer: any = await UOWService.EmployerService.GetById(item.EmployerId);
                    employer = employer.data.employer;
                    const element = {
                        id: item.Id,
                        companyName: employer.CompanyName,
                        companyLogo: employer.Logo,
                        name: item.Name,
                        description: item.Description,
                        salary: item.Salary,
                        image: item.Image,
                    };
                    listRA.push(element);
                }
            }
            res.status(200).json({
                state: result.state,
                data: listRA,
                mess: result.mess
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
                // requirement: req.body.requirement,
                image: req.body.image,
                salary: req.body.salary,
                addressWork: req.body.addressWork,
                position: req.body.position,
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
            const raId = req.body.raId
            const isEmployee = await UOWService.RoleService.CheckIsEmployee(userId);
            if (!isEmployee) {
                res.status(200).json({
                    state: 0,
                    data: {
                        mess: `Bạn không được quyền làm điều này`
                    }
                })
            }
            
            const result = await UOWService.DRService.Apply(userId, raId)
            if(result.state === 1) {
                res.status(200).json({
                    state: 1,
                    data: {
                        mess: `Ứng tuyển thành công`
                    }
                })
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: `Ứng tuyển không thành công`
                }
            })
        } catch (error) {
            res.status(500)
        }
    }
    //admin
    static async SetApproved(req: any, res: Response): Promise<any> {
        try {
            const userId = req.user.id
            const checkIsAdmin = await UOWService.RoleService.CheckIsAdmin(userId);
            if (!checkIsAdmin) {
                res.status(200).json({
                    state: 0,
                    data: {
                        mess: `Bạn không có quyền duyệt bài`
                    }
                })
            }
            const raId = req.body.raId
            const result = await UOWService.RAService.SetApproved(raId)
            if (result.state == 1) {
                res.status(200).json({
                    state: 1,
                    data: {
                        id: result.data.Id,
                        mess: `Duyệt bài thành công`
                    }
                })
            }
            res.status(200).json({
                state: 0,
                data: {
                    mess: `Duyệt bài thành công`
                }
            })
        } catch (error) {
            res.status(500)
        }
    }
}