# DevContainer Demos
This repository contains examples of **VSCode DevContainers** for working in different environments.
Each subdirectory corresponds to a type of environment and its subdirectories contain different dev environments.

Each specific database and provides a ready-to-use development environment with **Jupyter Notebooks** to demonstrate basic usage of the database.

### Prerequisites

To run the devcontainers in this repository, you need to have the following installed:

1. **Docker** – Required to run containers.
   - [Get Docker](https://www.docker.com/products/docker-desktop)
2. **Visual Studio Code (VSCode)** – Our IDE of choice.
   - [Get VSCode](https://code.visualstudio.com/)
3. **Dev Containers Extension for VSCode** – Enables DevContainer functionality.
   - [Get the Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Steps to Run Each DevContainer

1. Clone this repository:
   ```bash
   git clone https://github.com/ntsmith/devcontainer-demos.git
   cd database-devcontainers
   ```
2. Open VSCode for a devcontainer. For example to use DuckDB, type

```bash
code database/duckdb
```

3. Click **Reopen in Container**.

4. Wait for the container to build and initialize.

5. Run the Jupyter notebook to explore the demo.
