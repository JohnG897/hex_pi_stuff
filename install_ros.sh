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
sudo sh -c 'echo "deb-src http://mirrordirector.raspbian.org/raspbian/ testing main contrib non-free rpi" >> /etc/apt/sources.list'
sudo apt-get update
#libconsole-bridge-dev
cd ~/ros_catkin_ws/external_src
sudo apt-get build-dep console-bridge
apt-get source -b console-bridge
sudo dpkg -i libconsole-bridge0.2*.deb libconsole-bridge-dev_*.deb
#liblz4-dev. This one takes AGES
cd ~/ros_catkin_ws/external_src
apt-get source -b lz4 #this bit here takes a ridiculous amount of time
sudo dpkg -i liblz4-*.deb
#liburdfdom-headers-dev: 
cd ~/ros_catkin_ws/external_src
git clone https://github.com/ros/urdfdom_headers.git
cd urdfdom_headers
git reset --hard 76da8dc
cmake
#Note this next bit that gets printed to the terminal .
echo IMPORTANT
echo When checkinstall (the next command) gives you the opportunity to 'rename the package'
echo rename it as liburdfdom-headers-dev
sudo checkinstall make install
#liburdfdom-dev
cd ~/ros_catkin_ws/external_src
sudo apt-get install libboost-test-dev libtinyxml-dev
#You can ignore the tutorial here and just install it normally
sudo apt-get install liburdfdom-dev
#libassimp-dev (assimp)
cd ~/ros_catkin_ws/external_src
wget https://github.com/assimp/assimp/archive/v3.3.1.zip
unzip v3.3.1.zip
rm v3.3.1.zip
cd ~/ros_catkin_ws/external_src/assimp-3.3.1
cmake . -DCMAKE_BUILD_TYPE=Release -DASSIMP_BUILD_TESTS=False
#This again
echo IMPORTANT SAME AS BEFORE
echo When checkinstall (the next command) gives you the opportunity to 'rename the package'
echo rename it as libassimp-dev
sudo checkinstall make install
#collada-dom-dev
cd ~/ros_catkin_ws/external_src
sudo apt-get install libboost-filesystem-dev libxml2-dev
wget http://downloads.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.4/collada-dom-2.4.0.tgz
#Note that sourceforge is currently down so this last command hasn't worked
#Navigate to /ros_catkin_ws/external_src and try again