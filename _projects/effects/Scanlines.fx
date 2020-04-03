sampler s0;

float _attenuation; // 800.0
float _linesFactor; // 0.04


struct VertexShaderOutput
{
	float4 position : POSITION;
	float4 color : COLOR0;
	float2 texCoord : TEXCOORD0;
};


VertexShaderOutput MainVS(float4 position: POSITION0, float4 color: COLOR0, float2 texCoord: TEXCOORD0)
{
	VertexShaderOutput output;
    output.position = position;
	output.color = color;
	output.texCoord = texCoord;

	return output;
}


float4 MainPS(float2 texCoord:TEXCOORD0, in float2 screenPos:VPOS) : COLOR0
{
	float4 color = tex2D( s0, texCoord );
	float scanline = sin( texCoord.y * _linesFactor ) * _attenuation;
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
