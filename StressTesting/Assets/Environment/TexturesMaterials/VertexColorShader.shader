// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35696,y:33019,varname:node_2865,prsc:2|diff-4955-OUT,spec-358-OUT,gloss-1813-OUT,normal-8170-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30304,y:31424,ptovrint:False,ptlb:TintA,ptin:_TintA,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Slider,id:358,x:35101,y:33398,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1813,x:35154,y:33466,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:_Metallic_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:7365,x:32355,y:32389,varname:node_7365,prsc:2|A-9825-OUT,B-3219-OUT,T-1039-OUT;n:type:ShaderForge.SFN_Lerp,id:9825,x:31924,y:32072,varname:node_9825,prsc:2|A-8639-OUT,B-181-OUT,T-4284-OUT;n:type:ShaderForge.SFN_Lerp,id:8639,x:31459,y:31586,varname:node_8639,prsc:2|A-3522-RGB,B-6564-OUT,T-8217-R;n:type:ShaderForge.SFN_VertexColor,id:8217,x:30474,y:33259,varname:node_8217,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8024,x:31581,y:33253,varname:node_8024,prsc:2|A-8217-A,B-8472-OUT;n:type:ShaderForge.SFN_Vector1,id:8472,x:31417,y:33373,varname:node_8472,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:4955,x:32770,y:32690,varname:node_4955,prsc:2|A-7365-OUT,B-9163-OUT,T-3624-OUT;n:type:ShaderForge.SFN_Tex2d,id:661,x:30307,y:31942,ptovrint:False,ptlb:colorB,ptin:_colorB,varname:_node_6183_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbe818838f3f8a04c85a28d62f07f957,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4513,x:30304,y:31582,ptovrint:False,ptlb:colorA,ptin:_colorA,varname:_node_6183_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:246e25d0122e42b4e8693f8b60603801,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4846,x:30296,y:32322,ptovrint:False,ptlb:colorC,ptin:_colorC,varname:_node_6183_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6216567a30477c141b155ee21160b2d9,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:7994,x:30296,y:32729,ptovrint:False,ptlb:colorD,ptin:_colorD,varname:_node_6183_copy_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e62ef818f2b48bb45b234f3bdb2e8f7b,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector1,id:3826,x:30968,y:31365,varname:node_3826,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:2611,x:30508,y:31517,varname:node_2611,prsc:2|A-6665-RGB,B-4513-RGB;n:type:ShaderForge.SFN_Color,id:9720,x:30304,y:31767,ptovrint:False,ptlb:TintB,ptin:_TintB,varname:_TintA_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9299,x:30638,y:31835,varname:node_9299,prsc:2|A-9720-RGB,B-661-RGB;n:type:ShaderForge.SFN_Color,id:1189,x:30296,y:32153,ptovrint:False,ptlb:TintC,ptin:_TintC,varname:_TintB_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:3247,x:30494,y:32260,varname:node_3247,prsc:2|A-1189-RGB,B-4846-RGB;n:type:ShaderForge.SFN_Color,id:7670,x:30296,y:32520,ptovrint:False,ptlb:TintD,ptin:_TintD,varname:_TintB_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:3422,x:30492,y:32640,varname:node_3422,prsc:2|A-7670-RGB,B-7994-RGB;n:type:ShaderForge.SFN_FragmentPosition,id:1867,x:36164,y:34793,varname:node_1867,prsc:2;n:type:ShaderForge.SFN_ViewPosition,id:6966,x:36188,y:34968,varname:node_6966,prsc:2;n:type:ShaderForge.SFN_Distance,id:7354,x:36325,y:34754,varname:node_7354,prsc:2|A-1867-XYZ,B-6966-XYZ;n:type:ShaderForge.SFN_Subtract,id:900,x:36511,y:34711,varname:node_900,prsc:2|A-7354-OUT,B-6622-NEAR;n:type:ShaderForge.SFN_ProjectionParameters,id:6622,x:36370,y:34946,varname:node_6622,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:9602,x:36675,y:34546,varname:node_9602,prsc:2|IN-900-OUT;n:type:ShaderForge.SFN_Multiply,id:3589,x:32038,y:33190,varname:node_3589,prsc:2|A-8024-OUT,B-3560-RGB;n:type:ShaderForge.SFN_OneMinus,id:2240,x:32038,y:33481,varname:node_2240,prsc:2|IN-3560-RGB;n:type:ShaderForge.SFN_Add,id:2250,x:32038,y:33331,varname:node_2250,prsc:2|A-3560-RGB,B-2240-OUT;n:type:ShaderForge.SFN_Multiply,id:3732,x:32223,y:33190,varname:node_3732,prsc:2|A-3589-OUT,B-2250-OUT,C-8264-OUT;n:type:ShaderForge.SFN_Multiply,id:8264,x:32223,y:33331,varname:node_8264,prsc:2|A-2250-OUT,B-2151-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2151,x:31640,y:34388,ptovrint:False,ptlb:BlendStrength_D,ptin:_BlendStrength_D,varname:node_2151,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:6511,x:32424,y:33190,varname:node_6511,prsc:2|IN-3732-OUT;n:type:ShaderForge.SFN_Multiply,id:6702,x:31736,y:32778,varname:node_6702,prsc:2|A-8217-B,B-3560-RGB;n:type:ShaderForge.SFN_OneMinus,id:2432,x:31736,y:33069,varname:node_2432,prsc:2|IN-3560-RGB;n:type:ShaderForge.SFN_Add,id:4575,x:31736,y:32919,varname:node_4575,prsc:2|A-3560-RGB,B-2432-OUT;n:type:ShaderForge.SFN_Multiply,id:5339,x:31921,y:32778,varname:node_5339,prsc:2|A-6702-OUT,B-4575-OUT,C-9719-OUT;n:type:ShaderForge.SFN_Multiply,id:9719,x:31921,y:32919,varname:node_9719,prsc:2|A-4575-OUT,B-7322-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7322,x:31640,y:34260,ptovrint:False,ptlb:BlendStrength_C,ptin:_BlendStrength_C,varname:_BlendStrength_D_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:1880,x:32090,y:32778,varname:node_1880,prsc:2|IN-5339-OUT;n:type:ShaderForge.SFN_Tex2d,id:3560,x:30989,y:33875,ptovrint:False,ptlb:Bledn_B,ptin:_Bledn_B,varname:_Bledn_D_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6335,x:31421,y:32357,varname:node_6335,prsc:2|A-8217-G,B-3560-RGB;n:type:ShaderForge.SFN_OneMinus,id:6893,x:31421,y:32648,varname:node_6893,prsc:2|IN-3560-RGB;n:type:ShaderForge.SFN_Add,id:4339,x:31421,y:32498,varname:node_4339,prsc:2|A-3560-RGB,B-6893-OUT;n:type:ShaderForge.SFN_Multiply,id:849,x:31606,y:32357,varname:node_849,prsc:2|A-6335-OUT,B-4339-OUT,C-2893-OUT;n:type:ShaderForge.SFN_Multiply,id:2893,x:31606,y:32498,varname:node_2893,prsc:2|A-4339-OUT,B-5654-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5654,x:31640,y:34154,ptovrint:False,ptlb:BlendStrength_B,ptin:_BlendStrength_B,varname:_BlendStrength_D_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:2397,x:31775,y:32357,varname:node_2397,prsc:2|IN-849-OUT;n:type:ShaderForge.SFN_Tex2d,id:3522,x:30356,y:31155,ptovrint:False,ptlb:BaseColor,ptin:_BaseColor,varname:node_3522,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:3688,x:31002,y:34672,varname:node_3688,prsc:2|A-5296-OUT,B-2488-OUT,T-3577-OUT;n:type:ShaderForge.SFN_Lerp,id:5296,x:30509,y:34423,varname:node_5296,prsc:2|A-3936-OUT,B-8013-OUT,T-9248-OUT;n:type:ShaderForge.SFN_Lerp,id:3936,x:29584,y:33886,varname:node_3936,prsc:2|A-4145-RGB,B-5586-OUT,T-1903-R;n:type:ShaderForge.SFN_VertexColor,id:1903,x:29059,y:35610,varname:node_1903,prsc:2;n:type:ShaderForge.SFN_Multiply,id:725,x:30166,y:35604,varname:node_725,prsc:2|A-1903-A,B-741-OUT;n:type:ShaderForge.SFN_Vector1,id:741,x:30002,y:35724,varname:node_741,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:6720,x:31879,y:35045,varname:node_6720,prsc:2|A-3688-OUT,B-6473-OUT,T-1962-OUT;n:type:ShaderForge.SFN_Tex2d,id:8177,x:28892,y:34293,ptovrint:False,ptlb:NormalB,ptin:_NormalB,varname:_colorB_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbe818838f3f8a04c85a28d62f07f957,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:2924,x:28893,y:33896,ptovrint:False,ptlb:NormalA,ptin:_NormalA,varname:_colorA_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:246e25d0122e42b4e8693f8b60603801,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:3495,x:28881,y:34673,ptovrint:False,ptlb:NormalC,ptin:_NormalC,varname:_colorC_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6216567a30477c141b155ee21160b2d9,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:2390,x:28933,y:35101,ptovrint:False,ptlb:NormalD,ptin:_NormalD,varname:_colorD_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e62ef818f2b48bb45b234f3bdb2e8f7b,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Vector1,id:7069,x:29553,y:33716,varname:node_7069,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:9895,x:30623,y:35541,varname:node_9895,prsc:2|A-725-OUT,B-3560-RGB;n:type:ShaderForge.SFN_OneMinus,id:3398,x:30623,y:35832,varname:node_3398,prsc:2|IN-3560-RGB;n:type:ShaderForge.SFN_Add,id:4829,x:30623,y:35682,varname:node_4829,prsc:2|A-3560-RGB,B-3398-OUT;n:type:ShaderForge.SFN_Multiply,id:7149,x:30808,y:35541,varname:node_7149,prsc:2|A-9895-OUT,B-4829-OUT,C-5448-OUT;n:type:ShaderForge.SFN_Multiply,id:5448,x:30808,y:35682,varname:node_5448,prsc:2|A-4829-OUT,B-2151-OUT;n:type:ShaderForge.SFN_Clamp01,id:1962,x:30977,y:35541,varname:node_1962,prsc:2|IN-7149-OUT;n:type:ShaderForge.SFN_Multiply,id:5215,x:30321,y:35129,varname:node_5215,prsc:2|A-1903-B,B-3560-RGB;n:type:ShaderForge.SFN_OneMinus,id:8595,x:30321,y:35420,varname:node_8595,prsc:2|IN-3560-RGB;n:type:ShaderForge.SFN_Add,id:8305,x:30321,y:35270,varname:node_8305,prsc:2|A-3560-RGB,B-8595-OUT;n:type:ShaderForge.SFN_Multiply,id:3207,x:30526,y:35129,varname:node_3207,prsc:2|A-5215-OUT,B-8305-OUT,C-4073-OUT;n:type:ShaderForge.SFN_Multiply,id:4073,x:30506,y:35270,varname:node_4073,prsc:2|A-8305-OUT,B-7322-OUT;n:type:ShaderForge.SFN_Clamp01,id:3577,x:30692,y:35129,varname:node_3577,prsc:2|IN-3207-OUT;n:type:ShaderForge.SFN_Multiply,id:3499,x:30006,y:34708,varname:node_3499,prsc:2|A-1903-G,B-3560-RGB;n:type:ShaderForge.SFN_OneMinus,id:618,x:30006,y:34999,varname:node_618,prsc:2|IN-3560-RGB;n:type:ShaderForge.SFN_Add,id:549,x:30006,y:34849,varname:node_549,prsc:2|A-3560-RGB,B-618-OUT;n:type:ShaderForge.SFN_Multiply,id:7487,x:30191,y:34708,varname:node_7487,prsc:2|A-3499-OUT,B-549-OUT,C-6078-OUT;n:type:ShaderForge.SFN_Multiply,id:6078,x:30191,y:34849,varname:node_6078,prsc:2|A-549-OUT,B-5654-OUT;n:type:ShaderForge.SFN_Clamp01,id:9248,x:30360,y:34708,varname:node_9248,prsc:2|IN-7487-OUT;n:type:ShaderForge.SFN_Tex2d,id:4145,x:29279,y:33682,ptovrint:False,ptlb:BaseNormal,ptin:_BaseNormal,varname:_BaseColor_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Normalize,id:8170,x:35120,y:33188,varname:node_8170,prsc:2|IN-9477-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6915,x:28730,y:34906,ptovrint:False,ptlb:NormalC_STR,ptin:_NormalC_STR,varname:node_6915,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:6793,x:28897,y:34863,varname:node_6793,prsc:2|A-6915-OUT,B-6915-OUT;n:type:ShaderForge.SFN_Append,id:7514,x:29041,y:34863,varname:node_7514,prsc:2|A-6793-OUT,B-4382-OUT;n:type:ShaderForge.SFN_Vector1,id:4382,x:28829,y:35031,varname:node_4382,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:2488,x:29155,y:34695,varname:node_2488,prsc:2|A-3495-RGB,B-7514-OUT;n:type:ShaderForge.SFN_Color,id:5202,x:35443,y:32890,ptovrint:False,ptlb:node_5202,ptin:_node_5202,varname:node_5202,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:3092,x:31935,y:34151,ptovrint:False,ptlb:node_3092,ptin:_node_3092,varname:node_3092,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Lerp,id:3624,x:32597,y:32861,varname:node_3624,prsc:2|A-7365-OUT,B-6511-OUT,T-3092-OUT;n:type:ShaderForge.SFN_Lerp,id:2062,x:31329,y:35181,varname:node_2062,prsc:2|A-3688-OUT,B-1962-OUT,T-3092-OUT;n:type:ShaderForge.SFN_Slider,id:3170,x:31899,y:34260,ptovrint:False,ptlb:node_3ew,ptin:_node_3ew,varname:_node_3092_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Lerp,id:1039,x:32135,y:32503,varname:node_1039,prsc:2|A-9825-OUT,B-1880-OUT,T-3170-OUT;n:type:ShaderForge.SFN_Lerp,id:4284,x:31663,y:32138,varname:node_4284,prsc:2|A-8639-OUT,B-2397-OUT,T-1550-OUT;n:type:ShaderForge.SFN_Slider,id:1550,x:31914,y:34378,ptovrint:False,ptlb:node_3ew_copy,ptin:_node_3ew_copy,varname:_node_3ew_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:6937,x:32869,y:32015,ptovrint:False,ptlb:node_6937,ptin:_node_6937,varname:node_6937,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:3540,x:32701,y:32448,ptovrint:False,ptlb:node_3540,ptin:_node_3540,varname:node_3540,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:9163,x:32403,y:32793,varname:node_9163,prsc:2|A-3422-OUT,B-6937-RGB,T-3540-OUT;n:type:ShaderForge.SFN_Slider,id:7140,x:32701,y:32363,ptovrint:False,ptlb:node_3540_copy,ptin:_node_3540_copy,varname:_node_3540_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1534,x:32701,y:32281,ptovrint:False,ptlb:node_3540_copy_copy,ptin:_node_3540_copy_copy,varname:_node_3540_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:3219,x:32066,y:32365,varname:node_3219,prsc:2|A-3247-OUT,B-6937-RGB,T-7140-OUT;n:type:ShaderForge.SFN_Lerp,id:181,x:31505,y:32043,varname:node_181,prsc:2|A-9299-OUT,B-6937-RGB,T-1534-OUT;n:type:ShaderForge.SFN_Slider,id:2424,x:32701,y:32194,ptovrint:False,ptlb:node_3540_copy_copy_copy,ptin:_node_3540_copy_copy_copy,varname:_node_3540_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:6564,x:31216,y:31604,varname:node_6564,prsc:2|A-2611-OUT,B-6937-RGB,T-2424-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1678,x:28726,y:35312,ptovrint:False,ptlb:NormalD_STR,ptin:_NormalD_STR,varname:_node_6915_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:3848,x:28825,y:35437,varname:node_3848,prsc:2,v1:1;n:type:ShaderForge.SFN_Append,id:6475,x:28893,y:35269,varname:node_6475,prsc:2|A-1678-OUT,B-1678-OUT;n:type:ShaderForge.SFN_Append,id:682,x:29037,y:35269,varname:node_682,prsc:2|A-6475-OUT,B-3848-OUT;n:type:ShaderForge.SFN_Multiply,id:6473,x:29151,y:35101,varname:node_6473,prsc:2|A-2390-RGB,B-682-OUT;n:type:ShaderForge.SFN_Color,id:3501,x:30496,y:31959,ptovrint:False,ptlb:TintB_copy,ptin:_TintB_copy,varname:_TintB_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:8707,x:30689,y:32051,varname:node_8707,prsc:2|A-3501-RGB;n:type:ShaderForge.SFN_Color,id:7115,x:30560,y:32023,ptovrint:False,ptlb:TintB_copy_copy,ptin:_TintB_copy_copy,varname:_TintB_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:781,x:30753,y:32115,varname:node_781,prsc:2|A-7115-RGB;n:type:ShaderForge.SFN_ValueProperty,id:144,x:28661,y:34521,ptovrint:False,ptlb:NormalB_STR,ptin:_NormalB_STR,varname:_NormalC_STR_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:8862,x:28828,y:34478,varname:node_8862,prsc:2|A-144-OUT,B-144-OUT;n:type:ShaderForge.SFN_Append,id:931,x:28972,y:34478,varname:node_931,prsc:2|A-8862-OUT,B-5047-OUT;n:type:ShaderForge.SFN_Multiply,id:8013,x:29086,y:34310,varname:node_8013,prsc:2|A-8177-RGB,B-931-OUT;n:type:ShaderForge.SFN_Vector1,id:5047,x:29106,y:34616,varname:node_5047,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:8525,x:29044,y:34236,varname:node_8525,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7980,x:28653,y:34124,ptovrint:False,ptlb:NormalA_STR,ptin:_NormalA_STR,varname:_NormalB_STR_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:9347,x:28820,y:34081,varname:node_9347,prsc:2|A-7980-OUT,B-7980-OUT;n:type:ShaderForge.SFN_Append,id:9694,x:29044,y:34063,varname:node_9694,prsc:2|A-9347-OUT,B-8525-OUT;n:type:ShaderForge.SFN_Multiply,id:5586,x:29078,y:33913,varname:node_5586,prsc:2|A-2924-RGB,B-9694-OUT;n:type:ShaderForge.SFN_Tex2d,id:4332,x:33909,y:34553,ptovrint:False,ptlb:TerrainNormal,ptin:_TerrainNormal,varname:node_4332,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Color,id:9990,x:30624,y:32087,ptovrint:False,ptlb:TintB_copy_copy_copy,ptin:_TintB_copy_copy_copy,varname:_TintB_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1810,x:30817,y:32179,varname:node_1810,prsc:2|A-9990-RGB;n:type:ShaderForge.SFN_ValueProperty,id:5790,x:31466,y:36116,ptovrint:False,ptlb:TerrainNormal_STR,ptin:_TerrainNormal_STR,varname:_NormalD_STR_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:3345,x:31565,y:36241,varname:node_3345,prsc:2,v1:1;n:type:ShaderForge.SFN_Append,id:1439,x:31858,y:36073,varname:node_1439,prsc:2|A-8443-OUT,B-3345-OUT;n:type:ShaderForge.SFN_Multiply,id:2210,x:31891,y:35905,varname:node_2210,prsc:2|A-4332-RGB,B-1439-OUT;n:type:ShaderForge.SFN_Append,id:8443,x:31633,y:36073,varname:node_8443,prsc:2|A-5790-OUT,B-5790-OUT;n:type:ShaderForge.SFN_Color,id:2694,x:30688,y:32151,ptovrint:False,ptlb:TintB_copy_copy_copy_copy,ptin:_TintB_copy_copy_copy_copy,varname:_TintB_copy_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1069,x:30881,y:32243,varname:node_1069,prsc:2|A-2694-RGB;n:type:ShaderForge.SFN_NormalBlend,id:7170,x:32346,y:35210,varname:node_7170,prsc:2|BSE-6720-OUT,DTL-2210-OUT;n:type:ShaderForge.SFN_Lerp,id:3102,x:33747,y:32767,varname:node_3102,prsc:2;n:type:ShaderForge.SFN_NormalBlend,id:9477,x:34319,y:33582,varname:node_9477,prsc:2|BSE-4332-RGB,DTL-6720-OUT;proporder:6665-358-1813-7994-661-4513-4846-9720-1189-7670-2151-7322-3560-5654-3522-8177-2924-3495-2390-4145-6915-5202-3092-3170-1550-6937-3540-7140-1534-2424-1678-144-7980-4332-5790;pass:END;sub:END;*/

