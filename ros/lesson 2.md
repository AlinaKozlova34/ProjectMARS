������� ������, �������� ����� � �������� �������, ����������

� ROS ���������� ����������, �������� �������� ���������� ����������� ���� ������ � /workspace/src/paket1. ����� ����, ��� ���� �� ���� ����� �������������, ����� � ������ src ������������� ����� ������������� ����� build � devel.

������� �����:

���������:
mkdir -p workspace/src catkin_init_workspace
catkin_create_pkg paket1

��� �������� ������, �������� �����������, ���������� ��� �������� ������ ����� catkin_create_pkg ����� ������ ������� �����������, � ����� ������� �� � CMakeLists.txt � package.xml

������� �������� ������:

���������:
kate CMakelists.txt

� ���������:

������� ����������� �����: find_package (catkin REQUIRED paket1)
�������� ����������� ����� ���������: 

���������:

add_message_files(
	FILES
	Message1.msg
	Message2.msg

����� �� ������������ �����������:

���������:

generate messages(
	DEPENDENCIES
	std msgs

���������:

catkin_package(
	INCLUDE_DIRS - ������ ������������ �����
	LIBRARIES paket1 - ������������ ����������
	CATKIN_DEPENDS other_catkin_pkg - ������������ �����������

������������ ���������� ��������� ��� ����������:

���������:
add_library(${PROJECT_NAME}
	src/${PROJECT_NAME}/paket1.cpp

������� ��� ����, ������� ����� ����������� �� ������� rosrun:

���������:
add_executable(${PROJECT_NAME}_node src/node1.cpp

������� ����������, ������� ���������� ���������� � ������������ �����

���������:
target_link_libraries(${PROJECT_NAME}_node
	${catkin_LIBRARIES}

����� �������, ��������� ���� ����� ���� ������� � ���������� ����������� ������.

������� ���� package.xml:

���������:
kate package.xml

���� ���� �������� � ���� ��� ������, ��� ������ � ��������. 

�������� �������� � ������������: <maintainer email=12dvfg@mail.ru>root</maintainer>
�������� �������� � ��������: <license>TODO</license> 

����������� ������� ��� ����������, ���� ����� ����� ����������� (� ����������� �� �� ����):
<build_depend>message_generation</build_depend>
<buildtool_depend>catkin</buildtool_depend> - ����������� �� ���������
<run_depend>message_runtimr</run_depend>
<test_depend>gtest</test_depend>

��� ������ ������� ������ catkin_make �������������� �� �������� ����� ������� �������. �������� �� ��, ��� ����� ��� ����, ��� ��� ����� ��������������:

���������:
cd ../../..
cd workspace
catkin_make

������� � �������� ���������� ����� � workspace-��. ����� ������� ���� ������������� � ������� catkin_make �����.

���������:

	mkdir -p workspace/src
	cd workspace/src
	catkin_init_workspace
	catkin_create_pkg numberone