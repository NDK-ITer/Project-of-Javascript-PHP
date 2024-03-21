import DRRepository from "./implement/DRRepository";
import EmployeeRepository from "./implement/EmployeeRepository";
import EmployerRepository from "./implement/EmployerRepository";
import EnjoyRepository from "./implement/EnjoyRepository";
import FieldRepository from "./implement/FieldRepository";
import RARepository from "./implement/RARepository";
import RoleRepository from "./implement/RoleRepository";
import UserRepository from "./implement/UserRepository";


export default class UOWRep {
    
    public UserRepository: UserRepository;
    public RoleRepository: RoleRepository;
    public RARepository: RARepository;
    public FieldRepository: FieldRepository;
    public EnjoyRepository: EnjoyRepository;
    public EmployerRepository: EmployerRepository;
    public EmployeeRepository: EmployeeRepository;
    public DRRepository: DRRepository;
    
    constructor() {
        this.UserRepository = new UserRepository()
        this.RoleRepository = new RoleRepository()
        this.RARepository = new RARepository()
        this.FieldRepository = new FieldRepository()
        this.EnjoyRepository = new EnjoyRepository()
        this.EmployerRepository = new EmployerRepository()
        this.EmployeeRepository = new EmployeeRepository()
        this.DRRepository = new DRRepository()
    }
}