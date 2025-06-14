FROM jupyter/datascience-notebook:latest 
 
USER root 
 
# Install prerequisites for nvm and Node.js 
RUN apt-get update && apt-get install -y curl git build-essential 
 
# Install nvm and Node.js 20 
ENV NVM_DIR=/home/jovyan/.nvm 
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \ 
    . "$NVM_DIR/nvm.sh" && \ 
    nvm install 20 && \ 
    nvm use 20 && \ 
    nvm alias default 20 && \ 
    npm install -g npm 
 
# Explicitly set the Node.js bin directory in PATH
RUN echo 'export PATH="$NVM_DIR/versions/node/v$(node -v | cut -c2-)/bin:$PATH"' >> /home/jovyan/.bashrc

# Add npm global bin to PATH
RUN echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> /home/jovyan/.bashrc

# Install pyright globally as root
RUN npm install -g pyright

# Fix permissions for jovyan user
RUN chown -R jovyan:users /home/jovyan/.npm
RUN chown -R jovyan:users $NVM_DIR
 
USER ${NB_UID} 
 
# Install JupyterLab, LSP extension, and Python language server 
RUN pip install --no-cache-dir \ 
    jupyterlab \ 
    jupyterlab-lsp \ 
    python-lsp-server[all] \
    jupyter-collaboration


# Make sure pip bin directory is in PATH
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/jovyan/.bashrc
 
# Enable JupyterLab LSP extension explicitly 
RUN jupyter labextension install @jupyter-lsp/jupyterlab-lsp
