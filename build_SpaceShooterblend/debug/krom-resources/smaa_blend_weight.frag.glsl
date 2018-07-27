#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform vec2 screenSizeInv;
uniform sampler2D edgesTex;
uniform sampler2D areaTex;
uniform sampler2D searchTex;
uniform vec2 screenSize;

in vec4 offset0;
in vec4 offset2;
in vec4 offset1;
out vec4 fragColor;
in vec2 texCoord;
in vec2 pixcoord;
vec2 cdw_end;

vec2 SMAASearchDiag1(vec2 texcoord, vec2 dir)
{
    vec4 coord = vec4(texcoord, -1.0, 1.0);
    vec3 t = vec3(screenSizeInv, 1.0);
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    if (coord.z >= 7.0)
    {
        return coord.zw;
    }
    vec3 _185 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_185.x, _185.y, _185.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _220 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_220.x, _220.y, _220.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _247 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_247.x, _247.y, _247.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _274 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_274.x, _274.y, _274.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _301 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_301.x, _301.y, _301.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _328 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_328.x, _328.y, _328.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _355 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_355.x, _355.y, _355.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    coord.w = dot(cdw_end, vec2(0.5));
    return coord.zw;
}

vec4 SMAADecodeDiagBilinearAccess(inout vec4 e)
{
    vec2 _131 = e.xz * abs((e.xz * 5.0) - vec2(3.75));
    e = vec4(_131.x, e.y, _131.y, e.w);
    return floor(e + vec4(0.5));
}

vec2 SMAAAreaDiag(vec2 dist, vec2 e, float offset)
{
    vec2 texcoord = (vec2(20.0) * e) + dist;
    texcoord = (vec2(0.0062500000931322574615478515625, 0.001785714295692741870880126953125) * texcoord) + vec2(0.00312500004656612873077392578125, 0.0008928571478463709354400634765625);
    texcoord.x += 0.5;
    texcoord.y += (0.14285714924335479736328125 * offset);
    return textureLod(areaTex, texcoord, 0.0).xy;
}

vec2 SMAADecodeDiagBilinearAccess(inout vec2 e)
{
    e.x *= abs((5.0 * e.x) - 3.75);
    return floor(e + vec2(0.5));
}

vec2 SMAASearchDiag2(vec2 texcoord, vec2 dir)
{
    vec4 coord = vec4(texcoord, -1.0, 1.0);
    coord.x += (0.25 * screenSizeInv.x);
    vec3 t = vec3(screenSizeInv, 1.0);
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    if (coord.z >= 7.0)
    {
        return coord.zw;
    }
    vec3 _413 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_413.x, _413.y, _413.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param = cdw_end;
    vec2 _423 = SMAADecodeDiagBilinearAccess(param);
    cdw_end = _423;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _443 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_443.x, _443.y, _443.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param_1 = cdw_end;
    vec2 _453 = SMAADecodeDiagBilinearAccess(param_1);
    cdw_end = _453;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _473 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_473.x, _473.y, _473.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param_2 = cdw_end;
    vec2 _483 = SMAADecodeDiagBilinearAccess(param_2);
    cdw_end = _483;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _503 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_503.x, _503.y, _503.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param_3 = cdw_end;
    vec2 _513 = SMAADecodeDiagBilinearAccess(param_3);
    cdw_end = _513;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _533 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_533.x, _533.y, _533.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param_4 = cdw_end;
    vec2 _543 = SMAADecodeDiagBilinearAccess(param_4);
    cdw_end = _543;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _563 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_563.x, _563.y, _563.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param_5 = cdw_end;
    vec2 _573 = SMAADecodeDiagBilinearAccess(param_5);
    cdw_end = _573;
    coord.w = dot(cdw_end, vec2(0.5));
    if (coord.w <= 0.89999997615814208984375)
    {
        return coord.zw;
    }
    vec3 _593 = (t * vec3(dir, 1.0)) + coord.xyz;
    coord = vec4(_593.x, _593.y, _593.z, coord.w);
    cdw_end = textureLod(edgesTex, coord.xy, 0.0).xy;
    vec2 param_6 = cdw_end;
    vec2 _603 = SMAADecodeDiagBilinearAccess(param_6);
    cdw_end = _603;
    coord.w = dot(cdw_end, vec2(0.5));
    return coord.zw;
}

