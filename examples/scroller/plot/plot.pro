HEADERS       = settingswidget.h \
                plotwidget.h
SOURCES       = settingswidget.cpp \
                plotwidget.cpp \
                main.cpp

QT += webkitwidgets widgets

# install
target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/scroller/plot
sources.files = $$SOURCES $$HEADERS $$RESOURCES $$FORMS plot.pro
sources.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/scroller/plot
INSTALLS += target sources
