import { Response } from "express";
import UOWService from "../repositories/application/services/UOWService";


export default class FieldController {
    static async GetAll(req: any, res: Response):Promise<any>{
        try {
            const result = await UOWService.FieldService.GetAllField()
            res.status(200).json(result)
        } catch (error) {
            res.status(500)
        }
    }

    static async Create(req: any, res: Response):Promise<any>{
        try {
            const data = req.body
            const result = await UOWService.FieldService.Create(data)
            res.status(200).json(result)
        } catch (error) {
            res.status(500)
        }
    }

    static async Update(req: any, res: Response):Promise<any>{
        try {
            const data = req.body
            const result = await UOWService.FieldService.Update(data)
            res.status(200).json(result)
        } catch (error) {
            res.status(500)
        }
    }
}