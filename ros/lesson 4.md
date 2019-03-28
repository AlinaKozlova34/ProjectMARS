Создать ноду, которая будет подписана на топик

ВЫПОЛНИТЬ:

	#include <ros/ros.h>
	#include <geometry_msgs/Twist.h>

	//функция обработки сообщения
	void recieve(const geometry_msgs::Twist &movement)
	{
	//выдать информацию о полученном сообщении
  		ROS_INFO("Got:\n"
           	"1) pos.linear:  x = %f, y = %f, z = %f\n"
           	"2) pos.angular: x = %f, y = %f, z = %f\n",
           	movement.linear.x, movement.linear.y, movement.linear.z,
           	movement.angular.x, movement.angular.y, movement.angular.z);
  	return;
	}

	int main(int argc, char **argv)
	{
  		ros::init(argc, argv, "listener"); //имя ноды по умолчанию
  		ros::NodeHandle n;
  		ros::Subscriber sub = n.subscribe("/turtle1/cmd_vel", 1000, recieve);
  		ros::spin(); 
  		return 0;
	}

Команда ros::spinOnce() вызывает все ожидающие запуска callbak-и.

Если сообщения публикуются в топик в бесконечном цикле, перед которым установлен ros::Rate r(10), а в конце которого находится r.sleep(), то такую систему нельзя считать системой реального времени, так как на одну итерацию цикла может уйти больше, чем 0,1 с.