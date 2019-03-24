//В рамках пакета package был создан файл сообщения mes.msg, имеющий вид:

ВЫПОЛНИТЬ:

	float64 f
	int64 i 
	int32[] array

Указать (с полным указанием последовательности namespace-ов) тип переменной f, который она приобретет после автогенерации сообщения (по максимуму расшифровав все typedef-ы ROS, которые могут встретиться).

ВЫПОЛНИТЬ:

	::package::mes_<std::allocator<void> >::double

В структуру с++ файл message.msg:

ВЫПОЛНИТЬ:

	char c
	int[] a

будет преобразован с полями uint8_t c; vector <int> a;

Разберем структуру пакета (agents) с нодами, которые будут обмениваться сообщениями.

В редакторе CMakeList.txt:

ВЫПОЛНИТЬ:

	cmake_minimum_required(VERSION 2.8.3)
	project(agents)

	find_package(catkin REQUIRED COMPONENTS
		roscpp
		my_message
	)

	catkin_package()

	include_directories(include ${catkin_INCLUDE_DIRS})
	add_executable(reader src/reader.cpp)
	add_executable(writer src/writer.cpp)
	target_link_libraries(reader ${catkin_LIBRARIES})
	target_link_libraries(writer ${catkin_LIBRARIES})

В редакторе package.xml:

ВЫПОЛНИТЬ:

	<?xml version="1.0"?>
	<package>
		<name>agents</name>
		<version>1.0.0</version>
		<description>description</description>
		<maintainer email="qwerty@mail.ru>stepic</maintainer>
		<license>TODO</license>

		<buildtool_depend>catkin</buildtool_depend>
		<build_depend>roscpp</build_depend>
		<build_depend>my_message</build_depend>
		<run_depend>roscpp</run_depend>
		<run_depend>my_message</run_depend>

	</package>

Нода writer.cpp:

ВЫПОЛНИТЬ:

	#include<ros/ros.h>
	#include<my_message/Message1.h>
	#include<stdlib.h>
	#include<stdio.h>
	#include<sstream>

	typedef std::pair< std::string, int > TextNum;

	int main (int argc, char **argv) {

		ros::init(argc, argv, "writer");

		ROS_INFO_STREAM("Writer is ready.\n");

		ros::NodeHandle n;
		ros::Publisher pub = n.advertise<my_message::Message1>("Name", 10);

		std::vector< TextNum > messageList; //задается вектор сообщений
		messageList.push_back(TextNum("Hello", 11));
		messageList.push_back(TextNum("World", 12));
		messageList.push_back(TextNum("This", 17));
		messageList.push_back(TextNum("Is", 14));
		messageList.push_back(TextNum("Test", 15));
		messageList.push_back(TextNum("Stop", -1)); //значение -1 обозначает завершение
		sleep(1);

		ros::Rate loop_rate(1); //интерация цикла совершается за 1 секунду
		for (int i = 0; i < messageList.size(); i++) {
			my_message::Message1 message;
			message.text = messageList[i].first
			message.number = messageList[i].second
			pub.publish(message); //публикация сообщения message
		
			ROS_INFO("%s, %d", messageList[i].first.c_str(), messageList[i].second);
			ros::spinOnce();
				loop_rate.sleep();
			}
		
			ROS_INFO_STREAM("Publishing is finished. \n");
			return 0
	}