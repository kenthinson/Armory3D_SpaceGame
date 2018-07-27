#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D gbuffer0;
uniform sampler2D gbuffer1;
uniform mat4 invVP;
uniform vec3 eye;
uniform vec3 lightPos;
uniform int lightShadow;
uniform mat4 LWVP;
uniform float shadowsBias;
uniform sampler2D shadowMap;
uniform samplerCube shadowMapCube;
uniform vec2 lightProj;
uniform int lightType;
uniform vec3 lightDir;
uniform vec2 spotlightData;
uniform vec3 lightColor;
uniform vec4 casData[20];

in vec4 wvpposition;
out vec4 fragColor;

vec2 unpackFloat2(float f)
{
    return vec2(floor(f) / 255.0, fract(f));
}

vec2 octahedronWrap(vec2 v)
{
    return (vec2(1.0) - abs(v.yx)) * vec2((v.x >= 0.0) ? 1.0 : (-1.0), (v.y >= 0.0) ? 1.0 : (-1.0));
}

vec3 getPos2(mat4 invVP_1, float depth, vec2 coord)
{
    vec4 pos = vec4((coord * 2.0) - vec2(1.0), depth, 1.0);
    pos = invVP_1 * pos;
    vec3 _503 = pos.xyz / vec3(pos.w);
    pos = vec4(_503.x, _503.y, _503.z, pos.w);
    return pos.xyz;
}

vec2 unpackFloat(float f)
{
    return vec2(floor(f) / 100.0, fract(f));
}

vec3 surfaceAlbedo(vec3 baseColor, float metalness)
{
    return mix(baseColor, vec3(0.0), vec3(metalness));
}

vec3 surfaceF0(vec3 baseColor, float metalness)
{
    return mix(vec3(0.039999999105930328369140625), baseColor, vec3(metalness));
}

float shadowCompare(sampler2D shadowMap_1, vec2 uv, float compare)
{
    float depth = texture(shadowMap_1, uv).x;
    return step(compare, depth);
}

float shadowLerp(sampler2D shadowMap_1, vec2 uv, float compare, vec2 smSize)
{
    vec2 texelSize = vec2(1.0) / smSize;
    vec2 f = fract((uv * smSize) + vec2(0.5));
    vec2 centroidUV = floor((uv * smSize) + vec2(0.5)) / smSize;
    float lb = shadowCompare(shadowMap_1, centroidUV, compare);
    float lt = shadowCompare(shadowMap_1, centroidUV + (texelSize * vec2(0.0, 1.0)), compare);
    float rb = shadowCompare(shadowMap_1, centroidUV + (texelSize * vec2(1.0, 0.0)), compare);
    float rt = shadowCompare(shadowMap_1, centroidUV + texelSize, compare);
    float a = mix(lb, lt, f.y);
    float b = mix(rb, rt, f.y);
    float c = mix(a, b, f.x);
    return c;
}

