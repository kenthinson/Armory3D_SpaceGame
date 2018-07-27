#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D tex;
uniform sampler2D gbufferD;

in vec2 texCoord;
out vec4 fragColor;

vec3 tonemapFilmic(vec3 color)
{
    vec3 x = max(vec3(0.0), color - vec3(0.0040000001899898052215576171875));
    return (x * ((x * 6.19999980926513671875) + vec3(0.5))) / ((x * ((x * 6.19999980926513671875) + vec3(1.7000000476837158203125))) + vec3(0.0599999986588954925537109375));
}

void main()
{
    vec2 texCo = texCoord;
    vec3 _57 = texture(tex, texCo).xyz;
    fragColor = vec4(_57.x, _57.y, _57.z, fragColor.w);
    vec3 _62 = tonemapFilmic(fragColor.xyz);
    fragColor = vec4(_62.x, _62.y, _62.z, fragColor.w);
}

