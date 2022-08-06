FROM ghcr.io/armmbed/mbed-os-env:mbed-os-6-latest

# micro-ros and mbed build tools
RUN pip install -U \
	six \
	catkin_pkg \
	lark-parser \
	empy \
	colcon-common-extensions \
	prettytable \
	future \
	jinja2 \
	intelhex

# install some text editors
RUN apt-get update && apt-get install -y --no-install-recommends \
	vim \
	nano \
	gedit \
	&& rm -rf /var/lib/apt/lists/*

# miscellaneous installs
RUN apt-get update && apt-get install -y --no-install-recommends \
	neofetch \
	&& rm -rf /var/lib/apt/lists/*

# make new terminal pretty
RUN printf "neofetch\n" >> ~/.bashrc

# print welcome message
RUN printf "printf \"Entered embedded container: Use <mbed-tools -h> to see available commands.\n\n\"\n" >> ~/.bashrc

# print device connected message
RUN printf "mbed-tools detect\n" >> ~/.bashrc

WORKDIR /root/workspaces
