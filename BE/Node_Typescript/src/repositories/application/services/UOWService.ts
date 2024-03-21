import RoleService from "./Implement/RoleService";
import UserService from "./Implement/UserService";


export default class UOWService {
    public RoleService: RoleService
    public UserService: UserService
    constructor() {
        this.RoleService = new RoleService()
        this.UserService = new UserService()
    }
}