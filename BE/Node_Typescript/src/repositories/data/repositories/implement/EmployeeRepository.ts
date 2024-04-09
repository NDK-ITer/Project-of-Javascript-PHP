import { Employee } from "../../models/Employee";
import { BaseRepository } from "../BaseRepository";


export default class EmployeeRepository extends BaseRepository<Employee>{
    constructor() {
        super(Employee);
        
    }
    
}