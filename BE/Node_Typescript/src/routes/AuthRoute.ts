import AuthController from "../controllers/AuthController";
import AuthMiddleware from "../middlewares/AuthMiddleware";
import ValidateMiddleware from "../middlewares/ValidateMiddleware";

const authRoute = require('express').Router();

authRoute.post('/register',
    ValidateMiddleware.EmailValidate,
    ValidateMiddleware.PasswordValidate,
    ValidateMiddleware.PhoneNumberValidate,
    AuthController.Register
)
authRoute.post('/login',
    ValidateMiddleware.EmailValidate,
    AuthController.Login
)
authRoute.post('/forgot-password',
    ValidateMiddleware.EmailValidate,
    AuthController.ForgotPassword
)
authRoute.post('/reset-password/identify', AuthMiddleware.AuthenticateJWT,
    AuthController.ResetPassword
)
authRoute.post('/reset-password/otp', AuthController.ResetPassword)
authRoute.get('/all-role', AuthController.GetAllRole)

export default authRoute;