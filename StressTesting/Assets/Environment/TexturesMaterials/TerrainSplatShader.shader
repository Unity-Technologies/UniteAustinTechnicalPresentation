// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TerrainSplatShader"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseColor("BaseColor", 2D) = "white" {}
		_colorA("colorA", 2D) = "white" {}
		_colorB("colorB", 2D) = "white" {}
		_colorC("colorC", 2D) = "white" {}
		_colorD("colorD", 2D) = "white" {}
		_TintB("TintB", Color) = (1,1,1,0)
		_TintC("TintC", Color) = (1,1,1,0)
		_TintD("TintD", Color) = (1,1,1,0)
		_TintA("TintA", Color) = (1,1,1,0)
		_node_6937("node_6937", 2D) = "white" {}
		_node_3540_copy_copy("node_3540_copy_copy", Range( 0 , 1)) = 0
		_Bledn_B("Bledn_B", 2D) = "white" {}
		_node_3540("node_3540", Range( 0 , 1)) = 1
		_node_3540_copy_copy_copy("node_3540_copy_copy_copy", Range( 0 , 1)) = 0
		_node_3540_copy("node_3540_copy", Range( 0 , 1)) = 0
		_BlendStrength_B("BlendStrength_B", Float) = 3
		_BlendStrength_C("BlendStrength_C", Float) = 3
		_node_3ew_copy("node_3ew_copy", Range( 0 , 1)) = 1
		_node_3ew("node_3ew", Range( 0 , 1)) = 1
		_BlendStrength_D("BlendStrength_D", Float) = 3
		_node_3092("node_3092", Range( 0 , 1)) = 1
		_BaseNormal("BaseNormal", 2D) = "white" {}
		_NormalA("NormalA", 2D) = "white" {}
		_NormalC("NormalC", 2D) = "white" {}
		_NormalB("NormalB", 2D) = "white" {}
		_NormalD("NormalD", 2D) = "white" {}
		_NormalA_STR("NormalA_STR", Float) = 0
		_BaseNormal_STR("BaseNormal_STR", Float) = 0
		_NormalD_STR("NormalD_STR", Float) = 0
		_NormalC_STR("NormalC_STR", Float) = 0
		_NormalB_STR("NormalB_STR", Float) = 0
		_ColorTerrain("ColorTerrain", Color) = (1,1,1,0)
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Gloss("Gloss", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows exclude_path:forward 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _NormalA;
		uniform float4 _NormalA_ST;
		uniform float _NormalA_STR;
		uniform sampler2D _NormalB;
		uniform float4 _NormalB_ST;
		uniform float _NormalB_STR;
		uniform sampler2D _Bledn_B;
		uniform float4 _Bledn_B_ST;
		uniform float _BlendStrength_B;
		uniform sampler2D _NormalC;
		uniform float4 _NormalC_ST;
		uniform float _NormalC_STR;
		uniform float _BlendStrength_C;
		uniform sampler2D _NormalD;
		uniform float4 _NormalD_ST;
		uniform float _NormalD_STR;
		uniform float _BlendStrength_D;
		uniform sampler2D _BaseNormal;
		uniform float4 _BaseNormal_ST;
		uniform float _BaseNormal_STR;
		uniform sampler2D _BaseColor;
		uniform float4 _BaseColor_ST;
		uniform float4 _TintA;
		uniform sampler2D _colorA;
		uniform float4 _colorA_ST;
		uniform sampler2D _node_6937;
		uniform float4 _node_6937_ST;
		uniform float _node_3540_copy_copy_copy;
		uniform float4 _TintB;
		uniform sampler2D _colorB;
		uniform float4 _colorB_ST;
		uniform float _node_3540_copy_copy;
		uniform float _node_3ew_copy;
		uniform float4 _TintC;
		uniform sampler2D _colorC;
		uniform float4 _colorC_ST;
		uniform float _node_3540_copy;
		uniform float _node_3ew;
		uniform float4 _TintD;
		uniform sampler2D _colorD;
		uniform float4 _colorD_ST;
		uniform float _node_3540;
		uniform float _node_3092;
		uniform float4 _ColorTerrain;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float _Gloss;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float3 appendResult158 = (float3(0.0 , 0.0 , 1.0));
			float2 uv_NormalA = i.uv_texcoord * _NormalA_ST.xy + _NormalA_ST.zw;
			float3 appendResult87 = (float3(_NormalA_STR , _NormalA_STR , 1.0));
			float3 lerpResult128 = lerp( appendResult158 , ( UnpackNormal( tex2D( _NormalA, uv_NormalA ) ) * appendResult87 ) , i.vertexColor.r);
			float2 uv_NormalB = i.uv_texcoord * _NormalB_ST.xy + _NormalB_ST.zw;
			float3 appendResult98 = (float3(_NormalB_STR , _NormalB_STR , 1.0));
			float2 uv_Bledn_B = i.uv_texcoord * _Bledn_B_ST.xy + _Bledn_B_ST.zw;
			float4 tex2DNode43 = tex2D( _Bledn_B, uv_Bledn_B );
			float4 temp_output_124_0 = ( tex2DNode43 + ( 1.0 - tex2DNode43 ) );
			float4 clampResult126 = clamp( ( ( i.vertexColor.g * tex2DNode43 ) * temp_output_124_0 * ( temp_output_124_0 * _BlendStrength_B ) ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) );
			float3 lerpResult130 = lerp( lerpResult128 , ( UnpackNormal( tex2D( _NormalB, uv_NormalB ) ) * appendResult98 ) , clampResult126.r);
			float2 uv_NormalC = i.uv_texcoord * _NormalC_ST.xy + _NormalC_ST.zw;
			float3 appendResult102 = (float3(_NormalC_STR , _NormalC_STR , 1.0));
			float4 temp_output_136_0 = ( tex2DNode43 + ( 1.0 - tex2DNode43 ) );
			float4 clampResult133 = clamp( ( ( i.vertexColor.b * tex2DNode43 ) * temp_output_136_0 * ( temp_output_136_0 * _BlendStrength_C ) ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) );
			float3 lerpResult131 = lerp( lerpResult130 , ( UnpackNormal( tex2D( _NormalC, uv_NormalC ) ) * appendResult102 ) , clampResult133.r);
			float2 uv_NormalD = i.uv_texcoord * _NormalD_ST.xy + _NormalD_ST.zw;
			float3 appendResult106 = (float3(_NormalD_STR , _NormalD_STR , 1.0));
			float4 temp_output_142_0 = ( tex2DNode43 + ( 1.0 - tex2DNode43 ) );
			float4 clampResult139 = clamp( ( ( ( i.vertexColor.a * 1.0 ) * tex2DNode43 ) * temp_output_142_0 * ( temp_output_142_0 * _BlendStrength_D ) ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) );
			float3 lerpResult132 = lerp( lerpResult131 , ( UnpackNormal( tex2D( _NormalD, uv_NormalD ) ) * appendResult106 ) , clampResult139.r);
			float2 uv_BaseNormal = i.uv_texcoord * _BaseNormal_ST.xy + _BaseNormal_ST.zw;
			float3 appendResult153 = (float3(_BaseNormal_STR , _BaseNormal_STR , 1.0));
			float3 normalizeResult147 = normalize( BlendNormals( lerpResult132 , ( UnpackNormal( tex2D( _BaseNormal, uv_BaseNormal ) ) * appendResult153 ) ) );
			o.Normal = normalizeResult147;
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float2 uv_colorA = i.uv_texcoord * _colorA_ST.xy + _colorA_ST.zw;
			float2 uv_node_6937 = i.uv_texcoord * _node_6937_ST.xy + _node_6937_ST.zw;
			float4 tex2DNode31 = tex2D( _node_6937, uv_node_6937 );
			float4 lerpResult30 = lerp( ( _TintA * tex2D( _colorA, uv_colorA ) ) , tex2DNode31 , _node_3540_copy_copy_copy);
			float4 lerpResult20 = lerp( tex2D( _BaseColor, uv_BaseColor ) , lerpResult30 , i.vertexColor.r);
			float2 uv_colorB = i.uv_texcoord * _colorB_ST.xy + _colorB_ST.zw;
			float4 lerpResult32 = lerp( ( _TintB * tex2D( _colorB, uv_colorB ) ) , tex2DNode31 , _node_3540_copy_copy);
			float4 temp_output_45_0 = ( tex2DNode43 + ( 1.0 - tex2DNode43 ) );
			float4 clampResult50 = clamp( ( ( i.vertexColor.g * tex2DNode43 ) * temp_output_45_0 * ( temp_output_45_0 * _BlendStrength_B ) ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) );
			float4 lerpResult69 = lerp( lerpResult20 , clampResult50 , _node_3ew_copy);
			float4 lerpResult70 = lerp( lerpResult20 , lerpResult32 , lerpResult69.r);
			float2 uv_colorC = i.uv_texcoord * _colorC_ST.xy + _colorC_ST.zw;
			float4 lerpResult33 = lerp( ( _TintC * tex2D( _colorC, uv_colorC ) ) , tex2DNode31 , _node_3540_copy);
			float4 temp_output_55_0 = ( tex2DNode43 + ( 1.0 - tex2DNode43 ) );
			float4 clampResult58 = clamp( ( ( i.vertexColor.b * tex2DNode43 ) * temp_output_55_0 * ( temp_output_55_0 * _BlendStrength_C ) ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) );
			float4 lerpResult72 = lerp( lerpResult70 , clampResult58 , _node_3ew);
			float4 lerpResult71 = lerp( lerpResult70 , lerpResult33 , lerpResult72.r);
			float2 uv_colorD = i.uv_texcoord * _colorD_ST.xy + _colorD_ST.zw;
			float4 lerpResult34 = lerp( ( _TintD * tex2D( _colorD, uv_colorD ) ) , tex2DNode31 , _node_3540);
			float4 temp_output_61_0 = ( tex2DNode43 + ( 1.0 - tex2DNode43 ) );
			float4 clampResult64 = clamp( ( ( ( i.vertexColor.a * 1.0 ) * tex2DNode43 ) * temp_output_61_0 * ( temp_output_61_0 * _BlendStrength_D ) ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) );
			float4 lerpResult74 = lerp( lerpResult71 , clampResult64 , _node_3092);
			float4 lerpResult73 = lerp( lerpResult71 , lerpResult34 , lerpResult74.r);
			o.Albedo = ( lerpResult73 * _ColorTerrain ).rgb;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Smoothness = ( tex2D( _TextureSample1, uv_TextureSample1 ) * _Gloss ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13101
4790;-282;1906;1004;-779.4311;-211.4354;1;True;True
Node;AmplifyShaderEditor.SamplerNode;43;-4101.618,2546.25;Float;True;Property;_Bledn_B;Bledn_B;11;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;46;-3446.036,-727.3851;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;75;-3157.207,1592.687;Float;False;Property;_BlendStrength_B;BlendStrength_B;15;0;3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;54;-5302.865,-330.0259;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-3444.224,-875.5511;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;14;-4734.661,-950.8;Float;True;Property;_colorA;colorA;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;17;-4694.379,-1163.72;Float;False;Property;_TintA;TintA;8;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;59;-3456.602,-261.0304;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-4385.004,-1052.22;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-3280.929,-847.8815;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;39;-4388.146,-847.7015;Float;False;Property;_node_3540_copy_copy_copy;node_3540_copy_copy_copy;13;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-3454.83,-1002.365;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;31;-4160.044,-165.1275;Float;True;Property;_node_6937;node_6937;9;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;122;-4010.715,4040.279;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;22;-4635.693,-547.7692;Float;False;Property;_TintB;TintB;5;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-3451.91,-368.7167;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-3288.929,-965.8815;Float;False;3;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;30;-3910.782,-1046.268;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;4;-4720.333,-1484.059;Float;True;Property;_BaseColor;BaseColor;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;76;-3153.784,1753.605;Float;False;Property;_BlendStrength_C;BlendStrength_C;16;0;3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;15;-4679.276,-346.3416;Float;True;Property;_colorB;colorB;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;129;-5773,4180.847;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;124;-4006.023,3932.592;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;91;-5062.698,3674.604;Float;False;Constant;_Float1;Float 1;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;138;-3762.973,4652.295;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;92;-5058.698,3549.604;Float;False;Property;_NormalA_STR;NormalA_STR;26;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-3288.615,-341.047;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;40;-4356.282,-277.8643;Float;False;Property;_node_3540_copy_copy;node_3540_copy_copy;10;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;50;-3126.929,-960.8815;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;1.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-4326.319,-436.2691;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;156;-5367.532,2909.277;Float;False;Constant;_Float10;Float 10;28;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;68;-3788.336,363.3922;Float;False;Constant;_Float0;Float 0;7;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;20;-3635.395,-1291.667;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-3448.359,-461.1492;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;80;-2744.803,1828.74;Float;False;Property;_node_3ew_copy;node_3ew_copy;17;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;65;-3397.389,426.7828;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;157;-5371.532,3034.277;Float;False;Constant;_Float11;Float 11;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-3842.728,3960.262;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.OneMinusNode;144;-3706.185,5323.741;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;99;-5039.119,4295.067;Float;False;Constant;_Float3;Float 3;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;100;-5037.119,4169.067;Float;False;Property;_NormalB_STR;NormalB_STR;30;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;82;-5015.642,3259.991;Float;True;Property;_NormalA;NormalA;22;0;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;146;-4267.507,5316.986;Float;False;Constant;_Float4;Float 4;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;87;-4847.698,3501.604;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-4016.629,3805.778;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;136;-3758.281,4544.608;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-3296.615,-459.0471;Float;False;3;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-3594.986,4572.278;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;24;-4676.928,18.83099;Float;False;Property;_TintC;TintC;6;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-3694.699,232.3145;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;32;-3716.6,-589.5729;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;103;-5077.197,4874.034;Float;False;Constant;_Float5;Float 5;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;69;-3104.334,-714.4091;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;21;-4719.276,220.4939;Float;True;Property;_colorC;colorC;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-3397.259,312.2538;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;142;-3701.493,5216.054;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.DynamicAppendNode;98;-4824.119,4122.07;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-4165.898,5153.939;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;77;-3153.278,1848.123;Float;False;Property;_BlendStrength_D;BlendStrength_D;19;0;3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;104;-5073.197,4749.034;Float;False;Property;_NormalC_STR;NormalC_STR;29;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-4647.698,3318.604;Float;False;2;2;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-3768.887,4417.794;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-3850.728,3842.262;Float;False;3;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;83;-5014.002,3848.563;Float;True;Property;_NormalB;NormalB;24;0;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;158;-5156.532,2861.277;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-3233.964,339.9235;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ClampOpNode;58;-3134.615,-454.0471;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;1.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;79;-2733.602,1737.243;Float;False;Property;_node_3ew;node_3ew;18;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-3393.708,219.8213;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-4624.119,3939.07;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;70;-2679.983,-668.0132;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-4367.554,130.3312;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;41;-4330.519,294.5159;Float;False;Property;_node_3540_copy;node_3540_copy;14;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;128;-4163.276,3182.779;Float;False;3;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-3538.198,5243.724;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;107;-5103.805,5509.327;Float;False;Constant;_Float7;Float 7;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-3712.099,5089.24;Float;False;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;108;-5099.805,5384.327;Float;False;Property;_NormalD_STR;NormalD_STR;28;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;102;-4862.197,4701.037;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;85;-5013.213,4439.511;Float;True;Property;_NormalC;NormalC;23;0;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;-3602.986,4454.278;Float;False;3;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ClampOpNode;126;-3688.728,3847.262;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;1.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;72;-2729.386,-313.4054;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;33;-3130.913,-118.2892;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;26;-4698.9,852.6531;Float;True;Property;_colorD;colorD;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;28;-4656.552,650.9904;Float;False;Property;_TintD;TintD;7;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-3241.964,221.9234;Float;False;3;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;84;-5013.386,5049.316;Float;True;Property;_NormalD;NormalD;25;0;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-4662.197,4518.037;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.DynamicAppendNode;106;-4888.805,5336.33;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;130;-3198.872,3694.667;Float;False;3;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-3546.198,5125.724;Float;False;3;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ClampOpNode;133;-3440.986,4459.278;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;1.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;152;-4816.723,3148.673;Float;False;Constant;_Float9;Float 9;26;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;151;-4812.723,3023.673;Float;False;Property;_BaseNormal_STR;BaseNormal_STR;27;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-4347.178,762.4905;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;42;-4271.343,922.7582;Float;False;Property;_node_3540;node_3540;12;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;78;-2733.602,1636.026;Float;False;Property;_node_3092;node_3092;20;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;153;-4601.723,2975.673;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.ClampOpNode;64;-3079.964,226.9234;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;1.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;81;-4738.568,2734.6;Float;True;Property;_BaseNormal;BaseNormal;21;0;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;139;-3384.198,5130.724;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;1.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-4688.805,5153.33;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;131;-2642.671,4119.235;Float;False;3;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;71;-2303.66,-250.7837;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;132;-2284.913,4307.896;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;74;-2282.032,217.7527;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;34;-2604.833,-28.45665;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-4401.723,2792.673;Float;False;2;2;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;73;-1909.633,-150.8474;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.BlendNormalsNode;155;-1735.414,3530.651;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;165;1563.431,985.4354;Float;False;Property;_Gloss;Gloss;33;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;163;1374.938,760.966;Float;True;Property;_TextureSample1;Texture Sample 1;32;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;162;20.44946,586.9734;Float;False;Property;_ColorTerrain;ColorTerrain;31;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;1801.431,816.4354;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;318.1749,473.3356;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;166;1703.431,727.4354;Float;False;Property;_Metallic;Metallic;34;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.NormalizeNode;147;1670.026,645.741;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2126.313,564.2645;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;TerrainSplatShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;DeferredOnly;True;True;True;True;True;True;True;True;False;False;False;False;False;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;46;0;43;0
WireConnection;45;0;43;0
WireConnection;45;1;46;0
WireConnection;59;0;43;0
WireConnection;19;0;17;0
WireConnection;19;1;14;0
WireConnection;48;0;45;0
WireConnection;48;1;75;0
WireConnection;44;0;54;2
WireConnection;44;1;43;0
WireConnection;122;0;43;0
WireConnection;55;0;43;0
WireConnection;55;1;59;0
WireConnection;47;0;44;0
WireConnection;47;1;45;0
WireConnection;47;2;48;0
WireConnection;30;0;19;0
WireConnection;30;1;31;0
WireConnection;30;2;39;0
WireConnection;124;0;43;0
WireConnection;124;1;122;0
WireConnection;138;0;43;0
WireConnection;60;0;55;0
WireConnection;60;1;76;0
WireConnection;50;0;47;0
WireConnection;23;0;22;0
WireConnection;23;1;15;0
WireConnection;20;0;4;0
WireConnection;20;1;30;0
WireConnection;20;2;54;1
WireConnection;56;0;54;3
WireConnection;56;1;43;0
WireConnection;65;0;43;0
WireConnection;123;0;124;0
WireConnection;123;1;75;0
WireConnection;144;0;43;0
WireConnection;87;0;92;0
WireConnection;87;1;92;0
WireConnection;87;2;91;0
WireConnection;127;0;129;2
WireConnection;127;1;43;0
WireConnection;136;0;43;0
WireConnection;136;1;138;0
WireConnection;57;0;56;0
WireConnection;57;1;55;0
WireConnection;57;2;60;0
WireConnection;137;0;136;0
WireConnection;137;1;76;0
WireConnection;67;0;54;4
WireConnection;67;1;68;0
WireConnection;32;0;23;0
WireConnection;32;1;31;0
WireConnection;32;2;40;0
WireConnection;69;0;20;0
WireConnection;69;1;50;0
WireConnection;69;2;80;0
WireConnection;61;0;43;0
WireConnection;61;1;65;0
WireConnection;142;0;43;0
WireConnection;142;1;144;0
WireConnection;98;0;100;0
WireConnection;98;1;100;0
WireConnection;98;2;99;0
WireConnection;145;0;129;4
WireConnection;145;1;146;0
WireConnection;88;0;82;0
WireConnection;88;1;87;0
WireConnection;134;0;129;3
WireConnection;134;1;43;0
WireConnection;125;0;127;0
WireConnection;125;1;124;0
WireConnection;125;2;123;0
WireConnection;158;0;156;0
WireConnection;158;1;156;0
WireConnection;158;2;157;0
WireConnection;66;0;61;0
WireConnection;66;1;77;0
WireConnection;58;0;57;0
WireConnection;62;0;67;0
WireConnection;62;1;43;0
WireConnection;101;0;83;0
WireConnection;101;1;98;0
WireConnection;70;0;20;0
WireConnection;70;1;32;0
WireConnection;70;2;69;0
WireConnection;25;0;24;0
WireConnection;25;1;21;0
WireConnection;128;0;158;0
WireConnection;128;1;88;0
WireConnection;128;2;129;1
WireConnection;143;0;142;0
WireConnection;143;1;77;0
WireConnection;140;0;145;0
WireConnection;140;1;43;0
WireConnection;102;0;104;0
WireConnection;102;1;104;0
WireConnection;102;2;103;0
WireConnection;135;0;134;0
WireConnection;135;1;136;0
WireConnection;135;2;137;0
WireConnection;126;0;125;0
WireConnection;72;0;70;0
WireConnection;72;1;58;0
WireConnection;72;2;79;0
WireConnection;33;0;25;0
WireConnection;33;1;31;0
WireConnection;33;2;41;0
WireConnection;63;0;62;0
WireConnection;63;1;61;0
WireConnection;63;2;66;0
WireConnection;105;0;85;0
WireConnection;105;1;102;0
WireConnection;106;0;108;0
WireConnection;106;1;108;0
WireConnection;106;2;107;0
WireConnection;130;0;128;0
WireConnection;130;1;101;0
WireConnection;130;2;126;0
WireConnection;141;0;140;0
WireConnection;141;1;142;0
WireConnection;141;2;143;0
WireConnection;133;0;135;0
WireConnection;27;0;28;0
WireConnection;27;1;26;0
WireConnection;153;0;151;0
WireConnection;153;1;151;0
WireConnection;153;2;152;0
WireConnection;64;0;63;0
WireConnection;139;0;141;0
WireConnection;109;0;84;0
WireConnection;109;1;106;0
WireConnection;131;0;130;0
WireConnection;131;1;105;0
WireConnection;131;2;133;0
WireConnection;71;0;70;0
WireConnection;71;1;33;0
WireConnection;71;2;72;0
WireConnection;132;0;131;0
WireConnection;132;1;109;0
WireConnection;132;2;139;0
WireConnection;74;0;71;0
WireConnection;74;1;64;0
WireConnection;74;2;78;0
WireConnection;34;0;27;0
WireConnection;34;1;31;0
WireConnection;34;2;42;0
WireConnection;154;0;81;0
WireConnection;154;1;153;0
WireConnection;73;0;71;0
WireConnection;73;1;34;0
WireConnection;73;2;74;0
WireConnection;155;0;132;0
WireConnection;155;1;154;0
WireConnection;164;0;163;0
WireConnection;164;1;165;0
WireConnection;159;0;73;0
WireConnection;159;1;162;0
WireConnection;147;0;155;0
WireConnection;0;0;159;0
WireConnection;0;1;147;0
WireConnection;0;4;164;0
ASEEND*/
//CHKSM=2A14B55E247FBB6E46025FCBEB4B05850598AD04