import { Field } from "../../models/Field";
import { BaseRepository } from "../BaseRepository";


export default class FieldRepository extends BaseRepository<Field>{
    constructor() {
        super(Field)
    }
}