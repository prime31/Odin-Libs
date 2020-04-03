sampler s0;


void SpriteVert(inout float4 position: SV_Position, inout float4 color: COLOR0, inout float2 texCoord: TEXCOORD0)
{
	position = position;
}


float4 SpritePixel(float4 color: COLOR0, float2 texCoord: TEXCOORD0) : SV_Target0
{
	float4 outColor = tex2D(s0, texCoord) * color;
	outColor.rgb *= outColor.a;
	return outColor;
}


technique SpriteDrawing
{
	pass P0
	{
		VertexShader = compile vs_2_0 SpriteVert();
		PixelShader = compile ps_2_0 SpritePixel();
	}
};
