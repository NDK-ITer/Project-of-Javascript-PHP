import fs from 'fs';
import path from 'path';

export class FileMethods{
    static async Delete(filePath: string){
        fs.access(filePath, fs.constants.F_OK, (err) => {
            if (err) {
                return{
                    state: 0,
                    mess: `File does not exist`
                }
            }
            fs.unlink(filePath, (err) => {
                if (err) {
                    return{
                        state: -1,
                        error: err
                    }
                }
                return{
                    state: 1,
                    mess: `File deleted successfully`
                }
            });
        });
    }

    static async readImage(imagePath: string): Promise<Buffer> {
        return new Promise((resolve, reject) => {
            fs.readFile(imagePath, (err, data) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(data);
                }
            });
        });
    }

    static async saveImage(Data: Buffer, uploadDir: string, Name: string): Promise<any> {
        try {
            return new Promise((resolve, reject) => {
                const imagePath = path.join(uploadDir, Name);
                fs.writeFile(imagePath, Data, (err) => {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(Name);
                    }
                });
            });
        } catch (error) {
            return error
        }
        
    }
}
