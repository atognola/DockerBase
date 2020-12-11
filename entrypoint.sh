#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback
# Credits: https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

USER_ID=${LOCAL_USER_ID:-9001}

if getent passwd $USER_ID > /dev/null 2>&1; then
    :
else
    echo "The user with a correct ID does not exist. I'll create one now!"
    
    echo "Starting with UID : $USER_ID"
    useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
    export HOME=/home/user
    
    cp /usr/local/bin/.config.sh ${HOME}

    chmod +x ${HOME}/.config.sh && \
    echo 'bash $HOME/.config.sh' >> /home/user/.bashrc
    echo "source /opt/poky/3.1.1/environment-setup-aarch64-poky-linux" >> /home/user/.bashrc
    
    chown user:user -R ${HOME}

fi

exec gosu user "$@"
