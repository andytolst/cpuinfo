QT += qml quick

INCLUDEPATH += $$PWD

SOURCES += main.cpp \
           cpumodel.cpp

HEADERS += cpumodel.h

OTHER_FILES += qml/*.qml \
               qml/*.js

RESOURCES += \
    resource.qrc
