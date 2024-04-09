import { v4 } from "uuid";
import BaseService from "../BaseService";
import { Op } from 'sequelize';

export default class RAService extends BaseService {
    constructor() {
        super();
    }

    public async Create(employerId: string, fieldId: string, data: {
        name: string,
        description: string,
        requirement: string,
        image: string,
        salary: string,
        addressWork: string,
        endSubmission: Date,
        ageEmployee: string,
        countEmployee: string,
        formOfWork: string,
        yearOfExpensive: string,
        degree: string,
    }): Promise<any> {
        const result = await this.uow.RARepository.create({
            Id: v4.toString(),
            Name: data.name,
            Description: data.description,
            Requirement: data.requirement,
            Image: data.requirement,
            Salary: data.salary,
            AddressWork: data.addressWork,
            IsApproved: false,
            View: 0,
            EndSubmission: data.endSubmission,
            AgeEmployee: data.ageEmployee,
            CountEmployee: data.countEmployee,
            FormOfWork: data.formOfWork,
            YearOfExpensive: data.yearOfExpensive,
            Degree: data.degree,
            EmployerId: employerId,
            FieldId: fieldId
        })
        if (!result) {
            return {
                state: 0,
                mess: `Tạo tin tuyển dụng không thành công.`
            }
        }
        return {
            state: 1,
            data: result,
            mess: `Tạo tin tuyển dụng thành công.`
        }
    }

    public async GetById(id: string): Promise<any> {
        const result = await this.uow.RARepository.getById(id)
        if (!result) {
            return {
                state: 0,
                mess: `Tin không tồn tại.`
            }
        }
        return {
            state: 1,
            data: result,
        }
    }

    public async Update(id: string, employerId: string, data: {
        name: string,
        requirement: string,
        image: string,
        salary: string,
        addressWork: string,
        endSubmission: Date,
        ageEmployee: string,
        countEmployee: string,
        formOfWork: string,
        yearOfExpensive: string,
        degree: string,
    }, fieldId?: string): Promise<any> {
        const RA = await this.uow.RARepository.getById(id)
        if (RA?.EmployerId !== employerId)
            return {
                state: 1,
                mess: `Không được phép cập nhập tin này`
            }
        let dataUpdate: any = {
            Name: data.name,
            Requirement: data.requirement,
            Image: data.requirement,
            Salary: data.salary,
            AddressWork: data.addressWork,
            EndSubmission: data.endSubmission,
            AgeEmployee: data.ageEmployee,
            CountEmployee: data.countEmployee,
            FormOfWork: data.formOfWork,
            YearOfExpensive: data.yearOfExpensive,
            Degree: data.degree,
        }
        if (fieldId && await this.uow.FieldRepository.getById(fieldId)) {
            dataUpdate.FieldId = fieldId
        }
        const result = await this.uow.RARepository.update(id, dataUpdate)
        if (!result) {
            return {
                state: 0,
                mess: `Cập nhập không thành công`
            }
        }
        return {
            state: 1,
            data: result,
            mess: `Cập nhập thành công.`
        }
    }

    public async GetPublic(): Promise<any> {
        const where: any = {
            EndSubmission: { [Op.gt]: new Date() },
            IsApproved: true
        }
        const result = await this.uow.RARepository.filter(where);
        if (!result || result.length < 1) {
            return {
                state: 0,
                mess: `Không có tin tuyển dụng`
            }
        }
        else {
            return {
                state: 1,
                data: result
            }
        }
    }

    public async GetAll(limit: number, page: number): Promise<any> {
        const result = await this.uow.RARepository.getAll(limit, page)
        if (!result) {
            return {
                state: 0,
                mess: `Chưa có dữ liệu`
            }
        }
        return {
            state: 1,
            data: result
        }
    }
}