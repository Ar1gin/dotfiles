// Source - https://stackoverflow.com/a/22903361
// Posted by Charles, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-11, License - CC BY-SA 3.0

import QtQuick
import qs.config

Canvas {
    id: canvas
    antialiasing: true

    required property real value
    property real offset: 0
    property real end: 1
    property bool clockwise: false

    property real barWidth: Constants.splitWidth

    property color foreground: Colors.foreground
    property color background: Colors.dimmer

    readonly property real radius: Math.min(canvas.width, canvas.height) * 0.5

    onForegroundChanged: requestPaint()
    onBackgroundChanged: requestPaint()
    onValueChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        const radius = canvas.radius - canvas.barWidth * 0.5;
        const angle = canvas.value * -2 * Math.PI * canvas.end;
        const angleOffset = canvas.offset * -2 * Math.PI;
        const centerX = canvas.width * 0.5;
        const centerY = canvas.height * 0.5;
        const angleEnd = angleOffset + canvas.end * -2 * Math.PI;

        if(canvas.clockwise) {
            const angleCos = Math.cos(angleEnd - angle);
            const angleSin = Math.sin(angleEnd - angle);
            ctx.beginPath();
            ctx.lineWidth = canvas.barWidth * 0.5;
            ctx.strokeStyle = canvas.background;
            ctx.arc(
                centerX,
                centerY,
                radius,
                angleEnd - angle,
                angleOffset,
            );
            ctx.stroke();

            ctx.beginPath();
            ctx.lineWidth = canvas.barWidth;
            ctx.strokeStyle = canvas.foreground;
            ctx.arc(
                centerX,
                centerY,
                radius,
                angleEnd,
                angleEnd - angle,
            );
            ctx.moveTo(centerX + angleCos * (radius - canvas.barWidth - 1.5), centerY + angleSin * (radius - canvas.barWidth * 1.5));
            ctx.lineTo(centerX + angleCos * (radius + canvas.barWidth * 0.40), centerY + angleSin * (radius + canvas.barWidth * 0.40));
            ctx.stroke();
        } else {
            const angleCos = Math.cos(angleOffset + angle);
            const angleSin = Math.sin(angleOffset + angle);
            ctx.beginPath();
            ctx.lineWidth = canvas.barWidth * 0.5;
            ctx.strokeStyle = canvas.background;
            ctx.arc(
                centerX,
                centerY,
                radius,
                angleEnd,
                angleOffset + angle,
            );
            ctx.stroke();

            ctx.beginPath();
            ctx.lineWidth = canvas.barWidth;
            ctx.strokeStyle = canvas.foreground;
            ctx.arc(
                centerX,
                centerY,
                radius,
                angleOffset + angle,
                angleOffset,
            );
            ctx.moveTo(centerX + angleCos * (radius - canvas.barWidth - 1.5), centerY + angleSin * (radius - canvas.barWidth * 1.5));
            ctx.lineTo(centerX + angleCos * (radius + canvas.barWidth * 0.40), centerY + angleSin * (radius + canvas.barWidth * 0.40));
            ctx.stroke();
        }

        ctx.restore();
    }
}
