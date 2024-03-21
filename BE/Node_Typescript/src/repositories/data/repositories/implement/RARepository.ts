import { RecruitmentArticle } from "../../models/RecruitmentArticle";
import { BaseRepository } from "../BaseRepository";

export default class RARepository extends BaseRepository<RecruitmentArticle>{
    constructor() {
        super(RecruitmentArticle);
    }
}