TEMPLATE = app

DEFINES += QWEBKIT_EXAMPLE_NAME=\\\"flickrview\\\"

QT += quick qml webkit
SOURCES += ../shared/main.cpp

mac: CONFIG -= app_bundle

target.path = $$[QT_INSTALL_EXAMPLES]/webkitqml/flickrview
qml.files = flickrview.qml
qml.path = $$[QT_INSTALL_EXAMPLES]/webkitqml/flickrview
INSTALLS += target qml
