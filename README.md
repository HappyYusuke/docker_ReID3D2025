# docker-ros2
ROS2(Foxy)をDockerで動かす。  
GUIも使える。

## 実行環境
Dockerがインストールされた任意のバージョンのUbuntuやWSL(Windows)。

## 内部仕様
- Ubuntu20.04
- ROS foxy desktop full

## 開発方法
1. (Docker入っていないなら)```./install-docker.sh```
1. Dockerfileに開発に必要なパッケージを追加
1. home/colcon_ws/srcに開発したパッケージを設置
1. run-docker-container.shに使うセンサを接続するよう記述
1. ```./build-docker-image.sh```を実行。
1. ```./run-docker-container.sh```を実行。プロンプトの@以降がros2になる。
1. ```terminator```でコンテナ内部のターミナルを起動。
1. 動かす
1. 終わったら./stop-docker-container.sh。必須ではない。

## terminatorの使い方
- ctrl+shift+oで上下分割
- ctrl+shift+eで左右分割
- ctrl+shift+nや+pで画面間移動
- ctrl+shift+wで画面を一つ閉じる

## その他
コンテナに入った状態のターミナルを複数用意するには、terminatorで画面分割する他にも、別のターミナル開いてまた./run-docker-container.shを実行するという方法もある。
# docker_ReID3D2025
# docker_ReID3D2025
