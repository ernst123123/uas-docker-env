![](images/uas_output.png)

# Running UAS Sim in Docker Container on Windows

updated launch command:

xhost local:root
sudo docker run -it \
--env="DISPLAY=$DISPLAY" \
--env=NVIDIA_DRIVER_CAPABILITIES=all  \
--env=NVIDIA-VISIBLE_DEVICES=all \
--env="QT_X11_NO_MITSHM=1" \
--network="host" \
--privileged \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--gpus all  \
--entrypoint /bin/bash uas_docker_env:1.0 

