#include <QtGui/QGuiApplication>
#include "cpumodel.h"
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView viewer;
    CpuModel model(&viewer);
    model.populateModel();

    viewer.engine()->rootContext()->setContextProperty("CpuModel", &model);
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);

    viewer.setSource(QUrl("qrc:///qml/main.qml"));
    viewer.show();

    return app.exec();
}
