// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AssetsShader"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MainTex("_MainTex", 2D) = "white" {}
		_node_8994("node_8994", 2D) = "white" {}
		_Metalilc("Metalilc", Range( 0 , 1)) = 0
		_RoughSlider("RoughSlider", Range( 0 , 1)) = 0
		_Color("Color", Color) = (1,1,1,0)
		_BumpMap("_BumpMap", 2D) = "white" {}
		_node_8405("node_8405", 2D) = "white" {}
		_node_3041("node_3041", Color) = (0,0,0,0)
		_node_2821("node_2821", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;
		uniform sampler2D _node_8405;
		uniform float4 _node_8405_ST;
		uniform float4 _node_3041;
		uniform float _node_2821;
		uniform float _Metalilc;
		uniform sampler2D _node_8994;
		uniform float4 _node_8994_ST;
		uniform float _RoughSlider;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Albedo = ( tex2D( _MainTex, uv_MainTex ) * _Color ).rgb;
			float2 uv_node_8405 = i.uv_texcoord * _node_8405_ST.xy + _node_8405_ST.zw;
			o.Emission = ( ( tex2D( _node_8405, uv_node_8405 ) * _node_3041 ) * _node_2821 ).rgb;
			o.Metallic = _Metalilc;
			float2 uv_node_8994 = i.uv_texcoord * _node_8994_ST.xy + _node_8994_ST.zw;
			o.Smoothness = ( tex2D( _node_8994, uv_node_8994 ) * _RoughSlider ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13101
7;29;1906;1004;1761;689.447;1;True;True
Node;AmplifyShaderEditor.SamplerNode;9;-469.8849,527.2025;Float;True;Property;_node_8405;node_8405;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;10;-369.1836,820.9146;Float;False;Property;_node_3041;node_3041;6;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-1166.112,-410.5805;Float;True;Property;_MainTex;_MainTex;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;13;-58.68784,930.0078;Float;False;Property;_node_2821;node_2821;7;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-16.729,703.4297;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;2;-1146.292,248.0336;Float;True;Property;_node_8994;node_8994;1;0;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;6;-1135.69,486.2577;Float;False;Property;_RoughSlider;RoughSlider;2;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;3;-1105.811,-74.47356;Float;False;Property;_Color;Color;3;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-721.9211,310.7678;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;235.0244,809.1661;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;5;-786.0912,116.1876;Float;False;Property;_Metalilc;Metalilc;1;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-792.857,-232.0726;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;8;-417.5627,16.1377;Float;True;Property;_BumpMap;_BumpMap;4;0;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;346.8879,59.62136;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;AssetsShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;9;0
WireConnection;11;1;10;0
WireConnection;7;0;2;0
WireConnection;7;1;6;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;0;0;4;0
WireConnection;0;1;8;0
WireConnection;0;2;12;0
WireConnection;0;3;5;0
WireConnection;0;4;7;0
ASEEND*/
//CHKSM=440BA727B22A1CD75C14127EDDE5D4F3BD353B7A