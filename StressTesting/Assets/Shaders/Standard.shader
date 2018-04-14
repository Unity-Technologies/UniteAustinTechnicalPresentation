// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Skinning Standard"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo", 2D) = "white" {}

        _Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5

        _Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
        _GlossMapScale("Smoothness Scale", Range(0.0, 1.0)) = 1.0
        [Enum(Metallic Alpha,0,Albedo Alpha,1)] _SmoothnessTextureChannel ("Smoothness texture channel", Float) = 0

        [Gamma] _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _MetallicGlossMap("Metallic", 2D) = "white" {}

        [ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
        [ToggleOff] _GlossyReflections("Glossy Reflections", Float) = 1.0

        _BumpScale("Scale", Float) = 1.0
        _BumpMap("Normal Map", 2D) = "bump" {}

        _Parallax ("Height Scale", Range (0.005, 0.08)) = 0.02
        _ParallaxMap ("Height Map", 2D) = "black" {}

        _OcclusionStrength("Strength", Range(0.0, 1.0)) = 1.0
        _OcclusionMap("Occlusion", 2D) = "white" {}

        _EmissionColor("Color", Color) = (0,0,0)
        _EmissionMap("Emission", 2D) = "white" {}

        _DetailMask("Detail Mask", 2D) = "white" {}

        _DetailAlbedoMap("Detail Albedo x2", 2D) = "grey" {}
        _DetailNormalMapScale("Scale", Float) = 1.0
        _DetailNormalMap("Normal Map", 2D) = "bump" {}

		_TranslationTexture	("Translation", 2D) = "white"{}
		_RotationTexture	("Rotation", 2D) = "white"{}

        [Enum(UV0,0,UV1,1)] _UVSec ("UV Set for secondary textures", Float) = 0


        // Blending state
        [HideInInspector] _Mode ("__mode", Float) = 0.0
        [HideInInspector] _SrcBlend ("__src", Float) = 1.0
        [HideInInspector] _DstBlend ("__dst", Float) = 0.0
        [HideInInspector] _ZWrite ("__zw", Float) = 1.0
    }

    CGINCLUDE
        #define UNITY_SETUP_BRDF_INPUT MetallicSetup
    ENDCG

    SubShader
    {
        Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }
        LOD 300

        // ------------------------------------------------------------------
        //  Deferred pass
        Pass
        {
            Name "DEFERRED"
            Tags { "LightMode" = "Deferred" }

            CGPROGRAM
            #pragma target 3.0
            #pragma exclude_renderers nomrt


            // -------------------------------------

            #pragma shader_feature _NORMALMAP
            #pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _EMISSION
            #pragma shader_feature _METALLICGLOSSMAP
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature ___ _DETAIL_MULX2
            #pragma shader_feature _PARALLAXMAP

            #pragma multi_compile_prepassfinal
            #pragma multi_compile_instancing
            // Uncomment the following line to enable dithering LOD crossfade. Note: there are more in the file to uncomment for other passes.
            //#pragma multi_compile _ LOD_FADE_CROSSFADE

            #pragma vertex vertDeferredSkinning
            #pragma fragment fragDeferred

			#pragma instancing_options procedural:setup

            #include "UnityStandardCore.cginc"

			sampler2D _AnimationTexture0;
			sampler2D _AnimationTexture1;
			sampler2D _AnimationTexture2;


	#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
			//StructuredBuffer<float4x4> objectToWorldBuffer;
			StructuredBuffer<float4> objectPositionsBuffer;
			StructuredBuffer<float4> objectRotationsBuffer;
			StructuredBuffer<float3> textureCoordinatesBuffer;
	#endif

			void setup()
			{
	#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
				//unity_ObjectToWorld = objectToWorldBuffer[unity_InstanceID];
				//unity_WorldToObject = unity_ObjectToWorld;

				// Construct an identity matrix
				unity_ObjectToWorld = float4x4(1, 0, 0, 0,
					0, 1, 0, 0,
					0, 0, 1, 0,
					0, 0, 0, 1);
				unity_WorldToObject = unity_ObjectToWorld;

				unity_WorldToObject._14_24_34 *= -1;
				unity_WorldToObject._11_22_33 = 1.0f / unity_WorldToObject._11_22_33;
	#endif
			}

			inline float4 QuaternionMul(float4 v, float4 q)
			{
				v = float4(v + 2 * cross(q.xyz, cross(q.xyz, v.xyz) + q.w * v), v.w);
				return v;
			}

			struct VertexInputSkinning
			{
				float4 vertex   : POSITION;
				half3 normal    : NORMAL;
				float2 uv0      : TEXCOORD0;
				float2 boneIds  : TEXCOORD1;
				float2 boneInfluences : TEXCOORD2;
	#ifdef _TANGENT_TO_WORLD
				half4 tangent   : TANGENT;
	#endif
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			float4 TexCoordsSkin(VertexInputSkinning v)
			{
				float4 texcoord;
				texcoord.xy = TRANSFORM_TEX(v.uv0, _MainTex); // Always source from uv0
				texcoord.zw = TRANSFORM_TEX(((_UVSec == 0) ? v.uv0 : v.boneIds), _DetailAlbedoMap);
				return texcoord;
			}

			inline float4x4 CreateMatrix(float texturePosition, float boneId)
			{
				float4 row0 = tex2Dlod(_AnimationTexture0, float4(texturePosition, boneId, 0, 0));
				float4 row1 = tex2Dlod(_AnimationTexture1, float4(texturePosition, boneId, 0, 0));
				float4 row2 = tex2Dlod(_AnimationTexture2, float4(texturePosition, boneId, 0, 0));

				float4x4 reconstructedMatrix = float4x4(row0, row1, row2, float4(0, 0, 0, 1));

				return reconstructedMatrix;
			}

			VertexOutputDeferred vertDeferredSkinning(VertexInputSkinning v)
			{
				UNITY_SETUP_INSTANCE_ID(v);
				VertexOutputDeferred o;
				UNITY_INITIALIZE_OUTPUT(VertexOutputDeferred, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

	#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
				float3 animationTextureCoords = textureCoordinatesBuffer[unity_InstanceID];

				float4x4 firstBoneMatrix0 = CreateMatrix(animationTextureCoords.x, v.boneIds.x);
				float4x4 firstBoneMatrix1 = CreateMatrix(animationTextureCoords.y, v.boneIds.x);
				float4x4 firstBoneMatrix = firstBoneMatrix0 * (1 - animationTextureCoords.z) + firstBoneMatrix1 * animationTextureCoords.z;

				float4x4 secondBoneMatrix0 = CreateMatrix(animationTextureCoords.x, v.boneIds.y);
				float4x4 secondBoneMatrix1 = CreateMatrix(animationTextureCoords.y, v.boneIds.y);
				float4x4 secondBoneMatrix = secondBoneMatrix0 * (1 - animationTextureCoords.z) + secondBoneMatrix1 * animationTextureCoords.z;

				float4x4 combinedMatrix = firstBoneMatrix * v.boneInfluences.x + secondBoneMatrix * v.boneInfluences.y;
				//float4x4 combinedMatrix = firstBoneMatrix0;

				float4 skinnedVertex = mul(combinedMatrix, v.vertex);
					
				skinnedVertex *= objectPositionsBuffer[unity_InstanceID].w;
				float4 posWorld = QuaternionMul(skinnedVertex, objectRotationsBuffer[unity_InstanceID]);
				posWorld.xyz = posWorld + objectPositionsBuffer[unity_InstanceID].xyz;

	#if UNITY_REQUIRE_FRAG_WORLDPOS
	#if UNITY_PACK_WORLDPOS_WITH_TANGENT
				o.tangentToWorldAndPackedData[0].w = posWorld.x;
				o.tangentToWorldAndPackedData[1].w = posWorld.y;
				o.tangentToWorldAndPackedData[2].w = posWorld.z;
	#else
				o.posWorld = posWorld.xyz;
	#endif
	#endif
				o.pos = UnityObjectToClipPos(posWorld);

				o.tex = TexCoordsSkin(v);
				o.eyeVec = NormalizePerVertexNormal(posWorld.xyz - _WorldSpaceCameraPos);

				float3 normalSkinningRotated = mul(combinedMatrix, float4(v.normal.xyz, 0));

				float3 normalWorld = QuaternionMul(float4(normalSkinningRotated, 1), objectRotationsBuffer[unity_InstanceID]);

	#ifdef _TANGENT_TO_WORLD
				float4 tangentWorld = float4(mul(combinedMatrix, float4(v.tangent.xyz, 0)).xyz, v.tangent.w);

				float3x3 tangentToWorld = CreateTangentToWorldPerVertex(normalWorld, tangentWorld.xyz, tangentWorld.w);
				o.tangentToWorldAndPackedData[0].xyz = tangentToWorld[0];
				o.tangentToWorldAndPackedData[1].xyz = tangentToWorld[1];
				o.tangentToWorldAndPackedData[2].xyz = tangentToWorld[2];
	#else
				o.tangentToWorldAndPackedData[0].xyz = 0;
				o.tangentToWorldAndPackedData[1].xyz = 0;
				o.tangentToWorldAndPackedData[2].xyz = normalWorld;

	// procedural instancing
	#endif

				o.ambientOrLightmapUV = 0;
	#ifdef LIGHTMAP_ON
				//o.ambientOrLightmapUV.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
	#elif UNITY_SHOULD_SAMPLE_SH
				o.ambientOrLightmapUV.rgb = ShadeSHPerVertex(normalWorld, o.ambientOrLightmapUV.rgb);
	#endif
	#ifdef DYNAMICLIGHTMAP_ON
				//o.ambientOrLightmapUV.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
	#endif

	#ifdef _PARALLAXMAP
				TANGENT_SPACE_ROTATION;
				half3 viewDirForParallax = mul(rotation, ObjSpaceViewDir(v.vertex));
				o.tangentToWorldAndPackedData[0].w = viewDirForParallax.x;
				o.tangentToWorldAndPackedData[1].w = viewDirForParallax.y;
				o.tangentToWorldAndPackedData[2].w = viewDirForParallax.z;
	#endif
	#else

				float4 posWorld = mul(unity_ObjectToWorld, v.vertex);
	#if UNITY_REQUIRE_FRAG_WORLDPOS
	#if UNITY_PACK_WORLDPOS_WITH_TANGENT
				o.tangentToWorldAndPackedData[0].w = posWorld.x;
				o.tangentToWorldAndPackedData[1].w = posWorld.y;
				o.tangentToWorldAndPackedData[2].w = posWorld.z;
	#else
				o.posWorld = posWorld.xyz;
	#endif
	#endif
				o.pos = UnityObjectToClipPos(v.vertex);

				o.tex = TexCoordsSkin(v);
				o.eyeVec = NormalizePerVertexNormal(posWorld.xyz - _WorldSpaceCameraPos);
				float3 normalWorld = UnityObjectToWorldNormal(v.normal);
	#ifdef _TANGENT_TO_WORLD
				float4 tangentWorld = float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w);

				float3x3 tangentToWorld = CreateTangentToWorldPerVertex(normalWorld, tangentWorld.xyz, tangentWorld.w);
				o.tangentToWorldAndPackedData[0].xyz = tangentToWorld[0];
				o.tangentToWorldAndPackedData[1].xyz = tangentToWorld[1];
				o.tangentToWorldAndPackedData[2].xyz = tangentToWorld[2];
	#else
				o.tangentToWorldAndPackedData[0].xyz = 0;
				o.tangentToWorldAndPackedData[1].xyz = 0;
				o.tangentToWorldAndPackedData[2].xyz = normalWorld;
	#endif

				o.ambientOrLightmapUV = 0;
	#ifdef LIGHTMAP_ON
				//o.ambientOrLightmapUV.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
	#elif UNITY_SHOULD_SAMPLE_SH
				o.ambientOrLightmapUV.rgb = ShadeSHPerVertex(normalWorld, o.ambientOrLightmapUV.rgb);
	#endif
	#ifdef DYNAMICLIGHTMAP_ON
				//o.ambientOrLightmapUV.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
	#endif

	#ifdef _PARALLAXMAP
				TANGENT_SPACE_ROTATION;
				half3 viewDirForParallax = mul(rotation, ObjSpaceViewDir(v.vertex));
				o.tangentToWorldAndPackedData[0].w = viewDirForParallax.x;
				o.tangentToWorldAndPackedData[1].w = viewDirForParallax.y;
				o.tangentToWorldAndPackedData[2].w = viewDirForParallax.z;
	#endif
	#endif

				return o;
			}

            ENDCG
        }
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }
        LOD 150

        // ------------------------------------------------------------------
        //  Base forward pass (directional light, emission, lightmaps, ...)
        Pass
        {
            Name "FORWARD"
            Tags { "LightMode" = "ForwardBase" }

            Blend [_SrcBlend] [_DstBlend]
            ZWrite [_ZWrite]

            CGPROGRAM
            #pragma target 2.0

            #pragma shader_feature _NORMALMAP
            #pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _EMISSION
            #pragma shader_feature _METALLICGLOSSMAP
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature _ _GLOSSYREFLECTIONS_OFF
            // SM2.0: NOT SUPPORTED shader_feature ___ _DETAIL_MULX2
            // SM2.0: NOT SUPPORTED shader_feature _PARALLAXMAP

            #pragma skip_variants SHADOWS_SOFT DIRLIGHTMAP_COMBINED

            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog

            #pragma vertex vertBase
            #pragma fragment fragBase
            #include "UnityStandardCoreForward.cginc"

            ENDCG
        }
        // ------------------------------------------------------------------
        //  Additive forward pass (one light per pass)
        Pass
        {
            Name "FORWARD_DELTA"
            Tags { "LightMode" = "ForwardAdd" }
            Blend [_SrcBlend] One
            Fog { Color (0,0,0,0) } // in additive pass fog should be black
            ZWrite Off
            ZTest LEqual

            CGPROGRAM
            #pragma target 2.0

            #pragma shader_feature _NORMALMAP
            #pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _METALLICGLOSSMAP
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature _ _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature ___ _DETAIL_MULX2
            // SM2.0: NOT SUPPORTED shader_feature _PARALLAXMAP
            #pragma skip_variants SHADOWS_SOFT

            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog

            #pragma vertex vertAdd
            #pragma fragment fragAdd
            #include "UnityStandardCoreForward.cginc"

            ENDCG
        }
        // ------------------------------------------------------------------
        //  Shadow rendering pass
        Pass {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }

            ZWrite On ZTest LEqual

            CGPROGRAM
            #pragma target 2.0

            #pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _METALLICGLOSSMAP
            #pragma skip_variants SHADOWS_SOFT
            #pragma multi_compile_shadowcaster

            #pragma vertex vertShadowCaster
            #pragma fragment fragShadowCaster

            #include "UnityStandardShadow.cginc"

            ENDCG
        }
    }


    FallBack "VertexLit"
    CustomEditor "StandardShaderGUI"
}
