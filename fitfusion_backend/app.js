const express = require('express');
const body_paser = require('body-parser');
const userRouter = require('./routers/user.router');
const chatbotRouter = require('./routers/chatbot.router');
const personalTrainerRouter = require('./routers/personalTrainer.router');

const app = express();
app.use(body_paser.json());

app.use('/',userRouter);
app.use('/api/chatbot', chatbotRouter);
app.use('api/personalTrainer',personalTrainerRouter); 
module.exports = app;
