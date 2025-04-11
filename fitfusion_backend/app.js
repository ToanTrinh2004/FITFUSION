const express = require('express');
const cors = require("cors");
const body_paser = require('body-parser');
const userRouter = require('./routers/user.router');
const chatbotRouter = require('./routers/chatbot.router');
const personalTrainerRouter = require('./routers/personalTrainer.router');

const app = express();
app.use(body_paser.json());
app.use(cors());

app.use('/api/user',userRouter);
app.use('/api/chatbot', chatbotRouter);
app.use('/api/PT',personalTrainerRouter); 
module.exports = app;
