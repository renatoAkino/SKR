const express = require('express');
const router = express.Router();
const mysql = require('../mysql').pool;




router.get('/', (req, res, next) => {
    getBuildings().then(function(buildings){
        res.status(200).send(buildings)
    })
        
});


router.post('/', (req, res, next) => {

    const filter = {
        category: req.body.category ? req.body.category : null,
        type: req.body.type ? req.body.type : null,
    }
    filterBuildings(filter).then(function(building){
        res.status(200).send(building)
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

function filterBuildings(filter){
    sql = 'SELECT * FROM buildings WHERE ';
    if(filter.category != "any"){
        sql = sql + "categoryBuilding = '"+ filter.category +"' AND ";
    }
    if(filter.type != "any"){
        sql = sql + "typeBuilding = '"+ filter.type +"'";
    }else{
        sql = sql + "1 = 1";
    }
    console.log(sql);
    return new Promise(function(resolve, reject){        
        mysql.getConnection((err, connection) => {
            if(err) throw err
            connection.query(sql,
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