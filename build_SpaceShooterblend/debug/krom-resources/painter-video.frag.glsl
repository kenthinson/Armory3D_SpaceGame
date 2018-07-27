#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D tex;

in vec2 texCoord;
in vec4 color;
out vec4 FragColor;

void main()
{
    vec4 texcolor = texture(tex, texCoord) * color;
    vec3 _32 = texcolor.xyz * color.w;
    texcolor = vec4(_32.x, _32.y, _32.z, texcolor.w);
    FragColor = texcolor;
}

