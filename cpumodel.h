#ifndef CPUMODEL_H
#define CPUMODEL_H

#include <QAbstractListModel>

// Model that holds CPU info
class CpuModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit CpuModel(QObject *parent = 0);

    // populates model from cpuinfo file
    Q_INVOKABLE void populateModel();

    // returns a complete string for a given index as key:value pairs
    Q_INVOKABLE QString prettyFormat(int index) const;

private:
    // from QAbstractListModel
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;

private:
    // stores data as key:value map for each logical CPU core
    QList<QMap<QString, QString> > m_data;

    // role names for the model
    QHash<int, QByteArray> m_roleNames;
};

#endif // CPUMODEL_H
