import EmployeeController from "../controllers/EmployeeController";
import { AuthMiddleware } from "../middlewares/AuthMiddleware";

const employeeRoute = require('express').Router();

employeeRoute.put('/edit', AuthMiddleware.AuthenticateJWT,EmployeeController.Edit)
employeeRoute.get('/me', AuthMiddleware.AuthenticateJWT,EmployeeController.GetById)

export default employeeRoute;