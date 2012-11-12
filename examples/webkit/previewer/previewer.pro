QT      +=  webkitwidgets network widgets
HEADERS =   previewer.h \
            mainwindow.h
SOURCES =   main.cpp \
            previewer.cpp \
            mainwindow.cpp
FORMS   =   previewer.ui

# install
target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit/previewer
sources.files = $$SOURCES $$HEADERS $$FORMS $$RESOURCES *.pro images
sources.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit/previewer
INSTALLS += target sources
