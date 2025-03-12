// app.js
// Main entry point for application

const express = require('express');
const mysql = require('mysql');
const path = require('path');
const bodyParser= require('body-parser');
const app = express();
const { getHomePage} = require('./routes/index');
const game = require('./routes/game');
const game_session = require('./routes/game_session');

// TODO: application port should come from config file
const port = 3000;

// TODO: database connection parameters should come from config file
const db = mysql.createConnection({
	host: 'localhost',
	user: 'app',
	password: 'wonderful',
	database: 'miechallenge'})

db.connect((err) => {
	if (err) {
		throw err;
	}
	console.log('Connected to database');
});

global.db = db;

app.set('port', process.env.port || port);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: false }));

// If there are static files, make a public directory
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/', getHomePage);
app.get('/add-game', game.getAdd);
app.post('/add-game', game.postAdd);
app.get('/edit-game/:id', game.getEdit);
app.post('/edit-game/:id', game.postEdit);
app.get('/add-game-session', game_session.getAdd);
app.post('/add-game-session', game_session.postAdd);

app.listen(port, () => {
	console.log(`Server running on port: ${port}`);
});
