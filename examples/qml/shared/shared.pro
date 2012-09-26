#just install the files
TEMPLATE = aux

qml.files = images \
            LoadIndicator.qml \
            Button.qml \
            main.cpp \
            qmldir

qml.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/examples/qml/shared
INSTALLS = qml
