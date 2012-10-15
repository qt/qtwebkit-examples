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

symbian {
    TARGET.UID3 = 0xA000CF6C
    TARGET.EPOCHEAPSIZE = 0×020000 0×4000000
    TARGET.CAPABILITY += Location NetworkServices
    CONFIG += qt_example
}
