![](images/uas_output.png)

# Running UAS Sim in Docker Container on Windows

The purpose of article is to show the steps I took to get the gym-pybullet-drones environment to run on Windows using Docker. The environment is not officially supported although the repository README as tips for running on Windows, this can be alternate way to get it running with a lot of the headaches.  

The gym-pybullet-drones is a great environment for testing out Reinforcement Learning algorithms on drones.

Running the environment in a workspace has the benefit of creating a workspace for that is portable to all platforms.  

First thing first, Install Docker and configure it to use WSL 2 as a backend.  See [Docker website](https://docs.docker.com/desktop/windows/install/) for instructions.

Clone this [github](https://github.com/jepierre/uas-docker-env.git) repository and the gym-pybullet-drone submodule.

```
git clone https://github.com/jepierre/uas-docker-env.git --recurse-submodules
```

Next we create a docker file that contains all the steps needed to create our docker container.

To build the container open a PowerShell Window and Run:

```PowerShell
docker build -t uas_docker_env:1.0 -f "uas_docker_env.dockerfile" .
```

To run the container, from the same PowerShell Window run:  

```PowerShell
docker run --rm -it uas_docker_env:1.0
```

To bypass the the default app, run the command: 

```PowerShell
docker run --rm -it -e DISPLAY=$DISPLAY --entrypoint /bin/bash uas_docker_env:1.0 
```

## References  
1. Panerati, J., Zheng, H., Zhou, S., Xu, J., Prorok, A., & Schoellig, A. P. (2021). Learning to Fly---a Gym Environment with PyBullet Physics for Reinforcement Learning of Multi-agent Quadcopter Control. 2021 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS), 1(1), 1–8. https://doi.org/10.0000/00000
1. https://stackoverflow.com/questions/41485217/mount-current-directory-as-a-volume-in-docker-on-windows-10
2. https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110
3. https://towardsdatascience.com/how-to-render-openai-gym-on-windows-65767ab52ae2
4. https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user
5. https://medium.com/@gno320/running-uas-sim-in-docker-container-e270eb9b382b