Shader "Shader Forge/VertexColorShader" {
    Properties {
        _TintA ("TintA", Color) = (1,1,1,1)
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0
        _colorD ("colorD", 2D) = "white" {}
        _colorB ("colorB", 2D) = "white" {}
        _colorA ("colorA", 2D) = "white" {}
        _colorC ("colorC", 2D) = "white" {}
        _TintB ("TintB", Color) = (1,1,1,1)
        _TintC ("TintC", Color) = (1,1,1,1)
        _TintD ("TintD", Color) = (1,1,1,1)
        _BlendStrength_D ("BlendStrength_D", Float ) = 3
        _BlendStrength_C ("BlendStrength_C", Float ) = 3
        _Bledn_B ("Bledn_B", 2D) = "white" {}
        _BlendStrength_B ("BlendStrength_B", Float ) = 3
        _BaseColor ("BaseColor", 2D) = "white" {}
        _NormalB ("NormalB", 2D) = "bump" {}
        _NormalA ("NormalA", 2D) = "bump" {}
        _NormalC ("NormalC", 2D) = "bump" {}
        _NormalD ("NormalD", 2D) = "bump" {}
        _BaseNormal ("BaseNormal", 2D) = "bump" {}
        _NormalC_STR ("NormalC_STR", Float ) = 0.1
        _node_5202 ("node_5202", Color) = (0.5,0.5,0.5,1)
        _node_3092 ("node_3092", Range(0, 1)) = 1
        _node_3ew ("node_3ew", Range(0, 1)) = 1
        _node_3ew_copy ("node_3ew_copy", Range(0, 1)) = 1
        _node_6937 ("node_6937", 2D) = "white" {}
        _node_3540 ("node_3540", Range(0, 1)) = 0
        _node_3540_copy ("node_3540_copy", Range(0, 1)) = 0
        _node_3540_copy_copy ("node_3540_copy_copy", Range(0, 1)) = 0
        _node_3540_copy_copy_copy ("node_3540_copy_copy_copy", Range(0, 1)) = 0
        _NormalD_STR ("NormalD_STR", Float ) = 0.1
        _NormalB_STR ("NormalB_STR", Float ) = 0.1
        _NormalA_STR ("NormalA_STR", Float ) = 0.1
        _TerrainNormal ("TerrainNormal", 2D) = "bump" {}
        _TerrainNormal_STR ("TerrainNormal_STR", Float ) = 0.1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_DEFERRED
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TintA;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _colorB; uniform float4 _colorB_ST;
            uniform sampler2D _colorA; uniform float4 _colorA_ST;
            uniform sampler2D _colorC; uniform float4 _colorC_ST;
            uniform sampler2D _colorD; uniform float4 _colorD_ST;
            uniform float4 _TintB;
            uniform float4 _TintC;
            uniform float4 _TintD;
            uniform float _BlendStrength_D;
            uniform float _BlendStrength_C;
            uniform sampler2D _Bledn_B; uniform float4 _Bledn_B_ST;
            uniform float _BlendStrength_B;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            uniform sampler2D _NormalB; uniform float4 _NormalB_ST;
            uniform sampler2D _NormalA; uniform float4 _NormalA_ST;
            uniform sampler2D _NormalC; uniform float4 _NormalC_ST;
            uniform sampler2D _NormalD; uniform float4 _NormalD_ST;
            uniform sampler2D _BaseNormal; uniform float4 _BaseNormal_ST;
            uniform float _NormalC_STR;
            uniform float _node_3092;
            uniform float _node_3ew;
            uniform float _node_3ew_copy;
            uniform sampler2D _node_6937; uniform float4 _node_6937_ST;
            uniform float _node_3540;
            uniform float _node_3540_copy;
            uniform float _node_3540_copy_copy;
            uniform float _node_3540_copy_copy_copy;
            uniform float _NormalD_STR;
            uniform float _NormalB_STR;
            uniform float _NormalA_STR;
            uniform sampler2D _TerrainNormal; uniform float4 _TerrainNormal_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 vertexColor : COLOR;
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            void frag(
                VertexOutput i,
                out half4 outDiffuse : SV_Target0,
                out half4 outSpecSmoothness : SV_Target1,
                out half4 outNormal : SV_Target2,
                out half4 outEmission : SV_Target3 )
            {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _TerrainNormal_var = UnpackNormal(tex2D(_TerrainNormal,TRANSFORM_TEX(i.uv0, _TerrainNormal)));
                float3 _BaseNormal_var = UnpackNormal(tex2D(_BaseNormal,TRANSFORM_TEX(i.uv0, _BaseNormal)));
                float3 _NormalA_var = UnpackNormal(tex2D(_NormalA,TRANSFORM_TEX(i.uv0, _NormalA)));
                float3 _NormalB_var = UnpackNormal(tex2D(_NormalB,TRANSFORM_TEX(i.uv0, _NormalB)));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_549 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 _NormalC_var = UnpackNormal(tex2D(_NormalC,TRANSFORM_TEX(i.uv0, _NormalC)));
                float3 node_8305 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_3688 = lerp(lerp(lerp(_BaseNormal_var.rgb,(_NormalA_var.rgb*float3(float2(_NormalA_STR,_NormalA_STR),1.0)),i.vertexColor.r),(_NormalB_var.rgb*float3(float2(_NormalB_STR,_NormalB_STR),1.0)),saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_549*(node_549*_BlendStrength_B)))),(_NormalC_var.rgb*float3(float2(_NormalC_STR,_NormalC_STR),1.0)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8305*(node_8305*_BlendStrength_C))));
                float3 _NormalD_var = UnpackNormal(tex2D(_NormalD,TRANSFORM_TEX(i.uv0, _NormalD)));
                float3 node_4829 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_1962 = saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_4829*(node_4829*_BlendStrength_D)));
                float3 node_6720 = lerp(node_3688,(_NormalD_var.rgb*float3(float2(_NormalD_STR,_NormalD_STR),1.0)),node_1962);
                float3 node_9477_nrm_base = _TerrainNormal_var.rgb + float3(0,0,1);
                float3 node_9477_nrm_detail = node_6720 * float3(-1,-1,1);
                float3 node_9477_nrm_combined = node_9477_nrm_base*dot(node_9477_nrm_base, node_9477_nrm_detail)/node_9477_nrm_base.z - node_9477_nrm_detail;
                float3 node_9477 = node_9477_nrm_combined;
                float3 normalLocal = normalize(node_9477);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float perceptualRoughness = 1.0 - _Gloss;
                float roughness = perceptualRoughness * perceptualRoughness;
