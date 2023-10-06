//---  Dissolve Shader (wip) by Agustin R  ---//
varying mediump vec2 var_texcoord0;
varying mediump vec2 var_texcoord1;

uniform lowp sampler2D texture_sampler;
uniform mediump vec4 diss;

void main()
{
    // https://forum.defold.com/t/delab-2d-dissolve-fx-shader/71011
    vec2 uv0 = var_texcoord0;
    vec2 uv1 = var_texcoord1;

    vec4 tex = texture2D(texture_sampler, uv0.xy);
    vec4 tex1 = texture2D(texture_sampler, uv1.xy);

    float noise = step(diss.x, tex1.r);
    // float noise2 = step(diss.x-0.5,tex1.r);
    float alpha = (tex.a * noise);
    float cadjust = (tex.r, tex.g, tex.b) / 6.0;
    vec3 emit = vec3(1.1, 1.1, 1.1) * noise;

    // vec4 final = vec4(tex1.rgb,alpha);
    vec4 final = vec4((tex.rgb - cadjust) * emit * tex.a, alpha);

    gl_FragColor = final;

}