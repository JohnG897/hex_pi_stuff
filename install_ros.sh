#!/bin/bash
echo The thing is starting
cd ~/
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip python-setuptools python-yaml python-distribute python-docutil python-dateutil python-six
sudo pip install rosdep rosinstall_generator wstool rosinstall
sudo rosdep init
rosdep update
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws

rosinstall_generator ros_comm --rosdistro indigo --deps --wet-only --exclude roslisp --tar > indigo-ros_comm-wet.rosinstall
wstool init src indigo-ros_comm-wet.rosinstall

cd ~/ros_catkin_ws/external_src
sudo apt-get install libboost-filesystem-dev libxml2-dev
wget http://downloads.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.4/collada-dom-2.4.0.tgz
tar -xzf collada-dom-2.4.0.tgz
cd collada-dom-2.4.0
sudo checkinstall make install

cd ~/ros_catkin_ws
rosdep install --from-paths src --ignore-src --rosdistro indigo -y -r --os=debian:jessie
source /opt/ros/indigo/setup.bash


sudo apt-get install ros-indigo-mavros ros-indigo-mavros-extras
cd hex_pi_stuff
echo The thing has finished