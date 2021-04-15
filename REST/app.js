const express = require('express');
const bodyParser = require('body-parser');
const app = express();



const buildingRoute = require('./routes/building');
const { json } = require('body-parser');

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.use('/building', buildingRoute);    
app.use('/teste',(req, res, next) => {
    res.status(200).send({
        mensagem: 'Teste'
    })
});

module.exports = app;