Shader "Nordeus/InstancedUnlit"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	_TranslationTexture("Translation Texture", 2D) = "white" {}
	_RotationTexture("Rotation Texture", 2D) = "white" {}
	[HDR]_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" }
		LOD 100

		Pass
		{
			Blend One One
			Cull Off
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#pragma instancing_options procedural:setup
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;

				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _MainTex;

			sampler2D _TranslationTexture;
			float4 _TranslationTexture_TexelSize;

			sampler2D _RotationTexture;

			fixed4 _Color;

#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
			StructuredBuffer<float4x4> objectToWorldBuffer;
#endif

			float textureCoord;

			float4 _MainTex_ST;

			void setup()
			{
#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
				unity_ObjectToWorld = objectToWorldBuffer[unity_InstanceID];
				unity_WorldToObject = unity_ObjectToWorld;
				unity_WorldToObject._14_24_34 *= -1;
				unity_WorldToObject._11_22_33 = 1.0f / unity_WorldToObject._11_22_33;
#endif
			}

			v2f vert (appdata v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				UNITY_TRANSFER_INSTANCE_ID(v, o);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
				
				return col;
			}
			ENDCG
		}
	}
}
