# docker_ReID3D2025
本リポジトリは、3D-LiDAR（[LIVOX MID-360](https://www.livoxtech.com/jp/mid-360)）と[ReID3D](https://github.com/GWxuan/ReID3D.git)を用いて人追従を可能にしたDocker環境です。
</br>

# Installation
本リポジトリをクローンする。

```
git clone https://github.com/HappyYusuke/docker_ReID3D2025.git
```

</br>

zip形式のファイルを以下URLからホームディレクトリへダウンロードする。</br>
https://kanazawa-it.box.com/s/0aja3txig7wyjgq5p30m7gs3becye8k7

```
mv ~/Downloads/large_files_docker_ReID3D2025.zip ~/
```

</br>

setup.shを実行する。

```
cd ~/docker_ReID3D2025/
./setup.sh
```

</br>

Dockerを起動する。
Dockerを起動すると、プロンプトの@以降がros2になる。

```
./run-docker-containter.sh
```

</br>

colcon_ws/srcに、[livox_ros_driver2](https://github.com/Livox-SDK/livox_ros_driver2.git)と[ros2_numpy](https://github.com/Box-Robotics/ros2_numpy.git)をクローンしビルドする。

```
cd ~/colcon_ws/src
git clone https://github.com/Livox-SDK/livox_ros_driver2.git
git clone https://github.com/Box-Robotics/ros2_numpy.git
cd livox_ros_driver2/
./build.sh ROS2
source ~/colcon_ws/install/setup.bash
```

</br>

# Usage
## ros2 bagを使ってfollow_me_by_3d_lidarを試す
Dockerを起動。

```
./run-docker-containter.sh
```

</br>

follow_me_by_3d_lidarを起動。

```
ros2 run follow_me_by_3d_lidar person_detector
```

</br>

ros2 bag play

```
ros2 bag play ~/ros2_bags/lidar_data_three_person
```

</br>

rviz2を起動。
起動後、

```
rviz2
```

</br>

## 実機を使ってfollow_me_by_3d_lidarを試す
