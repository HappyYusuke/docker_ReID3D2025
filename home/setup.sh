#!/bin/bash

# リポジトリのクローン
mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src
git clone https://github.com/GWxuan/ReID3D.git
git clone https://github.com/Livox-SDK/livox_ros_driver2.git
git clone https://github.com/Box-Robotics/ros2_numpy.git
git clone https://github.com/HappyYusuke/harrp.git

# 依存関係のパッケージをダウンロード
cd ~/colcon_ws
rosdep update
rosdep install -i --from-path src --rosdistro foxy -y --ignore-src

# ビルド
cd ~/colcon_ws/src/livox_ros_driver2/
./build.sh ROS2
source ~/colcon_ws/install/setup.bash
cd ~/colcon_ws
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
source ~/colcon_ws/install/setup.bash

# ホームディレクトリに戻る
cd ~/


