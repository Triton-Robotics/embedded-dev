# Embedded-Dev: Containerized

Created for and primarily used by Triton Robotics, a UCSD competitive robotics team.

- [Embedded-Dev: Containerized](#Embedded-Dev: Containerized)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Projects](#projects)
  - [Package Installation](#package-installation)
  - [Issues](#issues)

### Features

* Fully modularized: Can be installed onto any system with the appropriate prerequisites
* Includes all dependencies required for development using the [mbed](https://os.mbed.com/) framework
* Automated, one line installation, powered by Docker
* Ease of accessibility, powered by a custom Makefile

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
   1. Install Docker using above link
   2. Ensure Docker is enabled to run on startup and added to the `docker` group. Restart your computer after running these commands:

      ```bash
      sudo systemctl enable docker.service
      sudo systemctl enable containerd.service
      sudo usermod -aG docker $USER
      ```
2. Make, which can be installed using `sudo apt install build-essential` on most Debian based systems.
3. Basic knowledge of container based applications, which you can read about [here](https://docker-curriculum.com/).

### Setup

1. Clone this repo.

```sh
git clone https://github.com/Triton-Robotics/embedded-dev.git
```

2. `cd` into the newly created folder. Run `make`.

### Usage

`cd` inside the `embedded-dev` folder (Where the Makefile and Dockerfile files are located). The Makefile provides a set of commands available for ease of accessibility.

* `make`: Enters the container, allowing you to run mbed commands.
  * If mbed has not been downloaded, installation is automatically started
  * Automatically creates container if a container has not yet been created
  * Creates a new bash terminal which is running inside the container.
* `make clean`: Stops currently running container.
* `make status`: Indicates whether the container is running or not.

Additional commands can be seen by running `make help`.

### Projects

* All source code and mbed projects should be stored inside the `projects` folder.
  * This folder is synced across your host system and the container.
  * This allows you to edit your code using your host OS and preferred IDE, and prevents code from being deleted when the container stops running.
* See [this tutorial](https://docs.ros.org/en/foxy/Tutorials/Workspace/Creating-A-Workspace.html) for more information on workspace management.

### Package Installation

Since container based systems do not remember installations after the container stops running, it is necessary to add additional installations to the Dockerfile itself.

* Additional packages can be added to the Dockerfile by adding the package to the user specific packages section.

  ```bash
  # user specific packages
  RUN apt-get update && apt-get install -y --no-install-recommends \
      # package-name-here \
      && rm -rf /var/lib/apt/lists/*
  ```
* After updating the Dockerfile, run `make dockerfile` to install added packages and regenerate the container image.
* Restart the container by running `make clean`, then `make`.

### Issues

Issues can be reported using the corresponding GitHub tab, or by contacting the developer using Discord at `Waycey#9999`

Known issues:

* Serial output may not be printed when using the `--sterm` argument for compiles. The cause for this issue has not yet been found, but can be solved by restarting this container using `make clean`, then re-`make` the container.

Tested on: Ubuntu 18.04, Ubuntu 21.04, Fedora 35, and Arch Linux
