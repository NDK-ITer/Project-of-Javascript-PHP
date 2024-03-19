import * as jwt from 'jsonwebtoken';


export class Authenticate{
    static GenerateJWT(payload: any, secretKey: string, expiresIn?: string): any{
        const defaultExpiresIn = '7d'; 
        const tokenExpiresIn = expiresIn || defaultExpiresIn;
        const token = jwt.sign(payload, secretKey, { expiresIn: tokenExpiresIn });
        return token;
    }

    static VerifyAndDecodeJWT(token: string, secretKey: string): any{
        try {
            const decoded = jwt.verify(token, secretKey);
            return decoded;
        } catch (error) {
            console.error('Invalid token');
            return null;
        }
    }
}