vec2 SMAACalculateDiagWeights(vec2 texcoord, vec2 e, vec4 subsampleIndices)
{
    vec2 weights = vec2(0.0);
    vec4 d;
    if (e.x > 0.0)
    {
        vec2 param = texcoord;
        vec2 param_1 = vec2(-1.0, 1.0);
        vec2 _658 = SMAASearchDiag1(param, param_1);
        d = vec4(_658.x, d.y, _658.y, d.w);
        float dadd = float(cdw_end.y > 0.89999997615814208984375);
        d.x += dadd;
    }
    else
    {
        d = vec4(vec2(0.0).x, d.y, vec2(0.0).y, d.w);
    }
    vec2 param_2 = texcoord;
    vec2 param_3 = vec2(1.0, -1.0);
    vec2 _679 = SMAASearchDiag1(param_2, param_3);
    d = vec4(d.x, _679.x, d.z, _679.y);
    if ((d.x + d.y) > 2.0)
    {
        vec4 coords = (vec4((-d.x) + 0.25, d.x, d.y, (-d.y) - 0.25) * screenSizeInv.xyxy) + texcoord.xyxy;
        vec2 _720 = textureLod(edgesTex, coords.xy + (vec2(-1.0, 0.0) * screenSizeInv), 0.0).xy;
        vec4 c;
        c = vec4(_720.x, _720.y, c.z, c.w);
        vec2 _731 = textureLod(edgesTex, coords.zw + (vec2(1.0, 0.0) * screenSizeInv), 0.0).xy;
        c = vec4(c.x, c.y, _731.x, _731.y);
        vec4 param_4 = c;
        vec4 _736 = SMAADecodeDiagBilinearAccess(param_4);
        c = vec4(_736.y, _736.x, _736.w, _736.z);
        vec2 cc = (vec2(2.0) * c.xz) + c.yw;
        float a1condx = step(0.89999997615814208984375, d.z);
        float a1condy = step(0.89999997615814208984375, d.w);
        if (a1condx == 1.0)
        {
            cc.x = 0.0;
        }
        if (a1condy == 1.0)
        {
            cc.y = 0.0;
        }
        vec2 param_5 = d.xy;
        vec2 param_6 = cc;
        float param_7 = subsampleIndices.z;
        weights += SMAAAreaDiag(param_5, param_6, param_7);
    }
    vec2 param_8 = texcoord;
    vec2 param_9 = vec2(-1.0);
    vec2 _780 = SMAASearchDiag2(param_8, param_9);
    d = vec4(_780.x, d.y, _780.y, d.w);
    if (textureLod(edgesTex, texcoord + (vec2(1.0, 0.0) * screenSizeInv), 0.0).x > 0.0)
    {
        vec2 param_10 = texcoord;
        vec2 param_11 = vec2(1.0);
        vec2 _797 = SMAASearchDiag2(param_10, param_11);
        d = vec4(d.x, _797.x, d.z, _797.y);
        float dadd_1 = float(cdw_end.y > 0.89999997615814208984375);
        d.y += dadd_1;
    }
    else
    {
        d = vec4(d.x, vec2(0.0).x, d.z, vec2(0.0).y);
    }
    if ((d.x + d.y) > 2.0)
    {
        vec4 coords_1 = (vec4(-d.x, -d.x, d.y, d.y) * screenSizeInv.xyxy) + texcoord.xyxy;
        vec4 c_1;
        c_1.x = textureLod(edgesTex, coords_1.xy + (vec2(-1.0, 0.0) * screenSizeInv), 0.0).y;
        c_1.y = textureLod(edgesTex, coords_1.xy + (vec2(0.0, -1.0) * screenSizeInv), 0.0).x;
        vec2 _866 = textureLod(edgesTex, coords_1.zw + (vec2(1.0, 0.0) * screenSizeInv), 0.0).yx;
        c_1 = vec4(c_1.x, c_1.y, _866.x, _866.y);
        vec2 cc_1 = (vec2(2.0) * c_1.xz) + c_1.yw;
        float a1condx_1 = step(0.89999997615814208984375, d.z);
        float a1condy_1 = step(0.89999997615814208984375, d.w);
        if (a1condx_1 == 1.0)
        {
            cc_1.x = 0.0;
        }
        if (a1condy_1 == 1.0)
        {
            cc_1.y = 0.0;
        }
        vec2 param_12 = d.xy;
        vec2 param_13 = cc_1;
        float param_14 = subsampleIndices.w;
        weights += SMAAAreaDiag(param_12, param_13, param_14).yx;
    }
    return weights;
}

