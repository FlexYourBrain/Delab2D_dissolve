#version 140

in vec2 var_texcoord0;
in vec2 var_texcoord1;
out vec4 color_out;

uniform sampler2D texture_sampler;
uniform fs_uniforms
{
    vec4 diss;
};


void main()
{
    vec2 uv0 = var_texcoord0;
    vec2 uv1 = var_texcoord1;

    vec4 tex = texture(texture_sampler, uv0.xy);
    vec4 tex1 = texture(texture_sampler, uv1.xy);

    float noise = step(diss.x, tex1.r);
    float alpha = (tex.a * noise);
    float cadjust = (tex.r, tex.g, tex.b) / 6.0;
    vec3 emit = vec3(1.1, 1.1, 1.1) * noise;

    vec4 final = vec4((tex.rgb - cadjust) * emit * tex.a, alpha);

    color_out = final;
}