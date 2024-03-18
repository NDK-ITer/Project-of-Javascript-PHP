import { ConnectDatabase } from "./repositories/access/ConnectDatabase";
import dotenv from 'dotenv';
import cors from 'cors';

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

app.get('/', (req:any, res:any) => {
    res.send('Hello, world!');
});

app.listen(process.env.PORT, () => {
    console.log(`http://localhost:${process.env.PORT}/`);
});


