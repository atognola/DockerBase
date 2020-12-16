Hi, welcome to the Falcon Docker SDK image repo.

If you're a regular user, just follow these instructions:

1. Create a folder called "data"
2. Run the "pull.sh" script, making sure to add your username and password and edit any other variables you'd like.
Upong first run, the SDK will be uncompressed and installed. The camelroot folder must be inside your data folder, and the script's "CAMELROOT" variable must be the path within that folder.
3. Whenever you want to use again the SDK, simply execute the "run.sh" script.

If you want to make any changes to the built image, to release a new one, please follow these steps:

1. Make the desired changes.
2. Update the image's version X "falcon/mowi15_179:X", and execute the "build.sh" script.
3. Update the image's version X "falcon/mowi15_179:X", and execute the "push.sh" script. Your new image release is now live!

Purpose of the files that make up an image:
1. Dockerfile: document that defines the Docker image's structure and container/host filesystem mappings.
The container will map the host computer's $path/data folder in /data. The ssh keys will be taken from the the host computer's filesystem.
The camelroot folder must be inside your data folder, and the script's "CAMELROOT" variable must be the path within that folder.
This file also defines which APT packages need to be installed.
While building the image, all commands are run as root. The entrypoint script will then downgrade to a non privileged user.
2. config.sh: script that will be bundled in the image and run upon bash login if no ssh keys or git configurations can be found. If no valid configurations are found, the script will create the keys and set up git username and email.
3. entrypoint.sh: script that will be bundled in the image and run before bash login if no user is found in the container, or if the container and host user's UID do not match. If no valid user is found, this script will create it and expand and install the SDK.
Finally, this script will login as a non root user.
4. pyN-requirements.txt: these files specify the packages to be installed by python.
5. poky-glibc-x86_64-rcar-image-minimal-aarch64-falcon-toolchain-3.1.1.sh: SDK installing script.
