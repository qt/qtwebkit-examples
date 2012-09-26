TEMPLATE = app

DEFINES += QWEBKIT_EXAMPLE_NAME=\\\"youtubeview\\\"

QT += quick qml webkit
SOURCES += ../shared/main.cpp

target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/youtubeview
qml.files = youtubeview.qml content
qml.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/youtubeview
INSTALLS += target qml

OTHER_FILES += \
    player.html
