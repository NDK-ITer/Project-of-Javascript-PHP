import { Employer } from "../../models/Employer";
import { BaseRepository } from "../BaseRepository";


export default class EmployerRepository extends BaseRepository<Employer>{
    constructor() {
        super(Employer);
    }
}