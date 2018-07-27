#version 450
#define _Irr
#define _EnvCol
#define _Deferred
#define _CSM
#define _SMAA
#define _SSAO
in vec3 pos;
uniform mat4 LWVP;
void main() {
vec4 spos = vec4(pos, 1.0);
	gl_Position = LWVP * spos;
}
