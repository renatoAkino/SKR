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

    getBuildings().then(function(buildings){
        res.status(200).send(buildings)
    })
        
});


router.post('/', (req, res, next) => {
    res.status(201).send({
        mensagem: 'Teste buildings post'
    })
});

router.get('/:idBuilding', (req, res, next) => {
    const id = req.params.idBuilding;
    getImage(id).then(function(images){
        res.status(200).send(images)
    })
})


function getBuildings(){
    return new Promise(function(resolve, reject){
        mysql.getConnection((err, connection) => {
            if(err) throw err
            console.log(`connected as id ${connection.threadId}`)
            connection.query('SELECT * FROM buildings',
             (error, result, fields) => {
                connection.release()    
                if(!error){
                    resolve(result)
                    
                }
                
            })
    
    })
})
}

function getImage(idBuilding){
    return new Promise(function(resolve, reject){        
        mysql.getConnection((err, connection) => {
            if(err) throw err
            connection.query('SELECT * FROM images WHERE idBuilding = ?',[idBuilding],
             (error, result, fields) => {
                connection.release()    
                if(!error){
                    resolve(result)
                    
                }
                
            })
    
        })
    })
}

module.exports = router