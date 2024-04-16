import { RecruitmentArticle } from "../../models/RecruitmentArticle";
import { BaseRepository } from "../BaseRepository";

export default class RARepository extends BaseRepository<RecruitmentArticle>{
    constructor() {
        super(RecruitmentArticle);
    }

    async getPublic(page?: number, limit?: number): Promise<RecruitmentArticle[]> {
        if (page && limit) {
            const offset = (page - 1) * limit;
            return await this.model.findAll({where: {
                IsApproved: true
            }, limit, offset });
        }
        return await this.model.findAll();
    }
}