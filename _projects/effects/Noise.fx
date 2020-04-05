sampler s0;

float Noise; // 1.0
float3x2 TransformMatrix;


float rand(float2 co)
{
	return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}


void MainVS(inout float4 position: SV_Position, inout float4 color: COLOR0, inout float2 texCoord: TEXCOORD0)
{
	position = float4(mul(position.xy, TransformMatrix), 0, 1);
}

float4 PixelShaderFunction(float2 coords:TEXCOORD0, in float2 screenPos:VPOS) : COLOR0
{
	float4 color = tex2D(s0, coords);

	float diff = (rand(coords) - 0.5) * Noise;

	color.r += diff;
	color.g += diff;
	color.b += diff;

	return color;
}


technique Technique1
{
	pass Pass1
	{
		VertexShader = compile vs_2_0 MainVS();
		PixelShader = compile ps_3_0 PixelShaderFunction();
	}
}
