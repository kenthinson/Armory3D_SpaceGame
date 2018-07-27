#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform vec2 aspectRatio;
uniform sampler2D gbufferD;
uniform vec3 eye;
uniform mat4 invVP;
uniform sampler2D gbuffer0;
uniform sampler2D snoise;
uniform vec2 screenSize;

in vec2 texCoord;
out vec4 fragColor;

vec2 octahedronWrap(vec2 v)
{
    return (vec2(1.0) - abs(v.yx)) * vec2((v.x >= 0.0) ? 1.0 : (-1.0), (v.y >= 0.0) ? 1.0 : (-1.0));
}

vec3 getPos2NoEye(vec3 eye_1, mat4 invVP_1, float depth, vec2 coord)
{
    vec4 pos = vec4((coord * 2.0) - vec2(1.0), depth, 1.0);
    pos = invVP_1 * pos;
    vec3 _74 = pos.xyz / vec3(pos.w);
    pos = vec4(_74.x, _74.y, _74.z, pos.w);
    return pos.xyz - eye_1;
}

float doAO(inout vec2 kernelVec, vec2 randomVec, mat2 rotMat, vec3 currentPos, vec3 n, float currentDistance)
{
    kernelVec *= aspectRatio;
    float radius = 0.119999997317790985107421875 * randomVec.y;
    kernelVec = ((rotMat * kernelVec) / vec2(currentDistance)) * radius;
    vec2 coord = texCoord + kernelVec;
    float depth = (texture(gbufferD, coord).x * 2.0) - 1.0;
    vec3 pos = getPos2NoEye(eye, invVP, depth, coord) - currentPos;
    float angle = dot(pos, n);
    angle *= step(0.100000001490116119384765625, angle / length(pos));
    angle -= (currentDistance * 0.001000000047497451305389404296875);
    angle = max(0.0, angle);
    angle /= ((dot(pos, pos) / min(currentDistance * 0.25, 1.0)) + 0.001000000047497451305389404296875);
    return angle;
}

