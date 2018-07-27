#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D tex;

out vec4 FragColor;
in vec4 fragmentColor;
in vec2 texCoord;

void main()
{
    FragColor = vec4(fragmentColor.xyz, texture(tex, texCoord).x * fragmentColor.w);
}

