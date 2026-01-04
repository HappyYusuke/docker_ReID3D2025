# docker_ReID3D2025
本リポジトリは、3D-LiDAR（[LIVOX MID-360](https://www.livoxtech.com/jp/mid-360)）と[ReID3D](https://github.com/GWxuan/ReID3D.git)を用いて人追従を可能にしたDocker環境です。

</br>

# Installation
本リポジトリをクローンする。

```
git clone https://github.com/HappyYusuke/docker_ReID3D2025.git
```

</br>

> [!NOTE]
> Dockerがインストールされていない場合
> ```bash
> 本リポジトリに移動
> cd ~/docker_ReID3D2025
>
> # Dockerをインストール
> ./install-docker.sh
> ```

</br>

Dockerを起動する。<br>
Docker Imageのロードが始まり、起動するとプロンプトの@以降がros2になる。

```
./run-docker-containter.sh
```

</br>

`setup.sh`を実行することでセットアップが完了します。
> 以下のリポジトリがクローンされビルドされます。
> * [ReID3D](https://github.com/GWxuan/ReID3D.git)
> * [livox_ros_driver2](https://github.com/Livox-SDK/livox_ros_driver2.git)
> * [ros2_numpy](https://github.com/Box-Robotics/ros2_numpy.git)
> * [harrp](https://github.com/HappyYusuke/harrp.git)

```
./setup.sh
```

<br>

zipファイルを以下URLからダウンロードする。</br>
https://kanazawa-it.box.com/s/jsde13gu1vscmgggf073i9a3vtfh0xob

<br>

ホストPCに戻ります。<br>
ダウンロードしたzipファイルを解凍し移動する。
```
# 解凍
cd ~/Downloads
unzip large_files_docker_ReID3D2025.zip

# 重みファイルを移動
mv large_files_docker_ReID3D2025/ckpt_best.pth ~/docker_ReID3D2025/home/ReID3D/reidnet/log

# ros2_bagsを移動
mv large_files_docker_ReID3D2025/ros2_bags ~/docker_ReID3D2025/home/
```

</br>

# Usage
## ros2 bagを使って試す
Dockerを起動。

```
./run-docker-containter.sh
```

<br>

`terminator`を起動
```bash
terminator
```

`terminator`は以下の通りターミナルを分割できます。
- ctrl+shift+oで上下分割
- ctrl+shift+eで左右分割
- ctrl+shift+nや+pで画面間移動
- ctrl+shift+wで画面を一つ閉じる

</br>

HARRPを起動。

```
ros2 launch harrp rviz_reid3d_launch.py
```

</br>

ros2 bag play

```
ros2 bag play ~/ros2_bags/lidar_data_three_person
```

</br>

以上の手順で、認識している様子を確認できます。

</br>

## 実機を使ってReID3Dを試す

### イーサネットを設定します。
1. PCの設定を開き、「Network」を選択してください。
2. 「Wired」の「＋」をクリックしてください。
3. 「IPv4」タブを選択してください。
4. 「IPv4 Method」の「Manual」を選択してください。
5. 「Addresses」を以下のように設定してください。

    - Address：192.168.1.50
    - Netmask：255.255.255.0
    - Gateway：192.168.1.1

6. ウィンドウ右上の「Add」をクリックしてください。

<img src=fig/1.jpg width=500>

</br>

### `livox_ros_driver2`の設定ファイルを書き換えます。

1. `./run-docker-containter.sh`でDockerを起動します。
   
2. `MID360_config.json`を開きます。
```
vim ~/colcon_ws/src/livox_ros_driver2/config/MID360_config.json
```
3. `host_net_info`内のipを`192.168.1.50`に変更します。具体的な変更箇所は以下の通りです。

    - `"cmd_data_ip" : "192.168.1.50",`
    - `"push_msg_ip": "192.168.1.50",`
    - `"point_data_ip": "192.168.1.50",`
    - `"imu_data_ip" : "192.168.1.50",`

4. `lidar_configs`のipを以下の手順で変更します。

    - お手元のMID-360のシリアル番号末尾2桁をご確認ください（ここでは例として`15`とします）。
    - MID-360は`192.168.1.1XX/24`のいずれかに設定されます。（`192.168.1.115`となります）。
    - `ping 192.168.1.1XX`を実行し、応答があることを確認します。
    - 応答が確認できたら、`lidar_configs`のipアドレスを変更してください。

<br>

### `launch_ROS2/msg_MID360_launch.py`のパラメータを変更します。
launchファイルを開きます。
```bash
vim ~/colcon_ws/src/livox_ros_driver2/launch_ROS2/msg_MID360_launch.py
```

`xfer_format   = 1`を`xfer_format   = 0`にしてください。

<br>

6. ビルド
```bash
cd ~/colcon_ws
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
source ~/colcon_ws/install/setup.bash
```

</br>

### 起動
MID-360のlaunchを実行します。
```bash
ros2 launch livox_ros_driver2 rviz_MID360_launch.py
```

</br>

harrpを実行します。
```bash
ros2 launch harrp rviz_reid3d_launch.py
```

</br>

rviz2で適宜認識の様子を確認してください。
