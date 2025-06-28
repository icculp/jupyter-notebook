FROM quay.io/jupyter/datascience-notebook:2025-06-02
 
USER root 
 
# Install prerequisites for nvm and Node.js 
RUN apt-get update && apt-get install -y curl git build-essential 
 
RUN mamba install -y -c conda-forge \
    conda-store-server \
    nodejs=20 \
    pyright \
    nb_conda_kernels \
    jupyterlab-lsp \ 
    jupyter-collaboration \
 && mamba clean -afy

USER ${NB_UID}
 
# Install JupyterLab, LSP extension, and Python language server 
RUN pip install --no-cache-dir \ 
    python-lsp-server[all] \
    jupyterlab-conda-store \
    && pip cache purge


# Make sure pip bin directory is in PATH
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/jovyan/.bashrc
RUN echo "create_default_packages:" > /opt/conda/.condarc && \
    echo "  - ipykernel" >> /opt/conda/.condarc && \
    echo "channels:" >> /opt/conda/.condarc && \
    echo "  - defaults" >> /opt/conda/.condarc


