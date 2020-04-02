
struct VertexShaderOutput
{
	float4 Position : POSITION;
	float4 Color : COLOR0;
};


VertexShaderOutput spriteVert(float4 position: POSITION0, float4 color: COLOR0)
{
	VertexShaderOutput output;
    output.Position = position;
	output.Color = color;

	return output;
}


float4 mainPixel( VertexShaderOutput input ) : COLOR
{
	return input.Color;
}


technique SpriteBlink
{
	pass P0
	{
		VertexShader = compile vs_2_0 spriteVert();
		PixelShader = compile ps_3_0 mainPixel();
	}
};
