

void SpriteVert(inout float4 position: SV_Position, inout float4 color: COLOR0, inout float2 texCoord: TEXCOORD0)
{
	position = position;
}


float4 MainPixel(float4 color: COLOR0, float2 texCoord: TEXCOORD0) : SV_Target0
{
	return color;
}


technique SpriteBlink
{
	pass P0
	{
		VertexShader = compile vs_2_0 SpriteVert();
		PixelShader = compile ps_3_0 MainPixel();
	}
};
