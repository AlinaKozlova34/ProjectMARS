������� � �������� ������������ �������

������ ���������� �� �������� ��������� ���, ��� ��� �������� ����� ���������, ��� �� ���� �������� �������, ��� ��������� ���-���� �������. � ������� �� ����� � ����� "���� � ������", �.�. �� ����������� �����-���� ����� ���������� ����, ��� ���� ����-publisher ������� �� ����-������� ������, ������� ������ � �������, �������������� ���� ������. 

������ ����-������. ������� ������� �� ���� ������: ������ - �����. ����� ������� ����� �������� �� ���� ������������� ����������, ����� ������ - �� ����� ������������� ����������. 
"������" ����� ���������� ��� ����� �������, ������ ����� �� ���������� � ���������� ����� "�������".

���������:

	cd workspace/src/
	catkin_create_pkg my_service message_generation message_runtime
	cd my_service/ 

������� ���� �������:

���������:

	mkdir srv
	cd srv/
	touch AddInts.srv
	getit AddInts.srv

� ��������� AddInts.srv:

���������:

	int32 first
	int32 second
	--- //��������� ������� ������� �� ������� ������	
	int32 sum

� ��������� CMakeLists.txt

���������:

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

������ �������:

���������:

	cd../..
	catkin_make

	//���������, ������� �� ������ ������
	source devel/setup.bash
	rossrv show my_service/AddInts

	cd/devel/include/my_service/ 
