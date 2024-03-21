import { Role } from "../../models/Role";
import { BaseRepository } from "../BaseRepository";

export default class RoleRepository extends BaseRepository<Role>{
    constructor() {
        super(Role);
    }
}