var express = require('express');
var app = express();

// Add some public routes that are accessible to everyone
app.get('/', function(req, res){
    res.send('<h1>Welcome to the Hompeage. <small>(Everyone can view this page)</small></h1>');
})

app.get('/test', function(req, res){
    res.send('<h1>Welcome to the about page<small>(Everyone can view this page)</small></h1>');
})

// Add some protected routes that only authenticated users will have access to
app.get('/api/leads', function(req, res){
    res.json({leads:[{id: 12345, name: 'ACME Corp'}, {id: 23456, name:'LeadGen'}, {id:45677, name: 'Organic Leads'}]})
})

app.get('/api/employees', function(req, res){
    res.json({employees:[{name: 'Ado Kukic', username:'@ado'}, {name: 'Diego Poza', username:'@tony'}, {name:'Prosper Otemuyiwa', username:'@unicodedeveloper'}, {name:'Sebastian Peyrott', username:'@speyrott'}, {name:'Kim Maida', username:'@kim.maida'}]})
})

app.listen(9000);