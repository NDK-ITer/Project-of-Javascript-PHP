import RoleService from "./Implement/RoleService";
import UserService from "./Implement/UserService";


export default class UOWService {
    public static RoleService: RoleService = new RoleService()
    public static UserService: UserService = new UserService()
    constructor() {
    }
}