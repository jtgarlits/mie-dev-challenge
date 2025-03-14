# MIE Board Game Directory

**Dev Log – March 13**  
- **Set up Docker** with **docker-compose.yml** to run both **MariaDB** and the **Node.js/Express** app.  
- Added a **GitHub Action** (`.github/workflows/docker-ci.yml`) to build and spin up containers automatically for CI.  
- Created a **Dockerfile** for the Node app, installing dependencies and exposing port 3000.  
- Ensured `dotenv` is included in `package.json` and verified the database connection uses environment variables.  
- Confirmed the app runs at [http://localhost:3000](http://localhost:3000) and successfully connects to the DB in Docker.

**Dev Log – March 14**  
- **Created the database schema** to include player tables, session expansions, min/max players, cooperative vs. competitive settings, and robust sample data.  
- **Refined environment variable usage**, ensuring both Docker and local development pick up the same variables consistently.  
- Cleaned up Docker files and folder structure to keep the Node.js app code and database schema neatly separated.  
- Verified that you can run the Node.js app both locally and via Docker Compose without duplicating environment variables in multiple places.

---

## How to Start the App

1. **Docker Compose (Recommended)**  
   - Clone this repository:  
     ```bash
     git clone https://github.com/jtgarlits/mie-dev-challenge mie-dev-challenge
     cd mie-dev-challenge
     ```
   - Build and run the containers:  
     ```bash
     docker compose build
     docker compose up -d
     ```
   - The app will be running at [http://localhost:3000](http://localhost:3000).

2. **Local (No Docker)**  
   - Make sure you have Node.js installed.  
   - Create a local database named `miechallenge` (e.g., via `mysql -e "CREATE DATABASE miechallenge"`).  
   - Install dependencies and start the server:  
     ```bash
     npm install
     npm start
     ```
   - By default, the app runs at [http://localhost:3000](http://localhost:3000).

---

## How to Shut Down the App

1. **If Running via Docker Compose**  
   - In your project folder:
     ```bash
     docker compose down
     ```
   - This stops and removes the running containers. Your database data persists in the named volume `db_data`, unless you remove it with `docker compose down -v`.

2. **If Running Locally (No Docker)**  
   - In the terminal where `npm start` is running, press **Ctrl + C** (or **Cmd + C** on macOS) to stop the server.
