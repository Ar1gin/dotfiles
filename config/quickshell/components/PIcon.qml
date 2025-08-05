import QtQuick

Image {
    required property string name

    source: `image://icon/${name}`
    fillMode: Image.PreserveAspectFit
    sourceSize.width: width * 2
    sourceSize.height: height * 2
}
