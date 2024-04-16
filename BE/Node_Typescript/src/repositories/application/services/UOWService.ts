import DRService from "./Implement/DRService";
import EmployeeService from "./Implement/EmployeeService";
import EmployerService from "./Implement/EmployerService";
import FieldService from "./Implement/FieldService";
import RAService from "./Implement/RAService";
import RoleService from "./Implement/RoleService";
import UserService from "./Implement/UserService";


export default class UOWService {
    public static DRService: DRService = new DRService();
    public static RAService: RAService = new RAService()
    public static RoleService: RoleService = new RoleService()
    public static FieldService: FieldService = new FieldService()
    public static UserService: UserService = new UserService()
    public static EmployeeService: EmployeeService = new EmployeeService()
    public static EmployerService: EmployerService = new EmployerService()
    constructor() {
    }
}