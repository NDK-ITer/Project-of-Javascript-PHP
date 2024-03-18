import { ConnectDatabase } from "./repositories/access/ConnectDatabase";

const express = require('express');
const body = require('body-parser');

const app = express();
const PORT = 7000;

ConnectDatabase()

app.use(body.json({
    limit: '2mb'
}));

app.get('/', (req:any, res:any) => {
    res.send('Hello, world!');
});

app.listen(PORT, () => {
    console.log(`http://localhost:${PORT}/`);
});
