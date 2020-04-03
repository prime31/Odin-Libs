sampler s0; // from SpriteBatch

float LineSize; // width of the line in pixels
float4 LineColor;


float4 HorizontalLinesPS(float2 texCoord:TEXCOORD0, in float2 screenPos:VPOS) : COLOR0
{
	// we only need the alpha value of the original sprite
	float4 alpha = tex2D(s0, texCoord).a;

	// floor the screenPosition / lineSize. This gives us blocks with height lineSize. We mod that by 2 to take only the even blocks
	float flooredAlternate = floor(screenPos.y / LineSize) % 2.0;

	// lerp transparent to lineColor. This will always be either transparent or lineColor since flooredAlternate will be 0 or 1.
	float4 finalColor = lerp(float4(0, 0, 0, 0), LineColor, flooredAlternate);

	return finalColor *= alpha;
}


float4 VerticalLinesPS(float2 texCoord:TEXCOORD0, in float2 screenPos:VPOS) : COLOR0
{
	float4 alpha = tex2D(s0, texCoord).a;
	float flooredAlternate = floor(screenPos.x / LineSize) % 2.0;
	float4 finalColor = lerp(float4(0, 0, 0, 0), LineColor, flooredAlternate);

	return finalColor *= alpha;
}



technique VerticalLines
{
	pass Pass1
	{
		PixelShader = compile ps_3_0 VerticalLinesPS();
	}
}

technique HorizontalLines
{
	pass Pass1
	{
		PixelShader = compile ps_3_0 HorizontalLinesPS();
	}
}
