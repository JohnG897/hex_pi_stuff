#!/bin/bash 
log_file=$PWD"/install_mavros.txt"
cd ~/
rm $log_file
sudo apt-get update | tee -a $log_file
sudo apt-get upgrade | tee -a $log_file
mkdir -p ~/catkin_ws/src | tee -a $log_file
cd ~/catkin_ws | tee -a $log_file
catkin init | tee -a $log_file
sudo apt-get install python-wstool python-rosinstall-generator python-catkin-tools | tee -a $log_file
wstool init ~/catkin_ws/src | tee -a $log_file
rosinstall_generator --rosdistro indigo --upstream mavros --deps | tee /tmp/mavros.rosinstall | tee -a $log_file
rosinstall_generator --rosdistro indigo mavlink --deps | tee -a /tmp/mavros.rosinstall | tee -a $log_file
wstool merge -t src /tmp/mavros.rosinstall | tee -a $log_file
wstool update -t src | tee -a $log_file
rosdep install --from-paths src --ignore-src --rosdistro `echo $ROS_DISTRO` -y | tee -a $log_file
