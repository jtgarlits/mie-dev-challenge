# MIE Board Game Directory

**Dev Log – March 13**  
- **Set up Docker** with **docker-compose.yml** to run both **MariaDB** and the **Node.js/Express** app.  
- Added a **GitHub Action** (`.github/workflows/docker-ci.yml`) to build and spin up containers automatically for CI.  
- Created a **Dockerfile** for the Node app, installing dependencies and exposing port 3000.  
- Ensured `dotenv` is included in `package.json` and verified the database connection uses environment variables.  
- Confirmed the app runs at `localhost:3000` and successfully connects to the DB in Docker.

**How to Start the App**

1. **Docker Compose (Recommended)**  
   - Clone this repository:  
     ```bash
     git clone <https://github.com/jtgarlits/mie-dev-challenge> mie-dev-challenge
     cd mie-dev-challenge
     ```
   - Build and run the containers:  
     ```bash
     docker compose build
     docker compose up -d
     ```
   - App will be on [http://localhost:3000](http://localhost:3000).  

2. **Local (No Docker)**  
   - Make sure you have Node.js installed.  
   - Create a local database named `miechallenge` (e.g., via `mysql -e "CREATE DATABASE miechallenge"`).  
   - Install dependencies and start the server:  
     ```bash
     npm install
     npm start
     ```
   - By default, the app runs on [http://localhost:3000](http://localhost:3000).
