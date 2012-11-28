TEMPLATE = app

DEFINES += QWEBKIT_EXAMPLE_NAME=\\\"flickrview\\\"

QT += quick qml webkitwidgets
SOURCES += ../shared/main.cpp

mac: CONFIG -= app_bundle

target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/flickrview
qml.files = flickrview.qml
qml.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/flickrview
INSTALLS += target qml
