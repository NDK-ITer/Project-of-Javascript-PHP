import EmployerController from "../controllers/EmployerController";
import { AuthMiddleware } from "../middlewares/AuthMiddleware";

const employerRoute = require('express').Router();

employerRoute.put('/edit', AuthMiddleware.AuthenticateJWT,EmployerController.Edit)
employerRoute.get('/me', AuthMiddleware.AuthenticateJWT,EmployerController.GetById)

export default employerRoute;