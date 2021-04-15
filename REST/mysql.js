const mysql = require('mysql');

var pool = mysql.createPool({
    "user"      : 'root', //process.env.MYSQL_USER,
    "password"  : '', //process.env.MYSQL_PASSWORD,
    "database"  : 'skr', //process.env.MYSQL_DATABASE,
    "host"      : 'localhost' //process.env.MYSQL_HOST
});

exports.pool = pool;