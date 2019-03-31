Создание простых нод писателя и читателя

Для того чтобы описать ноду, необходимо создать пакет (talkers), в котором будут дальше храниться и читаться ноды.

ВЫПОЛНИТЬ:

	cd workspace/src
	catkin_create_pkg talkers roscpp
	cd talkers/

Последовательность команд, задающая пользовательское имя запускаемой ноде

ВЫПОЛНИТЬ:

rosrun turtlesim turtlesim_node __name:=new_node

Нода publisher

ВЫПОЛНИТЬ:

	#include <ros/ros.h> //подключение файла, в котором описаны базовые команды, функции и классы в ROS
	#include <geometry_msgs/Twist.h> //описание класса сообщения, публикующегося в топик

	int main(int argc, char **argv){
		ros::init(argc, argv, "publisher"); //инициализация простых процессов ROS
		ros::NodeHandle n; //создание объекта, который будет управлять нодой
		ros::Publisher pub = n.advertise<geometry_msgs::Twist>("turtle1/cmd_vel", 1000); //создание объекта, с помощью которого будут отправляться сообщения в топики 

		//цикл отправки сообщений
		ros::Rate loop_rate(1);
		for (int t = 0; t < 20; t++){
			geometry_msgs::Twist pos;
			pos.linear.x = 1.5;
			pos.angular.z = std::abs(2 * sin(0.5 * t));

			//вывод сообщений на экран
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

Вызов в цикле метода sleep переменной типа ros::rate, равной 20 означает, что каждая итерация цикла будет занимать не менее 1/20 секунды.

Собрать и скомпилировать написанную ноду:

ВЫПОЛНИТЬ:

	cd ..//..
	catkin_make

После компиляции можно запустить ноду:
 
ВЫПОЛНИТЬ:

	roscore
	rosrun tutrlesim turtlesim_node
	sourse devel/setup.bash 
	rosrun talkers publisher