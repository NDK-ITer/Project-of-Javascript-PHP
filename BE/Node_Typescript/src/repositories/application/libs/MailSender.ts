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

    public async send(toEmail: string, subject: string, content: string): Promise<any> {
        const mailOptions = {
            from: 'ndksender120802@gmail.com',
            to: toEmail,
            subject: subject,
            text: content
        };
        await transporter.sendMail(mailOptions);
    }
}

