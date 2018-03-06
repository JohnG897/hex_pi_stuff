#!/bin/bash 
log_file=$PWD"/install_mavros.txt"
cd ~/
rm $log_file

function install_mavros(){
    sudo apt-get update
    sudo apt-get upgrade
    mkdir -p ~/catkin_ws/src
    cd ~/catkin_ws
    catkin init
    sudo apt-get install python-wstool python-rosinstall-generator python-catkin-tools
    wstool init ~/catkin_ws/src
    rosinstall_generator --rosdistro indigo --upstream mavros --deps | tee /tmp/mavros.rosinstall
    rosinstall_generator --rosdistro indigo mavlink --deps | tee -a /tmp/mavros.rosinstall
    wstool merge -t src /tmp/mavros.rosinstall
    wstool update -t src
    rosdep install --from-paths src --ignore-src --rosdistro `echo $ROS_DISTRO` -y
}

install_mavros | tee -a $log_file