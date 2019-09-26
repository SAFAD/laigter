#Laigter: an automatic map generator for lighting effects.
#Copyright (C) 2019  Pablo Ivan Fonovich
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.
#Contact: azagaya.games@gmail.com

#-------------------------------------------------
#
# Project created by QtCreator 2019-02-20T15:10:05
#
#-------------------------------------------------

QT       += core gui widgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = laigter
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += core ui c++11

SOURCES += \
    gui/aboutdialog.cpp \
    gui/presetsmanager.cpp \
        main.cpp \
        mainwindow.cpp \
    src/imageloader.cpp \
    src/imageprocessor.cpp \
    src/lightsource.cpp \
    src/openglwidget.cpp \
    gui/nbselector.cpp

HEADERS += \
    gui/aboutdialog.h \
    gui/presetsmanager.h \
        mainwindow.h \
    src/imageloader.h \
    src/imageprocessor.h \
    src/lightsource.h \
    src/openglwidget.h \
    gui/nbselector.h

FORMS += \
    gui/aboutdialog.ui \
    gui/presetsmanager.ui \
        mainwindow.ui \
    gui/nbselector.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

unix{
    CONFIG += link_pkgconfig
    packagesExist(opencv4){
        PKGCONFIG += opencv4
        DEFINES += CV_RGBA2GRAY=COLOR_RGBA2GRAY
        DEFINES += CV_RGB2GRAY=COLOR_RGB2GRAY
        DEFINES += CV_GRAY2RGB=COLOR_GRAY2RGB
        DEFINES += CV_GRAY2RGBA=COLOR_GRAY2RGBA
        DEFINES += CV_DIST_L2=DIST_L2
    } else {
        PKGCONFIG += opencv
    }
}

DISTFILES += \
    ACKNOWLEDGEMETS \
    LICENSE

TRANSLATIONS = laigter_es.ts \
               laigter_en.ts \
               laigter_fr.ts

LANGUAGES = en \
            es \
            fr

# parameters: var, prepend, append
defineReplace(prependAll) {
 for(a,$$1):result += $$2$${a}$$3
 return($$result)
}

TRANSLATIONS = $$prependAll(LANGUAGES, $$PWD/laigter_, .ts)

TRANSLATIONS_FILES =

qtPrepareTool(LRELEASE, lrelease)
for(tsfile, TRANSLATIONS) {
 qmfile = $$tsfile
 qmfile ~= s,.ts$,.qm,
 qmdir = $$dirname(qmfile)
 !exists($$qmdir) {
 mkpath($$qmdir)|error("Aborting.")
 }
 command = $$LRELEASE -removeidentical $$tsfile -qm $$qmfile
 system($$command)|error("Failed to run: $$command")
 TRANSLATIONS_FILES += $$qmfile
}

RESOURCES += \
    shaders.qrc \
    images.qrc \
    translations.qrc \
    icons.qrc

win32: LIBS += C:\opencv-build\install\x64\mingw\bin\libopencv_core320.dll
win32: LIBS += C:\opencv-build\install\x64\mingw\bin\libopencv_imgproc320.dll
win32: LIBS += C:\opencv-build\install\x64\mingw\bin\libopencv_imgcodecs320.dll

win32: INCLUDEPATH += C:\opencv\build\include

win32: RC_ICONS = icons\laigter-icon.ico
mac: ICON = icons/laigter-icon.icns


