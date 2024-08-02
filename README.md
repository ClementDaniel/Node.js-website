

---

# Project: Training API Application

## Overview

This project consists of a Node.js application designed to run in a Docker container. The application serves an index page that displays a secret word and includes basic functionality such as routing, environment variable handling, and CSS styling.

## Features

- **Serve Index Page:** Displays a welcome message and a button to navigate to the secret page.
- **Environment Variables:** Utilizes `dotenv` for managing sensitive configuration settings.
- **CSS Styling:** Enhances the user interface with modern CSS.
- **JavaScript Functionality:** Provides interactive elements such as buttons and dynamic content display.
- **Docker Integration:** Easily deployable in a Docker container.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (version 10 or later)
- [Docker](https://www.docker.com/get-started) (for containerization)
- [npm](https://www.npmjs.com/) (Node.js package manager)

## Installation

### Clone the Repository

```bash
git clone <repository-url>
cd <repository-directory>
```

### Install Dependencies

Install the necessary npm packages for the project:

```bash
npm install
```

This will install:

- `express`: A web framework for Node.js.
- `dotenv`: A module to load environment variables from a `.env` file.

### Setup Environment Variables

Create a `.env` file in the root directory of your project with the following content:

```
SECRET_WORD=your_secret_word_here
PORT=3000
```

Replace `your_secret_word_here` with your actual secret word.

### Application Structure

- **`index.js`**: The main entry point of the application.
- **`public/index.html`**: The HTML file served by the application.
- **`Dockerfile`**: Configuration file for building the Docker image.

### Docker Setup

To build and run the application in Docker, follow these steps:

1. **Build the Docker Image**

   ```bash
   docker build -t my-node-app .
   ```

2. **Run the Docker Container**

   ```bash
   docker run -p 8080:3000 --name my-node-app-container my-node-app
   ```

   This command maps port 3000 in the container to port 8080 on your host machine.

### Testing the Application

Once the container is running, you can test the application by navigating to:

- **Home Page:** `http://localhost:8080/`
- **Secret Page:** `http://localhost:8080/secret`

The home page should display a welcome message and a button to navigate to the secret page. The secret page will reveal the secret word set in your `.env` file.

### Notes

- **Error Handling:** If you encounter errors such as "Cannot find module," ensure all dependencies are installed correctly and the Dockerfile paths are correctly set.
- **Local Development:** For local testing, make sure to run `npm install` to install all dependencies before building the Docker image.

### Troubleshooting

- **Module Not Found:** Ensure that all dependencies listed in `package.json` are installed. Use `npm install` to resolve missing modules.
- **File Not Found in Docker:** Verify that the paths in the Dockerfile and the `.dockerignore` file are correctly set.
