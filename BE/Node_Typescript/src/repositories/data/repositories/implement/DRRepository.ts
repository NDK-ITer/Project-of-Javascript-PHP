import { DetailRecruitment } from "../../models/DetailRecruitment";
import { BaseRepository } from "../BaseRepository";


export default class DRRepository extends BaseRepository<DetailRecruitment>{
    constructor() {
        super(DetailRecruitment);
        
    }
    
}