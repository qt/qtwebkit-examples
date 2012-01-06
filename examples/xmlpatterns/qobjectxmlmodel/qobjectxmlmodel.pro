
FORMS       += forms/mainwindow.ui
QT +=       xmlpatterns webkit widgets
SOURCES     += qobjectxmlmodel.cpp main.cpp mainwindow.cpp ../shared/xmlsyntaxhighlighter.cpp
HEADERS     += qobjectxmlmodel.h  mainwindow.h ../shared/xmlsyntaxhighlighter.h
RESOURCES   = queries.qrc
INCLUDEPATH += ../shared/

# install
target.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/xmlpatterns/qobjectxmlmodel
sources.files = $$SOURCES $$HEADERS $$RESOURCES $$FORMS *.pro *.xq *.html
sources.path = $$[QT_INSTALL_EXAMPLES]/qtwebkit-examples-and-demos/xmlpatterns/qobjectxmlmodel
INSTALLS += target sources

symbian {
    TARGET.UID3 = 0xA000D7C8
    CONFIG += qt_example
}
