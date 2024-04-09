import { Request, Response, NextFunction } from 'express';

export default class ValidateMiddleware {

    static async EmailValidate(req: Request, res: Response, next: NextFunction) {
        const email: string = req.body.email;
        if (!email) {
            return res.status(200).json({
                state: 0,
                mess: `Email là bắt buộc!`
            });
        }
        const emailRegex: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(200).json({
                state: 0,
                mess: `Email không đúng định dạng!`
            });
        }
        next();
    }

    static async PasswordValidate(req: Request, res: Response, next: NextFunction) {
        const password: string = req.body.password;
        if (!password) {
            return res.status(200).json({
                state: 0,
                mess: `Mật khầu là bắt buộc!`
            });
        }
        const passwordRegex: RegExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        if (!passwordRegex.test(password)) {
            return res.status(200).json({
                state: 0,
                mess: `Mật khẩu phải dài ít nhất 8 ký tự và chứa ít nhất một chữ hoa, một chữ thường, một số và một ký tự đặc biệt!`
            });
        }
        next();
    }

    static async PhoneNumberValidate(req: Request, res: Response, next: NextFunction) {
        const phoneNumber: string = req.body.phoneNumber;
        const phoneRegex: RegExp = /^\+?[0-9]{8,}$/;
        if (phoneNumber) {
            if (!phoneRegex.test(phoneNumber)) {
                return res.status(400).json({
                    state: 0,
                    mess: `Số điện thoại không đúng định dạng!`
                });
            }
        }
        next();
    }
}
