QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

#----------------------------------------------------------------------
# Installer
#----------------------------------------------------------------------

OTHER_FILES += \
    Installer/config/* \
    Installer/packages/com.esri.helloworld/meta/* \
    Installer/packages/com.esri.helloworld/data/*

copydata.commands = \
    $(COPY_DIR) $$shell_path($$PWD/Installer/config) $$shell_path($$OUT_PWD/Installer/config) \
    $$escape_expand(\n\t) $(COPY_DIR) $$shell_path($$PWD/Installer/packages) $$shell_path($$OUT_PWD/Installer/packages) \
    $$escape_expand(\n\t) $(COPY_DIR) $$shell_path($$[QT_INSTALL_PREFIX]/plugins) $$shell_path($$OUT_PWD/Installer/packages/com.esri.helloworld/data) \
    $$escape_expand(\n\t) $(COPY_DIR) $$shell_path($$[QT_INSTALL_PREFIX]/qml) $$shell_path($$OUT_PWD/Installer/packages/com.esri.helloworld/data/qml) \
    $$escape_expand(\n\t) $(COPY_FILE) $$shell_path($$[QT_INSTALL_PREFIX]/bin/*.dll) $$shell_path($$OUT_PWD/Installer/packages/com.esri.helloworld/data)

win32 {
    CONFIG(debug, debug|release) {
copydata.commands += $$escape_expand(\n\t) $(COPY_FILE) $$shell_path($$OUT_PWD/debug/*.exe) $$shell_path($$OUT_PWD/Installer/packages/com.esri.helloworld/data)
    } else {
copydata.commands += $$escape_expand(\n\t) $(COPY_FILE) $$shell_path($$OUT_PWD/release/*.exe) $$shell_path($$OUT_PWD/Installer/packages/com.esri.helloworld/data)
    }
copydata.commands += \
    $$escape_expand(\n\t) C:\Qt\QtIFW-3.0.6\bin\binarycreator.exe \
        -c $$shell_path($$OUT_PWD/Installer/config/config.xml) \
        -p $$shell_path($$OUT_PWD/Installer/packages) \
        -v \
        SetupHelloWorld
}


first.depends = $(first) copydata

export(first.depends)
export(copydata.commands)

QMAKE_EXTRA_TARGETS += first copydata

#----------------------------------------------------------------------
#
#----------------------------------------------------------------------

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
