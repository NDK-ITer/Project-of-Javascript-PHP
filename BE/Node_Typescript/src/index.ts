import { sequelize } from "./repositories/access/sequelize";

const express = require('express');
const body = require('body-parser');

const app = express();
const PORT = 7000;

sequelize.sync()

app.use(body.json({
    limit: '2mb'
}));

app.get('/', (req:any, res:any) => {
    res.send('Hello, world!');
});

app.listen(PORT, () => {
    console.log(`http://localhost:${PORT}/`);
});
