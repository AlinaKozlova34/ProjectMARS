Понятие и создание собственного сервиса

Сервис отличается от обычного сообщения тем, что при отправке нодой сообщения, она не ждет никакого отклика, что сообщение кем-либо принято. У сервиса же связь с нодой "один к одному", т.е. он присылается какой-либо одной конкретной ноде, при этом нода-publisher ожидает от ноды-сервера отклик, который описан в функции, обрабатывающей этот сервис. 

Задать ноду-сервер. Серверс состоит из двух частей: запрос - ответ. Часть запроса будет состоять из двух целочисленных переменных, часть ответа - из одной целочисленной переменной. 
"Клиент" будет отправлять два числа серверу, сервер будет их складывать и отправлять ответ "клиенту".

ВЫПОЛНИТЬ:

	cd workspace/src/
	catkin_create_pkg my_service message_generation message_runtime
	cd my_service/ 

Создать файл сервиса:

ВЫПОЛНИТЬ:

	mkdir srv
	cd srv/
	touch AddInts.srv
	getit AddInts.srv

В редакторе AddInts.srv:

ВЫПОЛНИТЬ:

	int32 first
	int32 second
	--- //отделение области запроса от области ответа	
	int32 sum

В редакторе CMakeLists.txt

ВЫПОЛНИТЬ:

	cmake_minimum_required(VERSION 2.8.3)
	project(my_service)

	find_package(catkin REQUIRED COMPONENTS
		message_generation
		message_runtime
		std_msgs
	)
	
	add_service_files(
		FILES
		AddInts.srv
	)

	generate_messages(
		DEPENDENCIES
		std_msgs
	)

	catkin_package(
	)

	include_directories(
		${catkin_INCLUDE_DIRS}
	)

Сборка сервиса:

ВЫПОЛНИТЬ:

	cd../..
	catkin_make

	//проверить, находит ли данный сервис
	source devel/setup.bash
	rossrv show my_service/AddInts

	cd/devel/include/my_service/ 

Отличие команд rossrv и rosservice:

rossrv работает  с типами сервисов и покажет все сервисы, существующие в ros
rosservice покажет те сервисы, которые доступны в момент компиляции ros

Создать собственный сервис:

ВЫПОЛНИТЬ:

	cd ~/workspace/src/
	catkin_create_pkg client_server roscpp my_service
	cd client_server/
	cd src/
	ls
	touch subcriber.cpp
	gedit subcriber.cpp

В редакторе subcriber.cpp:

ВЫПОЛНИТЬ:

	#include "ros/ros.h"
	#include "my_service/AddInts.h"

	bool add(service::AddInts::Request &req,
		service::AddInts::Response &res)
	{
		res.sum = req.first + req.second;
		ROS_INFO("request: x=%d, y=%d". req.first, req.second);
		ROS_INFO("sending back response: [%d]", res.sum);
		return true;
	}

	int main(int argc, char **argv)
	{
		ros::init(argc, argv, "add_two_ints_server");
		ros::NodeHandle n;

		ros::ServiceServer service = n.advertiseService("add_two_ints", add);
		ROS_INFO("Ready to add two ints.");
		ros::spin();

		return 0;
	}

Для пакета, если предполагается, что ноды этого пакета будут осуществлять какие-то сервисные вызовы, необходимо указать зависимости:
message_generation и message_runtime, только если в рамках этого же пакета создаётся сообщение типа сервис и имя пакета, в котором создано сообщение типа сервис.


В редакторе CmakeLists.txt:

ВЫПОЛНИТЬ:

add_executable(server src/subscriber.cpp)

target_link_libraries(server
	${catkin_LIBRARIES}
)

Сборка и запуск сервера:

ВЫПОЛНИТЬ:

cd ~/workspace/
catkin_make

roscore
source devel/setup.bash
rosrun client_server server

//в отдельной консоли
source devel/setup.bash
rosservice call /add_two_ints //ввод двух чисел и возвращение их суммы


