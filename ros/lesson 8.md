Как писать своего клиента:

Клиент принимает с клавиатуры 2 числа и отправляет их на сервер. Т.е. вызов будет осущетсвляться не из консоли, а из ноды:

ВЫПОЛНИТЬ:

	cd  src/client_server/src/
	touch publisher.cpp
	gedit publisher.cpp

	#include "ros/ros.h"
	#include "my_service/AddInts.h"
	#include <iostream> //для работы с консолью

	int main(int argc, char **argv)
	{
		ros::init(argc, argv, "add_ints_publisher");

		ros::NodeHandle n;
		ros::ServiceClient = n.serviceClient<my_service::AddInts>("add_two_ints");
		my_service::AddInts srv;

		while (ros::ok()) {
			int a,b;
			std::cout <<"input the first integer: ";
			std::cin >> a;
			std::cout <<"input the second integer: ";
			std::cin b;

			srv.request.first = a;
			srv.request.second = b;

			if(client.call(srv)) {
				std::cout << "sum = " << srv.response.sum << std.endl;
			}
			else {
				std::cout << "Failed to call service add_two_ints" << std::endl;
				return 1;
			}
		}
		
			return 0;
	}

В редакторе CMakeLists.txt:

ВЫПОЛНИТЬ:

	add_executable(client src/publisher.cpp)

	target_link_libraries (client
		${catkin_LIBRARIES}
	)

Если необходимо компилировать пакеты (например, package1 и package2), которые используют сообщение или сервис, генерируемый в package3, причём скомпилировать package3 отдельно нет возможности, для установки корректного порядка компиляции (предотвращения компиляции пакетов package1 и package2 до пакета package3) в CMakeLists.txt первых пакетов следует после строк

ВЫПОЛНИТЬ:

	add_executable(<node_type> <source_files> )
	target_link_libraries(<node_type> ${catkin_LIBRARIES})

следует добавить строку

ВЫПОЛНИТЬ:

	add_dependencies(<node_type> 
	<name_of_package3>_generate_messages_cpp)

Эту же строку следует добавить и в CMakeLists.txt пакета package3, если он создаёт ноды, использующие сообщения и сервисы этого пакета.
