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
