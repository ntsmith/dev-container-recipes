FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# --------------------------------------------------------------------
# System packages
# --------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-venv python3-dev python3-pip \
    build-essential \
    git curl wget ca-certificates \
    # Geo / GDAL stack
    gdal-bin libgdal-dev libgeos-dev libspatialindex-dev \
    # LaTeX (reasonably complete, but not texlive-full huge)
    texlive-latex-recommended texlive-latex-extra \
    texlive-fonts-recommended texlive-science \
    # For fonts and rendering
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------
# Create non-root 'ubuntu' user
# --------------------------------------------------------------------
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -m -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} ${USERNAME} \
    && apt-get update && apt-get install -y sudo \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-${USERNAME} \
    && chmod 0440 /etc/sudoers.d/99-${USERNAME} \
    && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------
# Create and configure venv
# --------------------------------------------------------------------
ENV VENV_PATH=/opt/venv
RUN python3 -m venv ${VENV_PATH}
ENV PATH="${VENV_PATH}/bin:${PATH}"

# --------------------------------------------------------------------
# Python packages (installed into venv)
# --------------------------------------------------------------------
RUN pip install --upgrade pip setuptools wheel 
RUN pip install \
    jupyterlab ipykernel \
       numpy pandas matplotlib scipy seaborn plotly sympy scikit-learn \
       # CPU-only PyTorch (official CPU index URL)
    #    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
       tensorflow \
       geopandas \
       yfinance

# NOTE: We rely on system GDAL/libs plus wheels pulled by geopandas.
# If you run into GDAL version issues, we can pin versions explicitly.

# --------------------------------------------------------------------
# Register Jupyter kernel (as non-root)
# --------------------------------------------------------------------
USER ${USERNAME}
RUN python -m ipykernel install --user \
    --name=devcontainer-venv \
    --display-name="Python (devcontainer venv)"

# Default working dir; devcontainer.json will mount the repo here
WORKDIR /workspaces

CMD ["bash"]
