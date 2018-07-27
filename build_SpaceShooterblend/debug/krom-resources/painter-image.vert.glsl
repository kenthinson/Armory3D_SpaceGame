#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform mat4 projectionMatrix;

in vec3 vertexPosition;
out vec2 texCoord;
in vec2 texPosition;
out vec4 color;
in vec4 vertexColor;

void main()
{
    gl_Position = projectionMatrix * vec4(vertexPosition, 1.0);
    texCoord = texPosition;
    color = vertexColor;
}

