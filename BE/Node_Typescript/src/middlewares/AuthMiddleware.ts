import { Response, NextFunction } from 'express';
import { Authenticate } from '../repositories/application/libs/Authenticate';

const secretKey = String(process.env.SECRET_KEY)

export class AuthMiddleware{
    static async AuthenticateJWT(req: any, res: Response, next: NextFunction){
        const token = String((req.headers as any).authorization).split(' ')[1];
        if (!token) {
            return res.json({ 
                state: 0,
                mess: 'Login please!' 
            });
        }
        const decodedUser = await Authenticate.VerifyAndDecodeJWT(token, secretKey);
        if (!decodedUser) {
            return res.json({ 
                state: 0,
                mess: 'Please login again' 
            });
        }
        req.user = decodedUser
        next();
    }
}