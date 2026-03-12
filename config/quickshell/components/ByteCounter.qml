import qs.config

Counter {
    required property real bytes

    property int level: bytes > 1073741824.0 ? 3 : bytes > 1048576.0 ? 2 : bytes > 1024.0 ? 1 : 0

    value: bytes * [1, Constants.mT, Constants.mTT, Constants.mTTT][level]
    postfix: ["B", "K", "M", "G"][level]
    preZeroes: 4
    postZeroes: 1
}
