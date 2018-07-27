#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D blendTex;
uniform sampler2D colorTex;
uniform vec2 screenSizeInv;

out vec4 fragColor;
in vec2 texCoord;
in vec4 offset;

vec4 SMAANeighborhoodBlendingPS(vec2 texcoord, vec4 offset_1)
{
    vec4 a;
    a.x = texture(blendTex, offset_1.xy).w;
    a.y = texture(blendTex, offset_1.zw).y;
    vec2 _41 = texture(blendTex, texcoord).xz;
    a = vec4(a.x, a.y, _41.y, _41.x);
    if (dot(a, vec4(1.0)) < 9.9999997473787516355514526367188e-06)
    {
        vec4 color = textureLod(colorTex, texcoord, 0.0);
        return color;
    }
    else
    {
        bool h = max(a.x, a.z) > max(a.y, a.w);
        vec4 blendingOffset = vec4(0.0, a.y, 0.0, a.w);
        vec2 blendingWeight = a.yw;
        if (h)
        {
            blendingOffset.x = a.x;
        }
        if (h)
        {
            blendingOffset.y = 0.0;
        }
        if (h)
        {
            blendingOffset.z = a.z;
        }
        if (h)
        {
            blendingOffset.w = 0.0;
        }
        if (h)
        {
            blendingWeight.x = a.x;
        }
        if (h)
        {
            blendingWeight.y = a.z;
        }
        blendingWeight /= vec2(dot(blendingWeight, vec2(1.0)));
        vec4 blendingCoord = (blendingOffset * vec4(screenSizeInv, -screenSizeInv)) + texcoord.xyxy;
        vec4 color_1 = textureLod(colorTex, blendingCoord.xy, 0.0) * blendingWeight.x;
        color_1 += (textureLod(colorTex, blendingCoord.zw, 0.0) * blendingWeight.y);
        return color_1;
    }
    return vec4(0.0);
}

void main()
{
    vec2 param = texCoord;
    vec4 param_1 = offset;
    fragColor = SMAANeighborhoodBlendingPS(param, param_1);
}

