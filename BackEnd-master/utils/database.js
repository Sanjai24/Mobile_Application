const mysql = require('mysql2');
require('dotenv').config();

let database = mysql.createPool(
    {
        user: process.env.RDS_USERNAME,
        password: process.env.RDS_PASSWORD,
        database: 'authenticate',
        host: process.env.RDS_HOSTNAME,
        port: process.env.RDS_PORT,
        multipleStatements: true,

    }
);

database.getConnection(function(err){
    if(err){
        console.log('Database connection failed' + err);
    }
    else{
        console.log('Database connected');
    }
})

module.exports = database;