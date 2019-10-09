# Choose the base image
FROM ${NAME}-${ID}-base

# Create the user
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && mkdir -p /home/${USERNAME}/.vscode-server /home/${USERNAME}/.vscode-server-insiders \
    && chown ${USER_UID}:${USER_GID} /home/${USERNAME}/.vscode-server* \
    # [Optional] Add sudo support
    && apt-get update && apt-get install -y sudo acl \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Set the default user
USER ${USERNAME}