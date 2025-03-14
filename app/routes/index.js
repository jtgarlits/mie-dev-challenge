module.exports = {
	getHomePage: (req, res) => {
		// TODO: Make query for games list
		let query = "SELECT 1 AS t";

		db.query(query, (err, result) => {
			if (err) {
				res.redirect('/');
			}
			res.render('index.ejs', {
				title: 'Board Games | View Games',
				players: result
			});
		});
	}
};
