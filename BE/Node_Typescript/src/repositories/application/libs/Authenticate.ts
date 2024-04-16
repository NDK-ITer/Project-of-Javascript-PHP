import * as jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import speakeasy from 'speakeasy';

export class Authenticate {
    static async GenerateJWT(payload: any, secretKey: string, expiresIn?: string): Promise<string | null> {
        if (payload == null || (secretKey == null || secretKey == '')) return null
        const tokenExpiresIn = expiresIn || '7d';
        const token = jwt.sign(payload, secretKey, { expiresIn: tokenExpiresIn });
        return token;
    }

    static async VerifyAndDecodeJWT(token: string, secretKey: string): Promise<any> {
        try {
            const decoded = jwt.verify(token, secretKey);
            return decoded;
        } catch (error) {
            console.error('Invalid token');
            return null;
        }
    }

    static async HashingPassword(plaintextPassword: string): Promise<string> {
        const saltRounds = 10;
        const hash = await bcrypt.hash(plaintextPassword, saltRounds);
        return hash;
    }

    static async ComparePasswords(enteredPassword: string, hashedPassword: string): Promise<boolean> {
        if (!enteredPassword || !hashedPassword) return false
        const result = await bcrypt.compare(enteredPassword, hashedPassword);
        return result;
    }

    static async CreateOPTCode(): Promise<string> {
        const secret = speakeasy.generateSecret({ length: 20 });
        const token = speakeasy.totp({
            secret: secret.base32,
            encoding: 'base32',
        });
        return token;
    }
}