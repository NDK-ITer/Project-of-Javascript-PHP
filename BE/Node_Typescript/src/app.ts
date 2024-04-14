import { ConnectDatabase } from "./repositories/access/ConnectDatabase";
import dotenv from 'dotenv';
import cors from 'cors';
import { publicPath } from "./constants";
import swaggerUi from 'swagger-ui-express';
import authRoute from "./routes/AuthRoute";
import fieldRoute from "./routes/FieldRoute";
import employeeRoute from "./routes/EmployeeRoute";
import employerRoute from "./routes/EmployerRoute";
import raRoute from "./routes/RARoute";
import specs from "./swaggerConfig";

const express = require('express');
const body = require('body-parser');
const app = express();
ConnectDatabase()
dotenv.config();

const port = process.env.PORT || 7000;

//options
const corsOptions = {
    origin: 'http://localhost:3000',
    optionsSuccessStatus: 200
}
app.use(cors(corsOptions));
app.use(body.json({
    limit: '2mb'
}));
//route
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));
app.use('/api', authRoute)
app.use('/api/field', fieldRoute)
app.use('/api/employee', employeeRoute)
app.use('/api/employer', employerRoute)
app.use('/api/ra', raRoute)
//static
app.use('/', express.static(publicPath));

app.listen(port, () => {
    console.log(`http://localhost:${port}/`);
});


