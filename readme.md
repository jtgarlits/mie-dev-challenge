Story: Board Game Directory
=====

A few months ago, your best friend organized a weekly board game night. As the number of participants
has grown, so has the library of available games. Your friend has asked you to create a website to
track which games are available, as well as all the times they have been played. Your goal is to
create a good-looking prototype that you won't be embarrassed to show your friend, not a fully-finished
product.

Requirements
=====

* Ability to add and edit a board game record
* Ability to add multiple game session records associated with a game
* Main screen should include a listing of available games, including the date of the most recent game session for each

Technical detail
=====

You should be able to develop on Windows, Mac, or Linux. The project has already been started for you. Out of the many, many alternatives, these are the tools we've chosen for this challenge:

* <a href="https://nodejs.org/en/">node.js</a>
* <a href="https://expressjs.com/">express - web server</a>
* <a href="https://ejs.co/">EJS - templating</a>
* <a href="https://mariadb.org/">MariaDB - database backend</a>

Also, consider using a [Dockerfile](https://docs.docker.com/engine/reference/builder/) to build your development environement.


Please note:

* We have not defined the database schema for you. You should decide which fields would be useful to collect and what the table structure should be and put the statements necessary for that in schema.sql.
* Include sample data in your schema.sql file so that we can see what your app looks like fully populated from the start.
* If you see any "TODO" comments in code, those are for you!

Features that are not required
=====

* User account management
* Reactivity

Bonus
=====

For extra points, think of a useful feature to add to the system that your friend didn't mention. Also, you can implement the database using a docker container (notes below)

Getting the code and completing your challenge
=====

1) Since this is a [git template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template), it isn't possible to fork it, so you will need to "[Use template](https://docs.github.com/assets/cb-77734/mw-1440/images/help/repository/use-this-template-button.webp)" and clone it to your local development environment. Then, create a private github repository of your own and change that to be the upstream of your local copy. Once you are ready for us to see your code, add these users as collaborators to your project:

* https://github.com/tslabach
* https://github.com/lpeckham1
* https://github.com/dcornewell
* https://github.com/ariserac
* https://github.com/horner

2) update the README in your repository with some screenshots and a link to a YouTube short/video demonstrating your solution 


Docker Notes if you'd like to implement a docker container for the database
============
To start the database as a docker service:
```
docker run --name=miedb -d -p 3307:3306 -e MARIADB_USER=app -e MARIADB_PASSWORD=wonderful -e MARIADB_DATABASE=miechallenge -e MARIADB_ROOT_PASSWORD=wonderful mariadb:latest
```
NOTE!!!, do not leave the docker running when done testing.  Do a `docker kill miedb` to kill it when done BUT the data in the database will BE GONE!  You can restart it by doing `docker restart miedb` but you should consider doing a `docker rm miedb` to cleanup.

You can connect to it from the host machine using:
`mysql --host=localhost -P 3307 --user=app --password=wonderful miechallenge`
or from docker by doing:
`docker exec -it miedb mysql --host=localhost -P 3306 --user=app --password=wonderful miechallenge`

Bonus points if you can make a fully automated Dockerfile container for building and testing the app with a GitHub Action.


How MIE will test your code (change this if needed)
=====

* Reviewer will:

```

# if the developer does not know about or is incapable of dockerizing mysql and loading the data...
export APPLICANT_USER=''
git clone git@github.mieweb.com:$APPLICANT_USER/mie-dev-challenge devchallenge_$APPLICANT_USER
mysql -e "CREATE DATABASE devchallenge_$APPLICANT_USER"
mysql devchallenge_$APPLICANT_USER < schema.sql


# what we really should just have to to (if they do not do the bonus):
npm install
npm start
```
