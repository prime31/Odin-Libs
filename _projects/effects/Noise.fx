sampler s0;

float noise; // 1.0

float rand( float2 co )
{
    return frac( sin( dot( co.xy, float2( 12.9898, 78.233 ) ) ) * 43758.5453 );
}


struct VertexShaderOutput
{
	float4 position : POSITION;
	float4 color : COLOR0;
	float2 texCoord : TEXCOORD0;
};

VertexShaderOutput mainVS(float4 position: POSITION0, float4 color: COLOR0, float2 texCoord: TEXCOORD0)
{
	VertexShaderOutput output;
    output.position = position;
	output.color = color;
	output.texCoord = texCoord;

	return output;
}

float4 PixelShaderFunction( float2 coords:TEXCOORD0, in float2 screenPos:VPOS ) : COLOR0
{
    float4 color = tex2D( s0, coords );

    float diff = ( rand( coords ) - 0.5 ) * noise;

    color.r += diff;
    color.g += diff;
    color.b += diff;

    return color;
}


technique Technique1
{
    pass Pass1
    {
        VertexShader = compile vs_2_0 mainVS();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}