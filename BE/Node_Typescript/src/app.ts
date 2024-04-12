import { ConnectDatabase } from "./repositories/access/ConnectDatabase";
import dotenv from 'dotenv';
import cors from 'cors';
import { publicPath } from "./constants";
import swaggerUi from 'swagger-ui-express';
import swaggerJsdoc from 'swagger-jsdoc';

import authRoute from "./routes/AuthRoute";
import UOWService from "./repositories/application/services/UOWService";
import fieldRoute from "./routes/FieldRoute";
import employeeRoute from "./routes/EmployeeRoute";
import employerRoute from "./routes/EmployerRoute";
import { title } from "process";

const express = require('express');
const body = require('body-parser');
const app = express();
ConnectDatabase()
dotenv.config();

const port = process.env.PORT || 7000;

//options
const optionsSwagger = {
    swaggerDefinition: {
        openapi: '3.0.0',
        info: {
            title: 'Node TS API',
            version: '1.0.0'
        },
        servers: [
            {
                url: `http://localhost:${port}/`
            }
        ]
    },
    apis: ['./app.ts']
};
const corsOptions = {
    origin: 'http://localhost:3000',
    optionsSuccessStatus: 200
}
app.use(cors(corsOptions));
app.use(body.json({
    limit: '2mb'
}));
//route
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerJsdoc(optionsSwagger)));
app.use('/api', authRoute)
app.use('/api/field', fieldRoute)
app.use('/api/employee', employeeRoute)
app.use('/api/employer', employerRoute)
app.get('/api/tem', async (req: any, res: any) => {
    const result = await UOWService.RoleService.GetAll()
    res.json(result);
});
//static
app.use('/', express.static(publicPath));

app.listen(port, () => {
    console.log(`http://localhost:${port}/`);
});


