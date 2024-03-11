const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000; // Sử dụng cổng môi trường hoặc cổng 3000 nếu không có

app.get('/', (req:any, res:any) => {
    res.send('Hello, world!');
});

app.listen(PORT, () => {
    console.log(`http://localhost:${PORT}/`);
});
