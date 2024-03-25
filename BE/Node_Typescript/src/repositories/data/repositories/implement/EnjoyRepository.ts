import { Enjoy } from "../../models/Enjoy";
import { BaseRepository } from "../BaseRepository";


export default class EnjoyRepository extends BaseRepository<Enjoy>{
    constructor() {
        super(Enjoy);
    }
}