float PCF(sampler2D shadowMap_1, vec2 uv, float compare, vec2 smSize)
{
    float result = shadowLerp(shadowMap_1, uv + (vec2(-1.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(-1.0, 0.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(-1.0, 1.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(0.0, -1.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv, compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(0.0, 1.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(1.0, -1.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(1.0, 0.0) / smSize), compare, smSize);
    result += shadowLerp(shadowMap_1, uv + (vec2(1.0) / smSize), compare, smSize);
    return result / 9.0;
}

float shadowTest(sampler2D shadowMap_1, vec3 lPos, float shadowsBias_1, vec2 smSize)
{
    bool _445 = lPos.x < 0.0;
    bool _451;
    if (!_445)
    {
        _451 = lPos.y < 0.0;
    }
    else
    {
        _451 = _445;
    }
    bool _457;
    if (!_451)
    {
        _457 = lPos.x > 1.0;
    }
    else
    {
        _457 = _451;
    }
    bool _463;
    if (!_457)
    {
        _463 = lPos.y > 1.0;
    }
    else
    {
        _463 = _457;
    }
    if (_463)
    {
        return 1.0;
    }
    return PCF(shadowMap_1, lPos.xy, lPos.z - shadowsBias_1, smSize);
}

float lpToDepth(inout vec3 lp, vec2 lightProj_1)
{
    lp = abs(lp);
    float zcomp = max(lp.x, max(lp.y, lp.z));
    zcomp = lightProj_1.x - (lightProj_1.y / zcomp);
    return (zcomp * 0.5) + 0.5;
}

float PCFCube(samplerCube shadowMapCube_1, vec3 lp, inout vec3 ml, float bias, vec2 lightProj_1, vec3 n)
{
    vec3 param = lp - (n * 0.0030000000260770320892333984375);
    float _342 = lpToDepth(param, lightProj_1);
    float compare = _342 - (bias * 0.4000000059604644775390625);
    ml += (n * 0.0030000000260770320892333984375);
    float result = step(compare, texture(shadowMapCube_1, ml).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(-0.001000000047497451305389404296875, 0.001000000047497451305389404296875, 0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(0.001000000047497451305389404296875, -0.001000000047497451305389404296875, 0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(0.001000000047497451305389404296875, 0.001000000047497451305389404296875, -0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(-0.001000000047497451305389404296875, -0.001000000047497451305389404296875, 0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(0.001000000047497451305389404296875, -0.001000000047497451305389404296875, -0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(-0.001000000047497451305389404296875, 0.001000000047497451305389404296875, -0.001000000047497451305389404296875)).x);
    result += step(compare, texture(shadowMapCube_1, ml + vec3(-0.001000000047497451305389404296875)).x);
    result /= 9.0;
    return result;
}

float attenuate(float dist)
{
    return 1.0 / (dist * dist);
}

vec3 lambertDiffuseBRDF(vec3 albedo, float nl)
{
    return albedo * max(0.0, nl);
}

float d_ggx(float nh, float a)
{
    float a2 = a * a;
    float denom = pow(((nh * nh) * (a2 - 1.0)) + 1.0, 2.0);
    return (a2 * 0.3183098733425140380859375) / denom;
}

float v_smithschlick(float nl, float nv, float a)
{
    return 1.0 / (((nl * (1.0 - a)) + a) * ((nv * (1.0 - a)) + a));
}

vec3 f_schlick(vec3 f0, float vh)
{
    return f0 + ((vec3(1.0) - f0) * exp2((((-5.554729938507080078125) * vh) - 6.9831600189208984375) * vh));
}

vec3 specularBRDF(vec3 f0, float roughness, float nl, float nh, float nv, float vh)
{
    float a = roughness * roughness;
    return (f_schlick(f0, vh) * (d_ggx(nh, a) * clamp(v_smithschlick(nl, nv, a), 0.0, 1.0))) / vec3(4.0);
}

void main()
{
    vec2 texCoord = wvpposition.xy / vec2(wvpposition.w);
    texCoord = (texCoord * 0.5) + vec2(0.5);
    vec4 g0 = texture(gbuffer0, texCoord);
    vec4 g1 = texture(gbuffer1, texCoord);
    float spec = unpackFloat2(g1.w).y;
    float depth = ((1.0 - g0.w) * 2.0) - 1.0;
    vec3 n;
    n.z = (1.0 - abs(g0.x)) - abs(g0.y);
    vec2 _572;
    if (n.z >= 0.0)
    {
        _572 = g0.xy;
    }
    else
    {
        _572 = octahedronWrap(g0.xy);
    }
    n = vec3(_572.x, _572.y, n.z);
    n = normalize(n);
    vec3 p = getPos2(invVP, depth, texCoord);
    vec2 metrough = unpackFloat(g0.z);
    vec3 v = normalize(eye - p);
    float dotNV = dot(n, v);
    vec3 albedo = surfaceAlbedo(g1.xyz, metrough.x);
    vec3 f0 = surfaceF0(g1.xyz, metrough.x);
    vec3 lp = lightPos - p;
    vec3 l = normalize(lp);
    vec3 h = normalize(v + l);
    float dotNH = dot(n, h);
    float dotVH = dot(v, h);
    float dotNL = dot(n, l);
    float visibility = 1.0;
    if (lightShadow == 1)
    {
        vec4 lPos = LWVP * vec4(p + ((n * shadowsBias) * 10.0), 1.0);
        if (lPos.w > 0.0)
        {
            visibility = shadowTest(shadowMap, lPos.xyz / vec3(lPos.w), shadowsBias, vec2(1024.0));
        }
    }
    else
    {
        if (lightShadow == 2)
        {
            vec3 param = -l;
            float _703 = PCFCube(shadowMapCube, lp, param, shadowsBias, lightProj, n);
            visibility = _703;
        }
    }
    visibility *= attenuate(distance(p, lightPos));
    if (lightType == 2)
    {
        float spotEffect = dot(lightDir, l);
        if (spotEffect < spotlightData.x)
        {
            visibility *= smoothstep(spotlightData.y, spotlightData.x, spotEffect);
        }
    }
    vec3 _750 = lambertDiffuseBRDF(albedo, dotNL) + (specularBRDF(f0, metrough.y, dotNL, dotNH, dotNV, dotVH) * spec);
    fragColor = vec4(_750.x, _750.y, _750.z, fragColor.w);
    vec3 _757 = fragColor.xyz * lightColor;
    fragColor = vec4(_757.x, _757.y, _757.z, fragColor.w);
    vec3 _763 = fragColor.xyz * visibility;
    fragColor = vec4(_763.x, _763.y, _763.z, fragColor.w);
}