float SMAASearchLength(vec2 e, float offset)
{
    vec2 scale = vec2(33.0, -33.0);
    vec2 bias = vec2(66.0, 33.0) * vec2(offset, 1.0);
    scale += vec2(-1.0, 1.0);
    bias += vec2(0.5, -0.5);
    scale *= vec2(0.015625, 0.0625);
    bias *= vec2(0.015625, 0.0625);
    return textureLod(searchTex, (scale * e) + bias, 0.0).x;
}

float endLoopXLeft(vec2 texcoord, vec2 e)
{
    vec2 param = e;
    float param_1 = 0.0;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param, param_1)) + 3.25;
    return (screenSizeInv.x * offset) + texcoord.x;
}

float SMAASearchXLeft(inout vec2 texcoord, float end)
{
    vec2 e = vec2(0.0, 1.0);
    if (texcoord.x <= end)
    {
        vec2 param = texcoord;
        vec2 param_1 = e;
        return endLoopXLeft(param, param_1);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_2 = texcoord;
        vec2 param_3 = e;
        return endLoopXLeft(param_2, param_3);
    }
    if (e.x != 0.0)
    {
        vec2 param_4 = texcoord;
        vec2 param_5 = e;
        return endLoopXLeft(param_4, param_5);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_6 = texcoord;
        vec2 param_7 = e;
        return endLoopXLeft(param_6, param_7);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_8 = texcoord;
        vec2 param_9 = e;
        return endLoopXLeft(param_8, param_9);
    }
    if (e.x != 0.0)
    {
        vec2 param_10 = texcoord;
        vec2 param_11 = e;
        return endLoopXLeft(param_10, param_11);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_12 = texcoord;
        vec2 param_13 = e;
        return endLoopXLeft(param_12, param_13);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_14 = texcoord;
        vec2 param_15 = e;
        return endLoopXLeft(param_14, param_15);
    }
    if (e.x != 0.0)
    {
        vec2 param_16 = texcoord;
        vec2 param_17 = e;
        return endLoopXLeft(param_16, param_17);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_18 = texcoord;
        vec2 param_19 = e;
        return endLoopXLeft(param_18, param_19);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_20 = texcoord;
        vec2 param_21 = e;
        return endLoopXLeft(param_20, param_21);
    }
    if (e.x != 0.0)
    {
        vec2 param_22 = texcoord;
        vec2 param_23 = e;
        return endLoopXLeft(param_22, param_23);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_24 = texcoord;
        vec2 param_25 = e;
        return endLoopXLeft(param_24, param_25);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_26 = texcoord;
        vec2 param_27 = e;
        return endLoopXLeft(param_26, param_27);
    }
    if (e.x != 0.0)
    {
        vec2 param_28 = texcoord;
        vec2 param_29 = e;
        return endLoopXLeft(param_28, param_29);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_30 = texcoord;
        vec2 param_31 = e;
        return endLoopXLeft(param_30, param_31);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_32 = texcoord;
        vec2 param_33 = e;
        return endLoopXLeft(param_32, param_33);
    }
    if (e.x != 0.0)
    {
        vec2 param_34 = texcoord;
        vec2 param_35 = e;
        return endLoopXLeft(param_34, param_35);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_36 = texcoord;
        vec2 param_37 = e;
        return endLoopXLeft(param_36, param_37);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_38 = texcoord;
        vec2 param_39 = e;
        return endLoopXLeft(param_38, param_39);
    }
    if (e.x != 0.0)
    {
        vec2 param_40 = texcoord;
        vec2 param_41 = e;
        return endLoopXLeft(param_40, param_41);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    if (texcoord.x <= end)
    {
        vec2 param_42 = texcoord;
        vec2 param_43 = e;
        return endLoopXLeft(param_42, param_43);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_44 = texcoord;
        vec2 param_45 = e;
        return endLoopXLeft(param_44, param_45);
    }
    if (e.x != 0.0)
    {
        vec2 param_46 = texcoord;
        vec2 param_47 = e;
        return endLoopXLeft(param_46, param_47);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-2.0, -0.0) * screenSizeInv) + texcoord;
    vec2 param_48 = e;
    float param_49 = 0.0;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param_48, param_49)) + 3.25;
    return (screenSizeInv.x * offset) + texcoord.x;
}

