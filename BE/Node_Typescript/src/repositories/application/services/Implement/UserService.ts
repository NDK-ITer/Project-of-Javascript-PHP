import BaseService from "../BaseService";

export default class UserService extends BaseService {

    constructor() {
        super();
    }

    public async Create(data: {
        email: string,
        password: string,
        employee:object,
        employer:object
    }): Promise<any>{
        
    }

    public async GetJWT(data: {
        email:string,
        password:string
    }): Promise<any>{
        
    }

    public async GetById(id: string): Promise<any>{

    }

    public async GetAll(): Promise<any>{
        return await this.ImportRole()
    }

    public async Block(id:string): Promise<any>{
        
    }
}