void main()
{
    float depth = (texture(gbufferD, texCoord).x * 2.0) - 1.0;
    if (depth == 1.0)
    {
        fragColor.x = 1.0;
        return;
    }
    vec2 enc = texture(gbuffer0, texCoord).xy;
    vec3 n;
    n.z = (1.0 - abs(enc.x)) - abs(enc.y);
    vec2 _198;
    if (n.z >= 0.0)
    {
        _198 = enc;
    }
    else
    {
        _198 = octahedronWrap(enc);
    }
    n = vec3(_198.x, _198.y, n.z);
    n = normalize(n);
    vec3 currentPos = getPos2NoEye(eye, invVP, depth, texCoord);
    float currentDistance = length(currentPos);
    vec2 randomVec = texture(snoise, (texCoord * screenSize) / vec2(8.0)).xy;
    randomVec = (randomVec * 2.0) - vec2(1.0);
    mat2 rotMat = mat2(vec2(vec2(cos(randomVec.x * 3.1415927410125732421875), -sin(randomVec.x * 3.1415927410125732421875))), vec2(vec2(sin(randomVec.x * 3.1415927410125732421875), cos(randomVec.x * 3.1415927410125732421875))));
    vec2 param = vec2(1.0, 0.0);
    vec2 param_1 = randomVec;
    mat2 param_2 = rotMat;
    vec3 param_3 = currentPos;
    vec3 param_4 = n;
    float param_5 = currentDistance;
    float _275 = doAO(param, param_1, param_2, param_3, param_4, param_5);
    fragColor.x = _275;
    vec2 param_6 = vec2(0.866025388240814208984375, 0.4999999105930328369140625);
    vec2 param_7 = randomVec;
    mat2 param_8 = rotMat;
    vec3 param_9 = currentPos;
    vec3 param_10 = n;
    float param_11 = currentDistance;
    float _291 = doAO(param_6, param_7, param_8, param_9, param_10, param_11);
    fragColor.x += _291;
    vec2 param_12 = vec2(0.5, 0.866025388240814208984375);
    vec2 param_13 = randomVec;
    mat2 param_14 = rotMat;
    vec3 param_15 = currentPos;
    vec3 param_16 = n;
    float param_17 = currentDistance;
    float _309 = doAO(param_12, param_13, param_14, param_15, param_16, param_17);
    fragColor.x += _309;
    vec2 param_18 = vec2(0.0, 1.0);
    vec2 param_19 = randomVec;
    mat2 param_20 = rotMat;
    vec3 param_21 = currentPos;
    vec3 param_22 = n;
    float param_23 = currentDistance;
    float _326 = doAO(param_18, param_19, param_20, param_21, param_22, param_23);
    fragColor.x += _326;
    vec2 param_24 = vec2(-0.4999999105930328369140625, 0.866025388240814208984375);
    vec2 param_25 = randomVec;
    mat2 param_26 = rotMat;
    vec3 param_27 = currentPos;
    vec3 param_28 = n;
    float param_29 = currentDistance;
    float _344 = doAO(param_24, param_25, param_26, param_27, param_28, param_29);
    fragColor.x += _344;
    vec2 param_30 = vec2(-0.866025388240814208984375, 0.5);
    vec2 param_31 = randomVec;
    mat2 param_32 = rotMat;
    vec3 param_33 = currentPos;
    vec3 param_34 = n;
    float param_35 = currentDistance;
    float _362 = doAO(param_30, param_31, param_32, param_33, param_34, param_35);
    fragColor.x += _362;
    vec2 param_36 = vec2(-1.0, 0.0);
    vec2 param_37 = randomVec;
    mat2 param_38 = rotMat;
    vec3 param_39 = currentPos;
    vec3 param_40 = n;
    float param_41 = currentDistance;
    float _379 = doAO(param_36, param_37, param_38, param_39, param_40, param_41);
    fragColor.x += _379;
    vec2 param_42 = vec2(-0.866025388240814208984375, -0.4999999105930328369140625);
    vec2 param_43 = randomVec;
    mat2 param_44 = rotMat;
    vec3 param_45 = currentPos;
    vec3 param_46 = n;
    float param_47 = currentDistance;
    float _396 = doAO(param_42, param_43, param_44, param_45, param_46, param_47);
    fragColor.x += _396;
    vec2 param_48 = vec2(-0.5, -0.866025388240814208984375);
    vec2 param_49 = randomVec;
    mat2 param_50 = rotMat;
    vec3 param_51 = currentPos;
    vec3 param_52 = n;
    float param_53 = currentDistance;
    float _414 = doAO(param_48, param_49, param_50, param_51, param_52, param_53);
    fragColor.x += _414;
    vec2 param_54 = vec2(0.0, -1.0);
    vec2 param_55 = randomVec;
    mat2 param_56 = rotMat;
    vec3 param_57 = currentPos;
    vec3 param_58 = n;
    float param_59 = currentDistance;
    float _431 = doAO(param_54, param_55, param_56, param_57, param_58, param_59);
    fragColor.x += _431;
    vec2 param_60 = vec2(0.4999999105930328369140625, -0.866025388240814208984375);
    vec2 param_61 = randomVec;
    mat2 param_62 = rotMat;
    vec3 param_63 = currentPos;
    vec3 param_64 = n;
    float param_65 = currentDistance;
    float _448 = doAO(param_60, param_61, param_62, param_63, param_64, param_65);
    fragColor.x += _448;
    vec2 param_66 = vec2(0.866025388240814208984375, -0.5);
    vec2 param_67 = randomVec;
    mat2 param_68 = rotMat;
    vec3 param_69 = currentPos;
    vec3 param_70 = n;
    float param_71 = currentDistance;
    float _465 = doAO(param_66, param_67, param_68, param_69, param_70, param_71);
    fragColor.x += _465;
    fragColor.x *= 0.008333333767950534820556640625;
    fragColor.x = max(0.0, 1.0 - fragColor.x);
}