/////// GI Data:
                UnityLight light; // Dummy light
                light.color = 0;
                light.dir = half3(0,1,0);
                light.ndotl = max(0,dot(normalDirection,light.dir));
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = 1;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
////// Specular:
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_8639 = lerp(_BaseColor_var.rgb,lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_4339 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_9825 = lerp(node_8639,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_8639,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_4339*(node_4339*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_4575 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_7365 = lerp(node_9825,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_9825,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_4575*(node_4575*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_2250 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffuseColor = lerp(node_7365,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_7365,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_2250*(node_2250*_BlendStrength_D))),_node_3092)); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
/////// Diffuse:
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
/// Final Color:
                outDiffuse = half4( diffuseColor, 1 );
                outSpecSmoothness = half4( specularColor, gloss );
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4(0,0,0,1);
                outEmission.rgb += indirectSpecular * 1;
                outEmission.rgb += indirectDiffuse * diffuseColor;
                #ifndef UNITY_HDR_ON
                    outEmission.rgb = exp2(-outEmission.rgb);
                #endif
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TintA;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _colorB; uniform float4 _colorB_ST;
            uniform sampler2D _colorA; uniform float4 _colorA_ST;
            uniform sampler2D _colorC; uniform float4 _colorC_ST;
            uniform sampler2D _colorD; uniform float4 _colorD_ST;
            uniform float4 _TintB;
            uniform float4 _TintC;
            uniform float4 _TintD;
            uniform float _BlendStrength_D;
            uniform float _BlendStrength_C;
            uniform sampler2D _Bledn_B; uniform float4 _Bledn_B_ST;
            uniform float _BlendStrength_B;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            uniform UNITY_DECLARE_TEX2D_NOSAMPLER(_NormalB); uniform float4 _NormalB_ST;
            uniform UNITY_DECLARE_TEX2D(_NormalA); uniform float4 _NormalA_ST;
            uniform UNITY_DECLARE_TEX2D_NOSAMPLER(_NormalC); uniform float4 _NormalC_ST;
            uniform UNITY_DECLARE_TEX2D_NOSAMPLER(_NormalD); uniform float4 _NormalD_ST;
            uniform sampler2D _BaseNormal; uniform float4 _BaseNormal_ST;
            uniform float _NormalC_STR;
            uniform float _node_3092;
            uniform float _node_3ew;
            uniform float _node_3ew_copy;
            uniform sampler2D _node_6937; uniform float4 _node_6937_ST;
            uniform float _node_3540;
            uniform float _node_3540_copy;
            uniform float _node_3540_copy_copy;
            uniform float _node_3540_copy_copy_copy;
            uniform float _NormalD_STR;
            uniform float _NormalB_STR;
            uniform float _NormalA_STR;
            uniform sampler2D _TerrainNormal; uniform float4 _TerrainNormal_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _TerrainNormal_var = UnpackNormal(tex2D(_TerrainNormal,TRANSFORM_TEX(i.uv0, _TerrainNormal)));
                float3 _BaseNormal_var = UnpackNormal(tex2D(_BaseNormal,TRANSFORM_TEX(i.uv0, _BaseNormal)));
                float3 _NormalA_var = UnpackNormal(UNITY_SAMPLE_TEX2D(_NormalA,TRANSFORM_TEX(i.uv0, _NormalA)));
                float3 _NormalB_var = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_NormalB,_NormalA,TRANSFORM_TEX(i.uv0, _NormalB)));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_549 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 _NormalC_var = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_NormalC,_NormalA,TRANSFORM_TEX(i.uv0, _NormalC)));
                float3 node_8305 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_3688 = lerp(lerp(lerp(_BaseNormal_var.rgb,(_NormalA_var.rgb*float3(float2(_NormalA_STR,_NormalA_STR),1.0)),i.vertexColor.r),(_NormalB_var.rgb*float3(float2(_NormalB_STR,_NormalB_STR),1.0)),saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_549*(node_549*_BlendStrength_B)))),(_NormalC_var.rgb*float3(float2(_NormalC_STR,_NormalC_STR),1.0)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8305*(node_8305*_BlendStrength_C))));
                float3 _NormalD_var = UnpackNormal(UNITY_SAMPLE_TEX2D_SAMPLER(_NormalD,_NormalA,TRANSFORM_TEX(i.uv0, _NormalD)));
                float3 node_4829 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_1962 = saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_4829*(node_4829*_BlendStrength_D)));
                float3 node_6720 = lerp(node_3688,(_NormalD_var.rgb*float3(float2(_NormalD_STR,_NormalD_STR),1.0)),node_1962);
                float3 node_9477_nrm_base = _TerrainNormal_var.rgb + float3(0,0,1);
                float3 node_9477_nrm_detail = node_6720 * float3(-1,-1,1);
                float3 node_9477_nrm_combined = node_9477_nrm_base*dot(node_9477_nrm_base, node_9477_nrm_detail)/node_9477_nrm_base.z - node_9477_nrm_detail;
                float3 node_9477 = node_9477_nrm_combined;
                float3 normalLocal = normalize(node_9477);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
				half shadowMaskAttenuation = UnitySampleBakedOcclusion(i.ambientOrLightmapUV, 0);
				attenuation = UnityMixRealtimeAndBakedShadows(attenuation, shadowMaskAttenuation, 0);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float perceptualRoughness = 1.0 - _Gloss;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                //lightDirection = gi.light.dir;
                //lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_8639 = lerp(_BaseColor_var.rgb,lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_4339 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_9825 = lerp(node_8639,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_8639,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_4339*(node_4339*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_4575 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_7365 = lerp(node_9825,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_9825,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_4575*(node_4575*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_2250 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffuseColor = lerp(node_7365,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_7365,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_2250*(node_2250*_BlendStrength_D))),_node_3092)); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TintA;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _colorB; uniform float4 _colorB_ST;
            uniform sampler2D _colorA; uniform float4 _colorA_ST;
            uniform sampler2D _colorC; uniform float4 _colorC_ST;
            uniform sampler2D _colorD; uniform float4 _colorD_ST;
            uniform float4 _TintB;
            uniform float4 _TintC;
            uniform float4 _TintD;
            uniform float _BlendStrength_D;
            uniform float _BlendStrength_C;
            uniform sampler2D _Bledn_B; uniform float4 _Bledn_B_ST;
            uniform float _BlendStrength_B;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            uniform sampler2D _NormalB; uniform float4 _NormalB_ST;
            uniform sampler2D _NormalA; uniform float4 _NormalA_ST;
            uniform sampler2D _NormalC; uniform float4 _NormalC_ST;
            uniform sampler2D _NormalD; uniform float4 _NormalD_ST;
            uniform sampler2D _BaseNormal; uniform float4 _BaseNormal_ST;
            uniform float _NormalC_STR;
            uniform float _node_3092;
            uniform float _node_3ew;
            uniform float _node_3ew_copy;
            uniform sampler2D _node_6937; uniform float4 _node_6937_ST;
            uniform float _node_3540;
            uniform float _node_3540_copy;
            uniform float _node_3540_copy_copy;
            uniform float _node_3540_copy_copy_copy;
            uniform float _NormalD_STR;
            uniform float _NormalB_STR;
            uniform float _NormalA_STR;
            uniform sampler2D _TerrainNormal; uniform float4 _TerrainNormal_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _TerrainNormal_var = UnpackNormal(tex2D(_TerrainNormal,TRANSFORM_TEX(i.uv0, _TerrainNormal)));
                float3 _BaseNormal_var = UnpackNormal(tex2D(_BaseNormal,TRANSFORM_TEX(i.uv0, _BaseNormal)));
                float3 _NormalA_var = UnpackNormal(tex2D(_NormalA,TRANSFORM_TEX(i.uv0, _NormalA)));
                float3 _NormalB_var = UnpackNormal(tex2D(_NormalB,TRANSFORM_TEX(i.uv0, _NormalB)));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_549 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 _NormalC_var = UnpackNormal(tex2D(_NormalC,TRANSFORM_TEX(i.uv0, _NormalC)));
                float3 node_8305 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_3688 = lerp(lerp(lerp(_BaseNormal_var.rgb,(_NormalA_var.rgb*float3(float2(_NormalA_STR,_NormalA_STR),1.0)),i.vertexColor.r),(_NormalB_var.rgb*float3(float2(_NormalB_STR,_NormalB_STR),1.0)),saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_549*(node_549*_BlendStrength_B)))),(_NormalC_var.rgb*float3(float2(_NormalC_STR,_NormalC_STR),1.0)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8305*(node_8305*_BlendStrength_C))));
                float3 _NormalD_var = UnpackNormal(tex2D(_NormalD,TRANSFORM_TEX(i.uv0, _NormalD)));
                float3 node_4829 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_1962 = saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_4829*(node_4829*_BlendStrength_D)));
                float3 node_6720 = lerp(node_3688,(_NormalD_var.rgb*float3(float2(_NormalD_STR,_NormalD_STR),1.0)),node_1962);
                float3 node_9477_nrm_base = _TerrainNormal_var.rgb + float3(0,0,1);
                float3 node_9477_nrm_detail = node_6720 * float3(-1,-1,1);
                float3 node_9477_nrm_combined = node_9477_nrm_base*dot(node_9477_nrm_base, node_9477_nrm_detail)/node_9477_nrm_base.z - node_9477_nrm_detail;
                float3 node_9477 = node_9477_nrm_combined;
                float3 normalLocal = normalize(node_9477);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1.0;//LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float perceptualRoughness = 1.0 - _Gloss;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_8639 = lerp(_BaseColor_var.rgb,lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_4339 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_9825 = lerp(node_8639,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_8639,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_4339*(node_4339*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_4575 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_7365 = lerp(node_9825,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_9825,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_4575*(node_4575*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_2250 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffuseColor = lerp(node_7365,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_7365,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_2250*(node_2250*_BlendStrength_D))),_node_3092)); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TintA;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _colorB; uniform float4 _colorB_ST;
            uniform sampler2D _colorA; uniform float4 _colorA_ST;
            uniform sampler2D _colorC; uniform float4 _colorC_ST;
            uniform sampler2D _colorD; uniform float4 _colorD_ST;
            uniform float4 _TintB;
            uniform float4 _TintC;
            uniform float4 _TintD;
            uniform float _BlendStrength_D;
            uniform float _BlendStrength_C;
            uniform sampler2D _Bledn_B; uniform float4 _Bledn_B_ST;
            uniform float _BlendStrength_B;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            uniform float _node_3092;
            uniform float _node_3ew;
            uniform float _node_3ew_copy;
            uniform sampler2D _node_6937; uniform float4 _node_6937_ST;
            uniform float _node_3540;
            uniform float _node_3540_copy;
            uniform float _node_3540_copy_copy;
            uniform float _node_3540_copy_copy_copy;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_8639 = lerp(_BaseColor_var.rgb,lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_4339 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_9825 = lerp(node_8639,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_8639,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_4339*(node_4339*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_4575 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_7365 = lerp(node_9825,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_9825,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_4575*(node_4575*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_2250 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffColor = lerp(node_7365,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_7365,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_2250*(node_2250*_BlendStrength_D))),_node_3092));
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, _Metallic, specColor, specularMonochrome );
                float roughness = 1.0 - _Gloss;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
