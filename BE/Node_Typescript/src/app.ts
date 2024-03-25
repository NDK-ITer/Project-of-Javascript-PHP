import { ConnectDatabase } from "./repositories/access/ConnectDatabase";
import dotenv from 'dotenv';
import cors from 'cors';
import { publicPath } from "./constants";

import authRoute from "./routes/AuthRoute";
import UOWService from "./repositories/application/services/UOWService";

const express = require('express');
const body = require('body-parser');
const app = express();
ConnectDatabase()
dotenv.config();

const port = process.env.PORT || 7000;

const corsOptions = {
    origin: 'http://localhost:3000',
    optionsSuccessStatus: 200
}

app.use(cors(corsOptions));

app.use(body.json({
    limit: '2mb'
}));
//route
app.use('/api/auth',authRoute)
app.get('/api/tem', async (req: any, res: any) => {
    const result = await UOWService.RoleService.GetAll()
    res.json(result);
});
//static
app.use('/', express.static(publicPath));

app.listen(port, () => {
    console.log(`http://localhost:${port}/`);
});


