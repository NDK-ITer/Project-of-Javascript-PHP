import RAController from "../controllers/RAController";
import AuthMiddleware from "../middlewares/AuthMiddleware";

const raRoute = require('express').Router();

raRoute.get('/public', RAController.GetById);
raRoute.get('/public/all', RAController.GetPublic)
raRoute.post('/upload', AuthMiddleware.AuthenticateJWT ,RAController.Upload)
raRoute.put('/update', AuthMiddleware.AuthenticateJWT ,RAController.Edit)
raRoute.put('/apply', AuthMiddleware.AuthenticateJWT, RAController.Apply)
raRoute.put('/set-approved', AuthMiddleware.AuthenticateJWT, RAController.SetApproved)
// raRoute.put('/')

export default raRoute;