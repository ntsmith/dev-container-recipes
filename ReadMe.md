# Development Container Recipes
This repository contains examples of **VSCode Dev Containers** for working in different environments.
Each subdirectory corresponds to a type of environment and its subdirectories contain different dev environments.

Each specific database and provides a ready-to-use development environment with **Jupyter Notebooks** to demonstrate basic usage of the database.

### Prerequisites

To run the dev containers in this repository, you need to have the following installed:

1. **Docker** – Required to run containers.
   - [Get Docker](https://www.docker.com/products/docker-desktop)
2. **Visual Studio Code (VSCode)**
   - [Get VSCode](https://code.visualstudio.com/)
3. **Dev Containers Extension for VSCode** – Enables Dev Container functionality.
   - [Get the Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Steps to Run Each Dev Container

1. Make sure you have the "Dev Containers" extension installed in VSCode

2. Clone this repository:
   ```bash
   git clone https://github.com/ntsmith/dev-container-recipes.git
   cd dev-container-recipes
   ```
3. Open VSCode for a subdirectory containing a devcontainer. For example to use DuckDB, type

```bash
code databases/duckdb
```

4. Click **Reopen in Container**.

5. Wait for the container to build and initialize.

6. Run the Jupyter notebook to explore the demo.
