#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D colorTex;

in vec4 offset0;
in vec4 offset1;
in vec4 offset2;
out vec4 fragColor;
in vec2 texCoord;

vec2 SMAAColorEdgeDetectionPS(vec2 texcoord)
{
    vec2 threshold = vec2(0.100000001490116119384765625);
    vec3 C = texture(colorTex, texcoord).xyz;
    vec3 Cleft = texture(colorTex, offset0.xy).xyz;
    vec3 t = abs(C - Cleft);
    vec4 delta;
    delta.x = max(max(t.x, t.y), t.z);
    vec3 Ctop = texture(colorTex, offset0.zw).xyz;
    t = abs(C - Ctop);
    delta.y = max(max(t.x, t.y), t.z);
    vec2 edges = step(threshold, delta.xy);
    if (dot(edges, vec2(1.0)) == 0.0)
    {
        discard;
    }
    vec3 Cright = texture(colorTex, offset1.xy).xyz;
    t = abs(C - Cright);
    delta.z = max(max(t.x, t.y), t.z);
    vec3 Cbottom = texture(colorTex, offset1.zw).xyz;
    t = abs(C - Cbottom);
    delta.w = max(max(t.x, t.y), t.z);
    vec2 maxDelta = max(delta.xy, delta.zw);
    vec3 Cleftleft = texture(colorTex, offset2.xy).xyz;
    t = abs(C - Cleftleft);
    delta.z = max(max(t.x, t.y), t.z);
    vec3 Ctoptop = texture(colorTex, offset2.zw).xyz;
    t = abs(C - Ctoptop);
    delta.w = max(max(t.x, t.y), t.z);
    maxDelta = max(maxDelta, delta.zw);
    float finalDelta = max(maxDelta.x, maxDelta.y);
    edges *= step(vec2(finalDelta), delta.xy * 2.0);
    return edges;
}

void main()
{
    vec2 param = texCoord;
    vec2 _204 = SMAAColorEdgeDetectionPS(param);
    fragColor = vec4(_204.x, _204.y, fragColor.z, fragColor.w);
}

