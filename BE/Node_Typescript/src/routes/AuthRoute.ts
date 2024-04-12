import AuthController from "../controllers/AuthController";

const authRoute = require('express').Router();

authRoute.post('/register', AuthController.Register)
authRoute.post('/login', AuthController.Login)
authRoute.get('/all-role', AuthController.GetAllRole)

export default authRoute;