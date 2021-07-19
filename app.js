const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const flash  = require('express-flash-messages');

const port = process.env.port || 3000;
const app = express();

app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");
app.use( express.static( "public" ) );
app.use(flash());

// db conn
var dbConn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'bank system'
});
// connect to database
dbConn.connect();


// render home
app.get('/', function(req, res){
    return res.render('home');
})


// all
app.get('/all', function(req, res){
    dbConn.query('SELECT * FROM users', function (error, results, fields){
        if(error) throw error;
    return res.render('all', {results: results});
    });
})


app.get('/all/:id', function(req, res){
    var id = req.params.id
    var q1 = 'select * from users where id='+id;
    var q2 = 'select * from users where id!='+id;
    dbConn.query(q1, function(err, result1, fields){
        // async: true;
        if(err) throw err;
        else{
            dbConn.query(q2, function(err, result2, fields){
                if(err) throw err;
            return res.render('viewone', {result1: result1, result2: result2, id: id});
            });
        }
    });
});  
  

// transaction history
app.get('/trans', function(req, res){
    dbConn.query('SELECT * FROM transaction', function (error, results, fields){
        if(error) throw error;
    return res.render('trans', {results: results});
    });
})

// transfer
app.post('/transfer/:ids', function(req, res){
    var idr, amount,ids;
    ids = req.params.ids;

    idr = req.body.receiver;
    amount = req.body.amount;
    var q1 = 'select balance from users where id='+ids;

    dbConn.query(q1, function(err, results, fields){
        // console.log(results[0].balance);
            var sender, receiver, transac;
            sender = 'update users set balance = balance -'+amount+' where id='+ids;
            receiver = 'update users set balance = balance + '+amount+ ' where id = '+idr;
            transac = 'insert into transaction (sender, receiver, balance) values ('+ids+', '+idr+ ' , '+amount+')';

            dbConn.query(sender, function(err,results,fields){
                if(err) throw err;
                else{

                    dbConn.query(receiver,function(err,resultr,fields){
                        if(err) throw err;
                        
                        dbConn.query(transac, function(err, resultt, fields){
                            if(err) throw err;
                            // alert('Transaction successfull');
                            // res.jsonp({success : true});
                            return res.redirect('/all');
                        })
                    })
                }
            })
    })
})

// listen
app.listen(port, (req, res, err) =>{
    console.log('running on port 3000');
})