# Running gym-pybullet-drones Environment using Docker on Windows

The purpose of article is to show the steps I took to get the gym-pybullet-drones environnement to run on Windows using Docker. The environment is not officially supported and although the repository README as tips for running on Windows, this can be alternate way to get it running with a lot of the headaches.  

The gym-pybullet-drones is a great environment for testing out Reinforcement Learning algorithms on drones.

Running the environment as the benefit of creating a workspace for that is portable to all platforms. 

First thing first, Install Docker and configure it to use WSL 2 as a backend.  See [Docker website](https://docs.docker.com/desktop/windows/install/) for instructions.

clone this repository and the gym-pybullet-drone submodule
```
git clone https://github.com/jepierre/uas-docker-env.git --recurse-submodules
```

Next we create a docker file that contains all the steps needed to create our docker container.

 RUN instruction Dockerfile for Docker Quick Start

To build the container open a PowerShell Window and Run:
```
docker build -t uas_docker_env:1.0 -f "uas_docker_env.dockerfile" .
```

To run the container, from the same PowerShell Window run: 
```
docker run --rm -it uas_docker_env:1.0
```

# References



docker run -ti --rm -e DISPLAY=$DISPLAY  -v ${PWD}:/workspace ...



https://dev.to/darksmile92/run-gui-app-in-linux-docker-container-on-windows-host-4kde

Set-Variable -name DISPLAY -value ....
sudo apt install x11-apps
xeyes

mount a volume
https://stackoverflow.com/questions/41485217/mount-current-directory-as-a-volume-in-docker-on-windows-10

https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110

https://towardsdatascience.com/how-to-render-openai-gym-on-windows-65767ab52ae2

# to get docker and wsl to show up 
need to install freeglut3-dev

export LIBGL_ALWAYS_INDIRECT=0

install xlaunch: 
multiple windows
start no client
unselect Native opengl
select disable access control



# https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile-18-04/

# tensorflow cpu docker [https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/cpu.Dockerfile]

#setting user as non-root: 
#https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user