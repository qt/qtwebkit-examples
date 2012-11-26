TEMPLATE =  subdirs
SUBDIRS +=  domtraversal \
            formextractor \
            previewer \
            fancybrowser \
            simpleselector \
            imageanalyzer \
            framecapture \

# install
target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit
sources.files = $$SOURCES $$HEADERS $$RESOURCES $$FORMS webkit.pro README
sources.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/webkit
INSTALLS += target sources
