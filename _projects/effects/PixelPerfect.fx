// from: https://www.shadertoy.com/view/MlB3D3
sampler s0;
float2 size;

float4 PixelShaderFunction(float2 coords: TEXCOORD0) : COLOR0
{
    float2 pixel = float2(1.0, 1.0) / size;
    float2 uv = coords - (pixel * float2(0.5, 0.5));
    float2 uv_pixels = uv * size;
    float2 delta_pixel = frac(uv_pixels) - float2(0.5, 0.5);
    float2 ddxy = fwidth(uv_pixels);

    return tex2D(s0, uv + (clamp(delta_pixel / ddxy, 0.0, 1.0) - delta_pixel) * pixel);
}

technique Technique1
{
    pass Pass1
    {
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}
