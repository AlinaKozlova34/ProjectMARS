Обмен сообщениями собственного типа

Посмотреть типы сообщений, существующих в ROS:

ВЫПОЛНИТЬ:

	rosmsg list

Узнать информацию о каком-либо типе сообщения:

ВЫПОЛНИТЬ:

	rosmsg show visualization_msgs/MenuEntry

2 ноды обмениваются сообщениями собственного типа. В сообщении присутствует 2 поля: текстовое сообщение и число. 
Задача ноды-писателя - публиковать эти сообщения в некоторый топик, а ноды-читателя - считывать эти сообщения и выделить сообщение, содержащее большее число, и вывести текст этого сообщения.

ВЫПОЛНИТЬ:

	catkin_create_pkg my_message
	cd my_message


В редакторе CMakeList.txt:

ВЫПОЛНИТЬ:

	find_package(catkin REQUIRED COMPONENTS
		std_msgs
		message_generation)
	add_message_files(
		FILES
		Message1.msg
	)
	generate_messages(
		DEPENDENCIES
		std_msgs
	)
	catkin_package(
		CATKIN_DEPENDS message_runtime
	)

В редакторе package.xml:

ВЫПОЛНИТЬ:

	<buildtool_depend>catkin</buildtool_depend>
	<build_depend>message_generation</build_depend>
	<run_depend>message_runtime</run_depend>

Продолжение программы:

ВЫПОЛНИТЬ:

	mkdir msg
	cd msg/
	gedit Message1.msg //изменить содержание сообщения Message1
	string text
	int32 number
	catkin_make //cкомпилировать данное сообщение:

Посмотреть, отображается ли данное сообщение в ROS:

ВЫПОЛНИТЬ:

	sourse_devel/setup.bash
	rosmsg show my_message/Message1

В пакете my_message автоматически создалась директория с файлом Message1.h. 
В структуре данного файла создались 2 поля: text и number. Также здесь определены типы указанных полей.
