sampler s0;
float3x2 TransformMatrix;

void Vert(inout float4 position: SV_Position, inout float4 color: COLOR0, inout float2 texCoord: TEXCOORD0)
{
	position = float4(mul(position.xy, TransformMatrix), 0, 1);
}


float4 Pixel(float4 color: COLOR0, float2 texCoord: TEXCOORD0) : SV_Target0
{
	float4 outColor = tex2D(s0, texCoord) * color;
	outColor.rgb *= outColor.a;
	return outColor;
}


technique Render
{
	pass Pass1
	{
		VertexShader = compile vs_2_0 Vert();
		PixelShader = compile ps_2_0 Pixel();
	}
};
