#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform mat4 projectionMatrix;

in vec3 vertexPosition;
out vec4 fragmentColor;
in vec4 vertexColor;

void main()
{
    gl_Position = projectionMatrix * vec4(vertexPosition, 1.0);
    fragmentColor = vertexColor;
}