float endLoopXRight(vec2 texcoord, vec2 e)
{
    vec2 param = e;
    float param_1 = 0.5;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param, param_1)) + 3.25;
    return ((-screenSizeInv.x) * offset) + texcoord.x;
}

float SMAASearchXRight(inout vec2 texcoord, float end)
{
    vec2 e = vec2(0.0, 1.0);
    if (texcoord.x >= end)
    {
        vec2 param = texcoord;
        vec2 param_1 = e;
        return endLoopXRight(param, param_1);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_2 = texcoord;
        vec2 param_3 = e;
        return endLoopXRight(param_2, param_3);
    }
    if (e.x != 0.0)
    {
        vec2 param_4 = texcoord;
        vec2 param_5 = e;
        return endLoopXRight(param_4, param_5);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_6 = texcoord;
        vec2 param_7 = e;
        return endLoopXRight(param_6, param_7);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_8 = texcoord;
        vec2 param_9 = e;
        return endLoopXRight(param_8, param_9);
    }
    if (e.x != 0.0)
    {
        vec2 param_10 = texcoord;
        vec2 param_11 = e;
        return endLoopXRight(param_10, param_11);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_12 = texcoord;
        vec2 param_13 = e;
        return endLoopXRight(param_12, param_13);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_14 = texcoord;
        vec2 param_15 = e;
        return endLoopXRight(param_14, param_15);
    }
    if (e.x != 0.0)
    {
        vec2 param_16 = texcoord;
        vec2 param_17 = e;
        return endLoopXRight(param_16, param_17);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_18 = texcoord;
        vec2 param_19 = e;
        return endLoopXRight(param_18, param_19);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_20 = texcoord;
        vec2 param_21 = e;
        return endLoopXRight(param_20, param_21);
    }
    if (e.x != 0.0)
    {
        vec2 param_22 = texcoord;
        vec2 param_23 = e;
        return endLoopXRight(param_22, param_23);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_24 = texcoord;
        vec2 param_25 = e;
        return endLoopXRight(param_24, param_25);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_26 = texcoord;
        vec2 param_27 = e;
        return endLoopXRight(param_26, param_27);
    }
    if (e.x != 0.0)
    {
        vec2 param_28 = texcoord;
        vec2 param_29 = e;
        return endLoopXRight(param_28, param_29);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_30 = texcoord;
        vec2 param_31 = e;
        return endLoopXRight(param_30, param_31);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_32 = texcoord;
        vec2 param_33 = e;
        return endLoopXRight(param_32, param_33);
    }
    if (e.x != 0.0)
    {
        vec2 param_34 = texcoord;
        vec2 param_35 = e;
        return endLoopXRight(param_34, param_35);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_36 = texcoord;
        vec2 param_37 = e;
        return endLoopXRight(param_36, param_37);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_38 = texcoord;
        vec2 param_39 = e;
        return endLoopXRight(param_38, param_39);
    }
    if (e.x != 0.0)
    {
        vec2 param_40 = texcoord;
        vec2 param_41 = e;
        return endLoopXRight(param_40, param_41);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    if (texcoord.x >= end)
    {
        vec2 param_42 = texcoord;
        vec2 param_43 = e;
        return endLoopXRight(param_42, param_43);
    }
    if (e.y <= 0.828100025653839111328125)
    {
        vec2 param_44 = texcoord;
        vec2 param_45 = e;
        return endLoopXRight(param_44, param_45);
    }
    if (e.x != 0.0)
    {
        vec2 param_46 = texcoord;
        vec2 param_47 = e;
        return endLoopXRight(param_46, param_47);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(2.0, 0.0) * screenSizeInv) + texcoord;
    vec2 param_48 = e;
    float param_49 = 0.5;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param_48, param_49)) + 3.25;
    return ((-screenSizeInv.x) * offset) + texcoord.x;
}

