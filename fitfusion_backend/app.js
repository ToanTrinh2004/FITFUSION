const express = require('express');
const body_paser = require('body-parser');
const userRouter = require('./routers/user.router');

const app = express();
app.use(body_paser.json());

app.use('/',userRouter);
module.exports = app;
