sampler s0;

float angle; // 0.5
float scale; // 0.5


void Vert(inout float4 position: SV_Position, inout float4 color: COLOR0, inout float2 texCoord: TEXCOORD0)
{
	//position = float4(mul(position.xy, MatrixTransform), 0, 0);
	position = position;
}

float pattern(float angle, float2 uv, float scale, float2 screenPos)
{
	 float s = sin(angle);
	 float c = cos(angle);
	 float2 tex = uv * screenPos;
	 float2 pt = float2(c * tex.x - s * tex.y, s * tex.x + c * tex.y) * scale;
	 return (sin(pt.x) * sin(pt.y)) * 4.0;
}


float4 Pixel(float2 coords:TEXCOORD0, in float2 screenPos:VPOS) : COLOR0
{
	float4 color = tex2D(s0, coords);
	float average = (color.r + color.g + color.b) / 3.0;
	float val = average * 10.0 - 5.0 + pattern(angle, coords, scale, screenPos);
	return float4(val, val, val, color.a);
}


technique Technique1
{
	pass Pass1
	{
		VertexShader = compile vs_2_0 Vert();
		PixelShader = compile ps_3_0 Pixel();
	}
}
