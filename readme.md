# MIE Board Game Directory

**Dev Log – March 13**  
- **Set up Docker** with **docker-compose.yml** to run both **MariaDB** and the **Node.js/Express** app.  
- Added a **GitHub Action** (`.github/workflows/docker-ci.yml`) to build and spin up containers automatically for CI.  
- Created a **Dockerfile** for the Node app, installing dependencies and exposing port 3000.  
- Ensured `dotenv` is included in `package.json` and verified the database connection uses environment variables.  
- Confirmed the app runs at `localhost:3000` and successfully connects to the DB in Docker.
