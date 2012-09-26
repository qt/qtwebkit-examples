TEMPLATE = app

DEFINES += QWEBKIT_EXAMPLE_NAME=\\\"flickrview\\\"

QT += quick qml webkit
SOURCES += ../shared/main.cpp

target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/flickrview
qml.files = flickrview.qml
qml.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/flickrview
INSTALLS += target qml
