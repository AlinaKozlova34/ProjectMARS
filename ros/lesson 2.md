Понятие пакета, иерархия папок в файловой системе, компиляция

В ROS существует соглашение, согласно которому необходимо располагать свои пакеты в /workspace/src/paket1. После того, как хотя бы один пакет скомпилирован, рядом с папкой src автоматически будут сгенерированы папки build и devel.

Создать пакет:

ВЫПОЛНИТЬ:
mkdir -p workspace/src catkin_init_workspace
catkin_create_pkg paket1

Для создания пакета, имеющего зависимости, необходимо при создании пакета через catkin_create_pkg через пробел указать зависимости, а также указать их в CMakeLists.txt и package.xml

Открыть редактор файлов:

ВЫПОЛНИТЬ:
kate CMakelists.txt

В редакторе:

Указать зависимости файла: find_package (catkin REQUIRED paket1)
Добавить собственные файлы сообщений: 

ВЫПОЛНИТЬ:

add_message_files(
	FILES
	Message1.msg
	Message2.msg

Связь со стандартными сообщениями:

ВЫПОЛНИТЬ:

generate messages(
	DEPENDENCIES
	std msgs

ВЫПОЛНИТЬ:

catkin_package(
	INCLUDE_DIRS - внести заголовочные файлы
	LIBRARIES paket1 - использовать библиотеки
	CATKIN_DEPENDS other_catkin_pkg - использовать зависимости

Использовать написанную программу как библиотеку:

ВЫПОЛНИТЬ:
add_library(${PROJECT_NAME}
	src/${PROJECT_NAME}/paket1.cpp

Указать имя ноды, которая будет запускаться по команде rosrun:

ВЫПОЛНИТЬ:
add_executable(${PROJECT_NAME}_node src/node1.cpp

Указать библиотеки, которые необходимо подключить к исполняемому файлу

ВЫПОЛНИТЬ:
target_link_libraries(${PROJECT_NAME}_node
	${catkin_LIBRARIES}

Таким образом, поведение ноды может быть описано в нескольких исполняемых файлах.

Открыть файл package.xml:

ВЫПОЛНИТЬ:
kate package.xml

Этот файл содержит в себе имя пакета, его версия и описание. 

Написать сведения о пользователе: <maintainer email=12dvfg@mail.ru>root</maintainer>
Написать сведения о лицензии: <license>TODO</license> 

Необходимые строчки для компиляции, если пакет имеет зависимости (в зависимости от их типа):
<build_depend>message_generation</build_depend>
<buildtool_depend>catkin</buildtool_depend> - указывается по умолчанию
<run_depend>message_runtimr</run_depend>
<test_depend>gtest</test_depend>

Для сборки проекта запуск catkin_make осуществляется из корневой папки рабочей области. Несмотря на то, что пакет еще пуст, его уже можно скомпилировать:

ВЫПОЛНИТЬ:
cd ../../..
cd workspace
catkin_make

Создать в корневой директории папку с workspace-ом. Затем создать один компилируемый с помощью catkin_make пакет.

ВЫПОЛНИТЬ:

	mkdir -p workspace/src
	cd workspace/src
	catkin_init_workspace
	catkin_create_pkg numberone