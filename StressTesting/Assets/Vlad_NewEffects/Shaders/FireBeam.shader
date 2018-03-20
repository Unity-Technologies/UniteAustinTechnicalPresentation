
Shader "Custom/FireBeam" {
Properties {
	[HDR]_Color ("Main Color", Color) = (1, 1, 1, 1)
	_MainTex ("Main Texture", 2D) = "white" {}
	_SecondaryTex ("Secondary Texture", 2D) = "white" {}
	_Cutoff ("Base Alpha cutoff", Range (0,1)) = .5
	_Speed ("Main Speed", Range(0,100)) = 0.4
	_DetailSpeed("Detail Speed", Range(0,100)) = 0.4
}

SubShader {
	Cull Off
	// first pass: render any pixels that are more than [_Cutoff] opaque
	Pass {  
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata_t {
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			sampler2D _SecondaryTex;
			float4 _MainTex_ST;
			float4 _SecondaryTex_ST;
			float _Cutoff;
			float _Speed;
			float _DetailSpeed;

			inline float2 AnimateUVs(float2 uvs)
			{
			//speed		
			float timer = - _Time.y*_Speed;
			uvs.x = timer*_MainTex_ST.x;
			
			return uvs;
			}
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.texcoord = v.texcoord.xy * _MainTex_ST.xy + frac(AnimateUVs(_MainTex_ST.zw));
				return o;
			}
			
			float4 _Color;
			half4 frag (v2f i) : SV_Target
			{
				fixed4 mainTex = tex2D(_MainTex, i.texcoord);
				fixed4 col = mainTex;
				
				float2 secondaryUVs;
				secondaryUVs.x = i.texcoord.x*_SecondaryTex_ST.x - _Time.x*_DetailSpeed;
				secondaryUVs.y = i.texcoord.y*_SecondaryTex_ST.y;
	
				fixed4 details = tex2D(_SecondaryTex, secondaryUVs);
				fixed4 secondary = mainTex;
				secondary.a = secondary.r; //get alpha from rgb
				col.rgb = secondary.rgb = fixed3(1,1,1); //make rgb white
				
				float2 detailsCloudUVs;
				detailsCloudUVs.x = i.texcoord.x - _Time.y*_DetailSpeed;
				detailsCloudUVs.y = i.texcoord.y;
				fixed4 detailsCloud = tex2D(_SecondaryTex, detailsCloudUVs);
				details.a *= detailsCloud.r;				
																
				col.a += secondary.a;
				col.a += details.a;
				col.a *= i.color.a;
				clip(col.a - _Cutoff);
				return col;
			}
		ENDCG
	}

	// Second pass:
	//   render the semitransparent details.
	Pass {
		ZWrite off
		Blend One OneMinusSrcAlpha
	
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _SecondaryTex;
			float4 _SecondaryTex_ST;
			float _Cutoff;
			float _Speed;
			float _DetailSpeed;

			inline float2 AnimateUVs(float2 uvs)
			{
			//speed		
			float timer = - _Time.y*_Speed;
			uvs.x = timer*_MainTex_ST.x;
			return uvs;
			}
			
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.texcoord = v.texcoord*_MainTex_ST.xy + frac(AnimateUVs(_MainTex_ST.zw));
				return o;
			}
			
			float4 _Color;
			half4 frag (v2f i) : SV_Target
			{
				fixed4 mainTex = tex2D(_MainTex, i.texcoord);
				fixed4 col = mainTex;
				
				float2 secondaryUVs;
				secondaryUVs.x = i.texcoord.x*_SecondaryTex_ST.x - _Time.x*_DetailSpeed;
				secondaryUVs.y = i.texcoord.y*_SecondaryTex_ST.y;
								
				fixed4 details = tex2D(_SecondaryTex, secondaryUVs);
				fixed4 secondary = mainTex;
				secondary.a = secondary.r; //get alpha from rgb
				col.rgb = secondary.rgb = fixed3(1,1,1); //make rgb white
				
				float2 detailsCloudUVs;
				detailsCloudUVs.x = i.texcoord.x - _Time.y * _DetailSpeed;
				detailsCloudUVs.y = i.texcoord.y;
				fixed4 detailsCloud = tex2D(_SecondaryTex, detailsCloudUVs);
				details.a *= detailsCloud.r;
				
				col.a += secondary.a;
				col.a += details.a;
				
				fixed alpha = col.a*i.color.a;
				col = lerp(_Color*4, fixed4(1,1,1,1), pow(alpha, 3))*alpha;
				clip(-(alpha - _Cutoff));
				return col;
			}
		ENDCG
	}
}

}
