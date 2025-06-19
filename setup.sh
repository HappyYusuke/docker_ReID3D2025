# zipファイル解凍
unzip $HOME/large_files_docker_ReID3D2025.zip

# 移動
cp -r $HOME/large_files_docker_ReID3D2025/ReID3D $HOME/docker_ReID3D2025
cp -r $HOME/large_files_docker_ReID3D2025/ros2_bags $HOME/docker_ReID3D2025

# Docker IMAGE を取り込み
docker load < $HOME/large_files_docker_ReID3D2025/dockerimage_reid3d.tar.gz

# ターミナル出力
echo "!!! Docker IMAGE kanazawa/reid3d_ready is ready !!!"
