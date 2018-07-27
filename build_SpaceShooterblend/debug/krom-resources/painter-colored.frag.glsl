#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

out vec4 FragColor;
in vec4 fragmentColor;

void main()
{
    FragColor = fragmentColor;
}

