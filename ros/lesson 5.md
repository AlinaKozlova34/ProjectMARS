����� ����������� ������������ ����

���������� ���� ���������, ������������ � ROS:

���������:

	rosmsg list

������ ���������� � �����-���� ���� ���������:

���������:

	rosmsg show visualization_msgs/MenuEntry

2 ���� ������������ ����������� ������������ ����. � ��������� ������������ 2 ����: ��������� ��������� � �����. 
������ ����-�������� - ����������� ��� ��������� � ��������� �����, � ����-�������� - ��������� ��� ��������� � �������� ���������, ���������� ������� �����, � ������� ����� ����� ���������.

���������:

	catkin_create_pkg my_message
	cd my_message


� ��������� CMakeList.txt:

���������:

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

� ��������� package.xml:

���������:

	<buildtool_depend>catkin</buildtool_depend>
	<build_depend>message_generation</build_depend>
	<run_depend>message_runtime</run_depend>

����������� ���������:

���������:

	mkdir msg
	cd msg/
	gedit Message1.msg //�������� ���������� ��������� Message1
	string text
	int32 number
	catkin_make //c������������� ������ ���������:

����������, ������������ �� ������ ��������� � ROS:

���������:

	sourse_devel/setup.bash
	rosmsg show my_message/Message1

� ������ my_message ������������� ��������� ���������� � ������ Message1.h. 
� ��������� ������� ����� ��������� 2 ����: text � number. ����� ����� ���������� ���� ��������� �����.
