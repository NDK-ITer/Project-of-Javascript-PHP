import * as nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
        user: 'ndksender120802@gmail.com',
        pass: 'waccdmsydouopgt'
    }
});

export class MailSender {
    constructor() { }

    static async Send(toEmail: string, subject: string, content: string): Promise<boolean> {
        
        try {
            const mailOptions = {
                from: 'ndksender120802@gmail.com',
                to: toEmail,
                subject: subject,
                text: content
            };
            await transporter.sendMail(mailOptions);
            return true;
        } catch (error) {
            return false;
        }
    }
}

