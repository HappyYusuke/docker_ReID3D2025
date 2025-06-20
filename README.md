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
### ros2 bagを使ってfollow_me_by_3d_lidarを試す
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

```
rviz2
```

</br>

rviz2を起動後、「Fixed Frame」を`livox_frame`に変更してください。

<img src=fig/2.jpg width=500>

</br>

rviz2で認識できているか確認します。
1. rviz2のウィンドウ左下にある「Add」をクリックしてください。
2. 「By topic」タブに切り替え、以下の3つをそれぞれ選択し、ウィンドウ右下の「OK」をクリックしてください。

    - 「`/livox/lidar`のPointCloud2」、
    - 「`/person_label`のMarker」、
    - 「`/person_points`のPointCloud2」

<img src=fig/1.jpg width=500>

</br>

以上の手順で、認識している様子を確認できます。

</br>

### 実機を使ってfollow_me_by_3d_lidarを試す

イーサネットを設定します。
1. PCの設定を開き、「Network」を選択してください。
2. 「Wired」の「＋」をクリックしてください。
3. 「IPv4」タブを選択してください。
4. 「IPv4 Method」の「Manual」を選択してください。
5. 「Addresses」を以下のように設定してください。

    - Address：192.168.1.50
    - Netmask：255.255.255.0
    - Gateway：192.168.1.1

6. ウィンドウ右上の「Add」をクリックしてください。

画像

</br>

`livox_ros_driver2`の設定ファイルを書き換えます。

1. `./run-docker-containter.sh`でDockerを起動します。
   
3. `MID360_config.json`を開きます。
```
vim ~/docker_ReID3D2025/home/colcon_ws/src/livox_ros_driver2/config/MID360_config.json
```
2. `host_net_info`内のipを`192.168.1.50`に変更します。具体的な変更箇所は以下の通りです。

    - `"cmd_data_ip" : "192.168.1.50",`
    - `"push_msg_ip": "192.168.1.50",`
    - `"point_data_ip": "192.168.1.50",`
    - `"imu_data_ip" : "192.168.1.50",`

3. `lidar_configs`のipを以下の手順で変更します。

    - お手元のMID-360のシリアル番号末尾2桁をご確認ください（ここでは例として`15`とします）。
    - MID-360は`192.168.1.1XX/24`のいずれかに設定されます。（`192.168.1.115`となります）。
    - `ping 192.168.1.1XX`を実行し、応答があることを確認します。
    - 応答が確認できたら、`lidar_configs`のipアドレスを変更してください。

4. `./build.sh ROS2`でビルド後、`source ~/colcon_ws/install/setup.bash`を実行します。

</br>

MID-360のlaunchを実行します。

```
ros2 launch livox_ros_driver2 rviz_MID360_launch.py
```

</br>

follow_me_by_3d_lidarを実行します。

```
ros2 run follow_me_by_3d_lidar person_detector
```

</br>

rviz2で適宜認識の様子を確認してください。

</br>
