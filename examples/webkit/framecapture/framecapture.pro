QT      += webkit network

HEADERS = framecapture.h
SOURCES = main.cpp \
          framecapture.cpp

# install
target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit/framecapture
sources.files = $$SOURCES $$HEADERS
sources.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit/framecapture
INSTALLS += target sources
