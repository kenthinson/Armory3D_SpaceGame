#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform vec4 shirr[7];
uniform sampler2D gbuffer0;
uniform sampler2D gbuffer1;
uniform vec3 backgroundCol;
uniform float envmapStrength;
uniform sampler2D ssaotex;

in vec2 texCoord;
out vec4 fragColor;

vec2 octahedronWrap(vec2 v)
{
    return (vec2(1.0) - abs(v.yx)) * vec2((v.x >= 0.0) ? 1.0 : (-1.0), (v.y >= 0.0) ? 1.0 : (-1.0));
}

vec2 unpackFloat(float f)
{
    return vec2(floor(f) / 100.0, fract(f));
}

vec2 unpackFloat2(float f)
{
    return vec2(floor(f) / 255.0, fract(f));
}

vec3 surfaceAlbedo(vec3 baseColor, float metalness)
{
    return mix(baseColor, vec3(0.0), vec3(metalness));
}

vec3 shIrradiance(vec3 nor)
{
    vec3 cl00 = vec3(shirr[0].x, shirr[0].y, shirr[0].z);
    vec3 cl1m1 = vec3(shirr[0].w, shirr[1].x, shirr[1].y);
    vec3 cl10 = vec3(shirr[1].z, shirr[1].w, shirr[2].x);
    vec3 cl11 = vec3(shirr[2].y, shirr[2].z, shirr[2].w);
    vec3 cl2m2 = vec3(shirr[3].x, shirr[3].y, shirr[3].z);
    vec3 cl2m1 = vec3(shirr[3].w, shirr[4].x, shirr[4].y);
    vec3 cl20 = vec3(shirr[4].z, shirr[4].w, shirr[5].x);
    vec3 cl21 = vec3(shirr[5].y, shirr[5].z, shirr[5].w);
    vec3 cl22 = vec3(shirr[6].x, shirr[6].y, shirr[6].z);
    return ((((((((((cl22 * 0.429042994976043701171875) * ((nor.y * nor.y) - ((-nor.z) * (-nor.z)))) + (((cl20 * 0.743125021457672119140625) * nor.x) * nor.x)) + (cl00 * 0.88622701168060302734375)) - (cl20 * 0.2477079927921295166015625)) + (((cl2m2 * 0.85808598995208740234375) * nor.y) * (-nor.z))) + (((cl21 * 0.85808598995208740234375) * nor.y) * nor.x)) + (((cl2m1 * 0.85808598995208740234375) * (-nor.z)) * nor.x)) + ((cl11 * 1.02332794666290283203125) * nor.y)) + ((cl1m1 * 1.02332794666290283203125) * (-nor.z))) + ((cl10 * 1.02332794666290283203125) * nor.x);
}

vec3 surfaceF0(vec3 baseColor, float metalness)
{
    return mix(vec3(0.039999999105930328369140625), baseColor, vec3(metalness));
}

void main()
{
    vec4 g0 = texture(gbuffer0, texCoord);
    vec3 n;
    n.z = (1.0 - abs(g0.x)) - abs(g0.y);
    vec2 _266;
    if (n.z >= 0.0)
    {
        _266 = g0.xy;
    }
    else
    {
        _266 = octahedronWrap(g0.xy);
    }
    n = vec3(_266.x, _266.y, n.z);
    n = normalize(n);
    vec2 metrough = unpackFloat(g0.z);
    vec4 g1 = texture(gbuffer1, texCoord);
    vec2 occspec = unpackFloat2(g1.w);
    vec3 albedo = surfaceAlbedo(g1.xyz, metrough.x);
    vec3 envl = shIrradiance(n);
    envl *= albedo;
    envl += (backgroundCol * surfaceF0(g1.xyz, metrough.x));
    envl *= (envmapStrength * occspec.x);
    fragColor = vec4(envl.x, envl.y, envl.z, fragColor.w);
    vec3 _335 = fragColor.xyz * texture(ssaotex, texCoord).x;
    fragColor = vec4(_335.x, _335.y, _335.z, fragColor.w);
}