vec2 SMAAArea(vec2 dist, float e1, float e2, float offset)
{
    vec2 texcoord = (vec2(16.0) * floor((vec2(e1, e2) * 4.0) + vec2(0.5))) + dist;
    texcoord = (vec2(0.0062500000931322574615478515625, 0.001785714295692741870880126953125) * texcoord) + vec2(0.00312500004656612873077392578125, 0.0008928571478463709354400634765625);
    texcoord.y = (0.14285714924335479736328125 * offset) + texcoord.y;
    return textureLod(areaTex, texcoord, 0.0).xy;
}

vec2 SMAADetectHorizontalCornerPattern(inout vec2 weights, vec4 texcoord, vec2 d)
{
    vec2 leftRight = step(d, d.yx);
    vec2 rounding = leftRight * 0.75;
    rounding /= vec2(leftRight.x + leftRight.y);
    vec2 factor = vec2(1.0);
    factor.x -= (rounding.x * textureLod(edgesTex, texcoord.xy + (vec2(0.0, 1.0) * screenSizeInv), 0.0).x);
    factor.x -= (rounding.y * textureLod(edgesTex, texcoord.zw + (vec2(1.0) * screenSizeInv), 0.0).x);
    factor.y -= (rounding.x * textureLod(edgesTex, texcoord.xy + (vec2(0.0, -2.0) * screenSizeInv), 0.0).x);
    factor.y -= (rounding.y * textureLod(edgesTex, texcoord.zw + (vec2(1.0, -2.0) * screenSizeInv), 0.0).x);
    weights *= clamp(factor, vec2(0.0), vec2(1.0));
    return weights;
}

float endLoopYUp(vec2 texcoord, vec2 e)
{
    vec2 param = e.yx;
    float param_1 = 0.0;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param, param_1)) + 3.25;
    return (screenSizeInv.y * offset) + texcoord.y;
}

