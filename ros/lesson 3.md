�������� ������� ��� �������� � ��������

��� ���� ����� ������� ����, ���������� ������� ����� (talkers), � ������� ����� ������ ��������� � �������� ����.

���������:

	cd workspace/src
	catkin_create_pkg talkers roscpp
	cd talkers/

������������������ ������, �������� ���������������� ��� ����������� ����

���������:

rosrun turtlesim turtlesim_node __name:=new_node

���� publisher

���������:

	#include <ros/ros.h> //����������� �����, � ������� ������� ������� �������, ������� � ������ � ROS
	#include <geometry_msgs/Twist.h> //�������� ������ ���������, �������������� � �����

	int main(int argc, char **argv){
		ros::init(argc, argv, "publisher"); //������������� ������� ��������� ROS
		ros::NodeHandle n; //�������� �������, ������� ����� ��������� �����
		ros::Publisher pub = n.advertise<geometry_msgs::Twist>("turtle1/cmd_vel", 1000); //�������� �������, � ������� �������� ����� ������������ ��������� � ������ 

		//���� �������� ���������
		ros::Rate loop_rate(1);
		for (int t = 0; t < 20; t++){
			geometry_msgs::Twist pos;
			pos.linear.x = 1.5;
			pos.angular.z = std::abs(2 * sin(0.5 * t));

			//����� ��������� �� �����
			ROS_INFO("Move to position:\n"
							 "1) pos. linear:  x = %f y = %f z = %f\n"
							 "2) pos. angular: x = %f y = %f z = %f\n",
							 pos.linear.x, pos.linear.y, pos.linear.z,
							 pos.angular.x, pos.angular.y, pos.angular.z);
			pub.publish(pos);
			loop_rate.sleep();
		}
		ros::spinOnce();
		return 0;
	}

����� � ����� ������ sleep ���������� ���� ros::rate, ������ 20 ��������, ��� ������ �������� ����� ����� �������� �� ����� 1/20 �������.

������� � �������������� ���������� ����:

���������:

	cd ..//..
	catkin_make

����� ���������� ����� ��������� ����:
 
���������:

	roscore
	rosrun tutrlesim turtlesim_node
	sourse devel/setup.bash 
	rosrun talkers publisher