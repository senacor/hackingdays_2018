import 'dart:ui';

String dpiName() {
    var ratio = window.devicePixelRatio;
    if (ratio <= 1.0) return "mdpi";
    if (ratio <= 1.5) return "hdpi";
    if (ratio <= 2.0) return "xhdpi";
    if (ratio <= 3.0) return "xxhdpi";
    return "xxxhdpi";
}