float SMAASearchYUp(inout vec2 texcoord, float end)
{
    vec2 e = vec2(1.0, 0.0);
    if (texcoord.y <= end)
    {
        vec2 param = texcoord;
        vec2 param_1 = e;
        return endLoopYUp(param, param_1);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_2 = texcoord;
        vec2 param_3 = e;
        return endLoopYUp(param_2, param_3);
    }
    if (e.y != 0.0)
    {
        vec2 param_4 = texcoord;
        vec2 param_5 = e;
        return endLoopYUp(param_4, param_5);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_6 = texcoord;
        vec2 param_7 = e;
        return endLoopYUp(param_6, param_7);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_8 = texcoord;
        vec2 param_9 = e;
        return endLoopYUp(param_8, param_9);
    }
    if (e.y != 0.0)
    {
        vec2 param_10 = texcoord;
        vec2 param_11 = e;
        return endLoopYUp(param_10, param_11);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_12 = texcoord;
        vec2 param_13 = e;
        return endLoopYUp(param_12, param_13);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_14 = texcoord;
        vec2 param_15 = e;
        return endLoopYUp(param_14, param_15);
    }
    if (e.y != 0.0)
    {
        vec2 param_16 = texcoord;
        vec2 param_17 = e;
        return endLoopYUp(param_16, param_17);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_18 = texcoord;
        vec2 param_19 = e;
        return endLoopYUp(param_18, param_19);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_20 = texcoord;
        vec2 param_21 = e;
        return endLoopYUp(param_20, param_21);
    }
    if (e.y != 0.0)
    {
        vec2 param_22 = texcoord;
        vec2 param_23 = e;
        return endLoopYUp(param_22, param_23);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_24 = texcoord;
        vec2 param_25 = e;
        return endLoopYUp(param_24, param_25);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_26 = texcoord;
        vec2 param_27 = e;
        return endLoopYUp(param_26, param_27);
    }
    if (e.y != 0.0)
    {
        vec2 param_28 = texcoord;
        vec2 param_29 = e;
        return endLoopYUp(param_28, param_29);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_30 = texcoord;
        vec2 param_31 = e;
        return endLoopYUp(param_30, param_31);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_32 = texcoord;
        vec2 param_33 = e;
        return endLoopYUp(param_32, param_33);
    }
    if (e.y != 0.0)
    {
        vec2 param_34 = texcoord;
        vec2 param_35 = e;
        return endLoopYUp(param_34, param_35);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_36 = texcoord;
        vec2 param_37 = e;
        return endLoopYUp(param_36, param_37);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_38 = texcoord;
        vec2 param_39 = e;
        return endLoopYUp(param_38, param_39);
    }
    if (e.y != 0.0)
    {
        vec2 param_40 = texcoord;
        vec2 param_41 = e;
        return endLoopYUp(param_40, param_41);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    if (texcoord.y <= end)
    {
        vec2 param_42 = texcoord;
        vec2 param_43 = e;
        return endLoopYUp(param_42, param_43);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_44 = texcoord;
        vec2 param_45 = e;
        return endLoopYUp(param_44, param_45);
    }
    if (e.y != 0.0)
    {
        vec2 param_46 = texcoord;
        vec2 param_47 = e;
        return endLoopYUp(param_46, param_47);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(-0.0, -2.0) * screenSizeInv) + texcoord;
    vec2 param_48 = e.yx;
    float param_49 = 0.0;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param_48, param_49)) + 3.25;
    return (screenSizeInv.y * offset) + texcoord.y;
}

float endLoopYDown(vec2 texcoord, vec2 e)
{
    vec2 param = e.yx;
    float param_1 = 0.5;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param, param_1)) + 3.25;
    return ((-screenSizeInv.y) * offset) + texcoord.y;
}

