import { ConnectDatabase } from "./repositories/access/ConnectDatabase";
import dotenv from 'dotenv';
import cors from 'cors';

import RoleRepository from './repositories/data/repositories/implement/RoleRepository'
import { Role } from "./repositories/data/models/Role";

const express = require('express');
const body = require('body-parser');
const app = express();
ConnectDatabase()
dotenv.config();

const corsOptions = {
    origin: 'http://localhost:3000', 
    optionsSuccessStatus: 200 
}

app.use(cors(corsOptions));

app.use(body.json({
    limit: '2mb'
}));

app.get('/', async (req:any, res:any) => {
    const roleRepository = new RoleRepository();
    const result:any = await roleRepository.findById('0325ed0a-d2dd-4de5-9ce6-1e0a51b9791c');
    res.json({
        name: result.Name
    });
});

app.listen(process.env.PORT, () => {
    console.log(`http://localhost:${process.env.PORT}/`);
});


