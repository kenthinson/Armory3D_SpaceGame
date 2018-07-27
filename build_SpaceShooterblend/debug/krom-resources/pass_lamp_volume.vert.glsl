#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform mat4 LVWVP;

out vec4 wvpposition;
in vec3 pos;

void main()
{
    wvpposition = LVWVP * vec4(pos, 1.0);
    gl_Position = wvpposition;
}