float SMAASearchYDown(inout vec2 texcoord, float end)
{
    vec2 e = vec2(1.0, 0.0);
    if (texcoord.y >= end)
    {
        vec2 param = texcoord;
        vec2 param_1 = e;
        return endLoopYDown(param, param_1);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_2 = texcoord;
        vec2 param_3 = e;
        return endLoopYDown(param_2, param_3);
    }
    if (e.y != 0.0)
    {
        vec2 param_4 = texcoord;
        vec2 param_5 = e;
        return endLoopYDown(param_4, param_5);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_6 = texcoord;
        vec2 param_7 = e;
        return endLoopYDown(param_6, param_7);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_8 = texcoord;
        vec2 param_9 = e;
        return endLoopYDown(param_8, param_9);
    }
    if (e.y != 0.0)
    {
        vec2 param_10 = texcoord;
        vec2 param_11 = e;
        return endLoopYDown(param_10, param_11);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_12 = texcoord;
        vec2 param_13 = e;
        return endLoopYDown(param_12, param_13);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_14 = texcoord;
        vec2 param_15 = e;
        return endLoopYDown(param_14, param_15);
    }
    if (e.y != 0.0)
    {
        vec2 param_16 = texcoord;
        vec2 param_17 = e;
        return endLoopYDown(param_16, param_17);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_18 = texcoord;
        vec2 param_19 = e;
        return endLoopYDown(param_18, param_19);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_20 = texcoord;
        vec2 param_21 = e;
        return endLoopYDown(param_20, param_21);
    }
    if (e.y != 0.0)
    {
        vec2 param_22 = texcoord;
        vec2 param_23 = e;
        return endLoopYDown(param_22, param_23);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_24 = texcoord;
        vec2 param_25 = e;
        return endLoopYDown(param_24, param_25);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_26 = texcoord;
        vec2 param_27 = e;
        return endLoopYDown(param_26, param_27);
    }
    if (e.y != 0.0)
    {
        vec2 param_28 = texcoord;
        vec2 param_29 = e;
        return endLoopYDown(param_28, param_29);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_30 = texcoord;
        vec2 param_31 = e;
        return endLoopYDown(param_30, param_31);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_32 = texcoord;
        vec2 param_33 = e;
        return endLoopYDown(param_32, param_33);
    }
    if (e.y != 0.0)
    {
        vec2 param_34 = texcoord;
        vec2 param_35 = e;
        return endLoopYDown(param_34, param_35);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_36 = texcoord;
        vec2 param_37 = e;
        return endLoopYDown(param_36, param_37);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_38 = texcoord;
        vec2 param_39 = e;
        return endLoopYDown(param_38, param_39);
    }
    if (e.y != 0.0)
    {
        vec2 param_40 = texcoord;
        vec2 param_41 = e;
        return endLoopYDown(param_40, param_41);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    if (texcoord.y >= end)
    {
        vec2 param_42 = texcoord;
        vec2 param_43 = e;
        return endLoopYDown(param_42, param_43);
    }
    if (e.x <= 0.828100025653839111328125)
    {
        vec2 param_44 = texcoord;
        vec2 param_45 = e;
        return endLoopYDown(param_44, param_45);
    }
    if (e.y != 0.0)
    {
        vec2 param_46 = texcoord;
        vec2 param_47 = e;
        return endLoopYDown(param_46, param_47);
    }
    e = textureLod(edgesTex, texcoord, 0.0).xy;
    texcoord = (vec2(0.0, 2.0) * screenSizeInv) + texcoord;
    vec2 param_48 = e.yx;
    float param_49 = 0.5;
    float offset = ((-2.007874011993408203125) * SMAASearchLength(param_48, param_49)) + 3.25;
    return ((-screenSizeInv.y) * offset) + texcoord.y;
}

vec2 SMAADetectVerticalCornerPattern(inout vec2 weights, vec4 texcoord, vec2 d)
{
    vec2 leftRight = step(d, d.yx);
    vec2 rounding = leftRight * 0.75;
    rounding /= vec2(leftRight.x + leftRight.y);
    vec2 factor = vec2(1.0);
    factor.x -= (rounding.x * textureLod(edgesTex, texcoord.xy + (vec2(1.0, 0.0) * screenSizeInv), 0.0).y);
    factor.x -= (rounding.y * textureLod(edgesTex, texcoord.zw + (vec2(1.0) * screenSizeInv), 0.0).y);
    factor.y -= (rounding.x * textureLod(edgesTex, texcoord.xy + (vec2(-2.0, 0.0) * screenSizeInv), 0.0).y);
    factor.y -= (rounding.y * textureLod(edgesTex, texcoord.zw + (vec2(-2.0, 1.0) * screenSizeInv), 0.0).y);
    weights *= clamp(factor, vec2(0.0), vec2(1.0));
    return weights;
}

vec4 SMAABlendingWeightCalculationPS(vec2 texcoord, vec2 pixcoord_1, vec4 subsampleIndices)
{
    vec4 weights = vec4(0.0);
    vec2 e = texture(edgesTex, texcoord).xy;
    if (e.y > 0.0)
    {
        vec2 param = texcoord;
        vec2 param_1 = e;
        vec4 param_2 = subsampleIndices;
        vec2 _2661 = SMAACalculateDiagWeights(param, param_1, param_2);
        weights = vec4(_2661.x, _2661.y, weights.z, weights.w);
        if (weights.x == (-weights.y))
        {
            vec2 param_3 = offset0.xy;
            float param_4 = offset2.x;
            float _2683 = SMAASearchXLeft(param_3, param_4);
            vec3 coords;
            coords.x = _2683;
            coords.y = offset1.y;
            vec2 d;
            d.x = coords.x;
            float e1 = textureLod(edgesTex, coords.xy, 0.0).x;
            vec2 param_5 = offset0.zw;
            float param_6 = offset2.y;
            float _2705 = SMAASearchXRight(param_5, param_6);
            coords.z = _2705;
            d.y = coords.z;
            d = abs(floor(((screenSize.xx * d) + (-pixcoord_1.xx)) + vec2(0.5)));
            vec2 sqrt_d = sqrt(d);
            float e2 = textureLod(edgesTex, coords.zy + (vec2(1.0, 0.0) * screenSizeInv), 0.0).x;
            vec2 param_7 = sqrt_d;
            float param_8 = e1;
            float param_9 = e2;
            float param_10 = subsampleIndices.y;
            vec2 _2744 = SMAAArea(param_7, param_8, param_9, param_10);
            weights = vec4(_2744.x, _2744.y, weights.z, weights.w);
            coords.y = texcoord.y;
            vec2 param_11 = weights.xy;
            vec4 param_12 = coords.xyzy;
            vec2 param_13 = d;
            vec2 _2758 = SMAADetectHorizontalCornerPattern(param_11, param_12, param_13);
            weights = vec4(_2758.x, _2758.y, weights.z, weights.w);
        }
        else
        {
            e.x = 0.0;
        }
    }
    if (e.x > 0.0)
    {
        vec2 param_14 = offset1.xy;
        float param_15 = offset2.z;
        float _2775 = SMAASearchYUp(param_14, param_15);
        vec3 coords_1;
        coords_1.y = _2775;
        coords_1.x = offset0.x;
        vec2 d_1;
        d_1.x = coords_1.y;
        float e1_1 = textureLod(edgesTex, coords_1.xy, 0.0).y;
        vec2 param_16 = offset1.zw;
        float param_17 = offset2.w;
        float _2796 = SMAASearchYDown(param_16, param_17);
        coords_1.z = _2796;
        d_1.y = coords_1.z;
        d_1 = abs(floor(((screenSize.yy * d_1) + (-pixcoord_1.yy)) + vec2(0.5)));
        vec2 sqrt_d_1 = sqrt(d_1);
        float e2_1 = textureLod(edgesTex, coords_1.xz + (vec2(0.0, 1.0) * screenSizeInv), 0.0).y;
        vec2 param_18 = sqrt_d_1;
        float param_19 = e1_1;
        float param_20 = e2_1;
        float param_21 = subsampleIndices.x;
        vec2 _2834 = SMAAArea(param_18, param_19, param_20, param_21);
        weights = vec4(weights.x, weights.y, _2834.x, _2834.y);
        coords_1.x = texcoord.x;
        vec2 param_22 = weights.zw;
        vec4 param_23 = coords_1.xyxz;
        vec2 param_24 = d_1;
        vec2 _2848 = SMAADetectVerticalCornerPattern(param_22, param_23, param_24);
        weights = vec4(weights.x, weights.y, _2848.x, _2848.y);
    }
    return weights;
}

void main()
{
    vec2 param = texCoord;
    vec2 param_1 = pixcoord;
    vec4 param_2 = vec4(0.0);
    vec4 _2864 = SMAABlendingWeightCalculationPS(param, param_1, param_2);
    fragColor = _2864;
}

