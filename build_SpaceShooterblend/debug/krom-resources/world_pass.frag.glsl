#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform vec3 backgroundCol;

out vec4 fragColor;
in vec3 normal;

void main()
{
    fragColor = vec4(backgroundCol.x, backgroundCol.y, backgroundCol.z, fragColor.w);
}

