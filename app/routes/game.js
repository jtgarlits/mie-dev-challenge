module.exports = {
	getAdd: (req, res) => {
		res.render('add-game.ejs', {
			title: 'Board Games | Add game'
		});
	},
	getEdit: (req, res) => {
		res.render('edit-game.ejs', {
			title: 'Board Games | Edit game'
		});
	},
	postAdd: (req, res) => {
		// TODO db.query to insert game

		// If all went well, go back to main screen
		res.redirect('/');
	},
	postEdit: (req, res) => {
		let id = req.params.id;

		// TODO db.query to update game

		res.redirect('/');
	}
};
