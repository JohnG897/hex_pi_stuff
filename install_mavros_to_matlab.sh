#!/bin/bash
echo The thing is starting
cd ~/
#This is just this tutorial http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Indigo%20on%20Raspberry%20Pi with a few
#fixes put in that may or may not work. Note that this will only work for raspbian jessie and NOT stretch
#
#
#

#Setup ROS repositories
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu jessie main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
#this thing
sudo apt-get update
sudo apt-get upgrade
#install bootstrap dependencies
sudo apt-get install python-pip python-setuptools python-yaml python-distribute python-docutils python-dateutil python-six
sudo pip install rosdep rosinstall_generator wstool rosinstall
#initialise rosdep
sudo rosdep init
rosdep update
#create a catkin workspace
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws
#build roscomm
rosinstall_generator ros_comm --rosdistro indigo --deps --wet-only --exclude roslisp --tar > indigo-ros_comm-wet.rosinstall
wstool init src indigo-ros_comm-wet.rosinstall
#The rest of this is just resolving dependencies
mkdir ~/ros_catkin_ws/external_src
sudo apt-get install checkinstall cmake