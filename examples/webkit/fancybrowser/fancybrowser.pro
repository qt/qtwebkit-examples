QT      +=  webkitwidgets network widgets
HEADERS =   mainwindow.h
SOURCES =   main.cpp \
            mainwindow.cpp
RESOURCES = jquery.qrc

# install
target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit/fancybrowser
sources.files = $$SOURCES $$HEADERS $$RESOURCES *.pro
sources.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit/fancybrowser
INSTALLS += target sources
