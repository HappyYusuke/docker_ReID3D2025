import rclpy
from rclpy.node import Node
from sensor_msgs.msg import PointCloud2



class LaserDataLoader(Node):
    def __init__(self):
        super().__init__('laser_data_loader')
        self.create_subscription(PointCloud2, '/livox/lidar', self.callback, 10)

    def callback(self, msg):
        print(msg.data)



def main():
    rclpy.init()
    node = LaserDataLoader()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()
