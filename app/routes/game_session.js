module.exports = {
	getAdd: (req, res) => {
		res.render('add-game.ejs', {
			title: 'Board Games | Add game'
		});
	},
	postAdd: (req, res) => {
		console.log(req.body);

		// TODO db.query to insert game-playing session

		res.redirect('/');
	}
};
