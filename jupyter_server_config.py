c = get_config()

c.ServerApp.allow_origin = '*'
c.ServerApp.allow_remote_access = True
c.ServerApp.ip = '0.0.0.0'

# Kernel settings
c.MappingKernelManager.cull_idle_timeout = 3600
c.MappingKernelManager.cull_interval = 300

# File size limits
#c.ServerApp.max_body_size = 100 * 1024 * 1024  # 100MB

# Extension settings
c.ServerApp.jpserver_extensions = {
    'jupyterlab': True,
    'notebook': True,
    'jupyter_server_proxy': True,
    'nb_conda_kernels': True,
}

# Conda kernels
c.CondaKernelSpecManager.name_format = '{environment}'
c.CondaKernelSpecManager.env_filter = None

c.ServerApp.max_body_size   = 1024**3   # 1 GiB
c.ServerApp.max_buffer_size = 1024**3


