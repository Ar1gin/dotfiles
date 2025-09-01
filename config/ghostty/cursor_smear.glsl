const float DURATION = 0.75;
const float MIN_FAC = -0.5;
const float A = -8.0 / DURATION;
const float B = 4.0 / DURATION;
const float V = 0.70710678;

vec2 lerp2(vec2 a, vec2 b, float fac) {
    const float MULT = (1 - MIN_FAC) * -0.5;
    const float ADD = (1 + MULT);
    float durmult = max(0.00001, fac * MULT + ADD);
    float time = (iTime - iTimeCursorChange) / (durmult * DURATION);
    float e = exp(time * A) * cos(time * B);
    return a * e + b * (1 - e);
}
vec4 lerp4(vec4 a, vec4 b) {
    float time = (iTime - iTimeCursorChange);
    float e = exp(time * A) * cos(time * B);
    return a * e + b * (1 - e);
}
float cross3(vec2 a, vec2 b, vec2 c) {
    return (c.x - a.x) * (b.y - a.y) - (c.y - a.y) * (b.x - a.x);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 invres = 1.0 / iResolution.xy;
    fragColor = texture(iChannel0, fragCoord * invres);

    vec2 diff = iCurrentCursor.xy - iPreviousCursor.xy;
    vec2 norm = diff / sqrt(dot(diff, diff));

    float afac = dot(vec2(-V, V), norm);
    float bfac = dot(vec2(-V, -V), norm);
    float cfac = dot(vec2(V, -V), norm);
    float dfac = dot(vec2(V, V), norm);

    vec4 prev = vec4(iPreviousCursor.x, iPreviousCursor.y, iPreviousCursor.x + iPreviousCursor.z, iPreviousCursor.y - iPreviousCursor.w);
    vec4 curr = vec4(iCurrentCursor.x, iCurrentCursor.y, iCurrentCursor.x + iCurrentCursor.z, iCurrentCursor.y - iCurrentCursor.w);
    if (
        fragCoord.x > curr.x + 1 &&
        fragCoord.x < curr.z - 1 &&
        fragCoord.y < curr.y - 1 &&
        fragCoord.y > curr.w + 1
    ) return;
    vec2 a = lerp2(prev.xy, curr.xy, afac);
    vec2 b = lerp2(prev.xw, curr.xw, bfac);
    if(cross3(a, b, fragCoord) > 0.0) return;
    vec2 c = lerp2(prev.zw, curr.zw, cfac);
    if(cross3(b, c, fragCoord) > 0.0) return;
    vec2 d = lerp2(prev.zy, curr.zy, dfac);
    if(cross3(c, d, fragCoord) > 0.0) return;
    if(cross3(d, a, fragCoord) > 0.0) return;

    fragColor = mix(fragColor, pow(iCurrentCursorColor, vec4(2.2)), fragColor.a);
}
