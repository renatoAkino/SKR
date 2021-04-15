const express = require('express');
const router = express.Router();
const mysql = require('../mysql').pool;




router.get('/', (req, res, next) => {
    /*const building = {
        id_building : req.body.id_building,
        name_building : req.body.name_building
    }

    res.status(200).send({
        mensagem: 'Teste buildings',
        bulding: building
    })*/

    mysql.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)
        
        connection.query('SELECT * FROM buildings',
         (error, result) => {
            connection.release()

            if(!error){
                const response = row;
                return res.status(200).send(response);
            }

            
        })
    });
});

router.post('/', (req, res, next) => {
    res.status(201).send({
        mensagem: 'Teste buildings post'
    })
});

router.get('/:id_produto', (req, res, next) => {
    res.status(200).send({
        mensagem: 'Teste individual'
    })
})

module.exports = router