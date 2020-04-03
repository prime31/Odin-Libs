sampler s0;

float Attenuation; // 800.0
float LinesFactor; // 0.04


void MainVS(inout float4 position: SV_Position, inout float4 color: COLOR0, inout float2 texCoord: TEXCOORD0)
{
	position = position;
}


float4 MainPS(float2 texCoord:TEXCOORD0, in float2 screenPos:VPOS) : COLOR0
{
	float4 color = tex2D(s0, texCoord);
	float scanline = sin(texCoord.y * LinesFactor) * Attenuation;
	color.rgb -= scanline;

	return color;
}



technique Scanlines
{
	pass P0
	{
		VertexShader = compile vs_2_0 MainVS();
		PixelShader = compile ps_3_0 MainPS();
	}
};
