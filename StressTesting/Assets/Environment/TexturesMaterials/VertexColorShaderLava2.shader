// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35802,y:32650,varname:node_2865,prsc:2|diff-1597-OUT,spec-151-OUT,gloss-3763-OUT,normal-4887-OUT,emission-4508-OUT;n:type:ShaderForge.SFN_Color,id:9951,x:30401,y:30999,ptovrint:False,ptlb:TintA,ptin:_TintA,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Slider,id:151,x:35198,y:32973,ptovrint:False,ptlb:Metallic_copy,ptin:_Metallic_copy,varname:_Metallic_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:3957,x:34685,y:32774,ptovrint:False,ptlb:Gloss_copy,ptin:_Gloss_copy,varname:_Gloss_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:8438,x:32452,y:31964,varname:node_8438,prsc:2|A-4676-OUT,B-2898-OUT,T-24-OUT;n:type:ShaderForge.SFN_Lerp,id:4676,x:32021,y:31647,varname:node_4676,prsc:2|A-7588-OUT,B-7394-OUT,T-6677-OUT;n:type:ShaderForge.SFN_Lerp,id:7588,x:31556,y:31161,varname:node_7588,prsc:2|A-8823-OUT,B-2136-OUT,T-8627-R;n:type:ShaderForge.SFN_VertexColor,id:8627,x:30571,y:32834,varname:node_8627,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8464,x:31678,y:32828,varname:node_8464,prsc:2|A-8627-A,B-415-OUT;n:type:ShaderForge.SFN_Vector1,id:415,x:31514,y:32948,varname:node_415,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:1597,x:32822,y:32255,varname:node_1597,prsc:2|A-8438-OUT,B-5824-OUT,T-5117-OUT;n:type:ShaderForge.SFN_Tex2d,id:6431,x:30404,y:31517,ptovrint:False,ptlb:colorB,ptin:_colorB,varname:_node_6183_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbe818838f3f8a04c85a28d62f07f957,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:8804,x:30401,y:31157,ptovrint:False,ptlb:colorA,ptin:_colorA,varname:_node_6183_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:246e25d0122e42b4e8693f8b60603801,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9070,x:30393,y:31897,ptovrint:False,ptlb:colorC,ptin:_colorC,varname:_node_6183_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6216567a30477c141b155ee21160b2d9,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9739,x:30393,y:32304,ptovrint:False,ptlb:colorD,ptin:_colorD,varname:_node_6183_copy_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e62ef818f2b48bb45b234f3bdb2e8f7b,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector1,id:902,x:31065,y:30940,varname:node_902,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:8843,x:30605,y:31092,varname:node_8843,prsc:2|A-9951-RGB,B-8804-RGB;n:type:ShaderForge.SFN_Color,id:2102,x:30401,y:31342,ptovrint:False,ptlb:TintB,ptin:_TintB,varname:_TintA_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:4823,x:30735,y:31410,varname:node_4823,prsc:2|A-2102-RGB,B-6431-RGB;n:type:ShaderForge.SFN_Color,id:5286,x:30393,y:31728,ptovrint:False,ptlb:TintC,ptin:_TintC,varname:_TintB_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:7499,x:30591,y:31835,varname:node_7499,prsc:2|A-5286-RGB,B-9070-RGB;n:type:ShaderForge.SFN_Color,id:703,x:30393,y:32095,ptovrint:False,ptlb:TintD,ptin:_TintD,varname:_TintB_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:506,x:30589,y:32215,varname:node_506,prsc:2|A-703-RGB,B-9739-RGB;n:type:ShaderForge.SFN_Multiply,id:1635,x:32135,y:32765,varname:node_1635,prsc:2|A-8464-OUT,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:2524,x:32135,y:33056,varname:node_2524,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:3786,x:32135,y:32906,varname:node_3786,prsc:2|A-5069-RGB,B-2524-OUT;n:type:ShaderForge.SFN_Multiply,id:704,x:32320,y:32765,varname:node_704,prsc:2|A-1635-OUT,B-3786-OUT,C-4522-OUT;n:type:ShaderForge.SFN_Multiply,id:4522,x:32320,y:32906,varname:node_4522,prsc:2|A-3786-OUT,B-9505-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9505,x:31737,y:33988,ptovrint:False,ptlb:BlendStrength_D,ptin:_BlendStrength_D,varname:node_2151,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:4982,x:32489,y:32765,varname:node_4982,prsc:2|IN-704-OUT;n:type:ShaderForge.SFN_Multiply,id:7543,x:31833,y:32353,varname:node_7543,prsc:2|A-8627-B,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:3322,x:31833,y:32644,varname:node_3322,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:8014,x:31833,y:32494,varname:node_8014,prsc:2|A-5069-RGB,B-3322-OUT;n:type:ShaderForge.SFN_Multiply,id:542,x:32018,y:32353,varname:node_542,prsc:2|A-7543-OUT,B-8014-OUT,C-3574-OUT;n:type:ShaderForge.SFN_Multiply,id:3574,x:32018,y:32494,varname:node_3574,prsc:2|A-8014-OUT,B-2800-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2800,x:31737,y:33860,ptovrint:False,ptlb:BlendStrength_C,ptin:_BlendStrength_C,varname:_BlendStrength_D_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:6774,x:32187,y:32353,varname:node_6774,prsc:2|IN-542-OUT;n:type:ShaderForge.SFN_Tex2d,id:5069,x:31011,y:33443,ptovrint:False,ptlb:Bledn_B,ptin:_Bledn_B,varname:_Bledn_D_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6911,x:31518,y:31932,varname:node_6911,prsc:2|A-8627-G,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:9966,x:31518,y:32223,varname:node_9966,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:9763,x:31518,y:32073,varname:node_9763,prsc:2|A-5069-RGB,B-9966-OUT;n:type:ShaderForge.SFN_Multiply,id:6770,x:31703,y:31932,varname:node_6770,prsc:2|A-6911-OUT,B-9763-OUT,C-5463-OUT;n:type:ShaderForge.SFN_Multiply,id:5463,x:31703,y:32073,varname:node_5463,prsc:2|A-9763-OUT,B-8129-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8129,x:31737,y:33729,ptovrint:False,ptlb:BlendStrength_B,ptin:_BlendStrength_B,varname:_BlendStrength_D_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:7422,x:31872,y:31932,varname:node_7422,prsc:2|IN-6770-OUT;n:type:ShaderForge.SFN_Lerp,id:5815,x:31099,y:34247,varname:node_5815,prsc:2|A-822-OUT,B-4785-OUT,T-577-OUT;n:type:ShaderForge.SFN_Lerp,id:822,x:30606,y:33998,varname:node_822,prsc:2|A-2330-OUT,B-2870-OUT,T-6349-OUT;n:type:ShaderForge.SFN_Lerp,id:2330,x:29681,y:33461,varname:node_2330,prsc:2|A-7576-OUT,B-8056-OUT,T-5036-R;n:type:ShaderForge.SFN_VertexColor,id:5036,x:29156,y:35185,varname:node_5036,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4576,x:30335,y:35179,varname:node_4576,prsc:2|A-5036-A,B-6409-OUT;n:type:ShaderForge.SFN_Vector1,id:6409,x:30099,y:35299,varname:node_6409,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:5183,x:31976,y:34620,varname:node_5183,prsc:2|A-5815-OUT,B-4488-OUT,T-724-OUT;n:type:ShaderForge.SFN_Tex2d,id:9457,x:28989,y:33868,ptovrint:False,ptlb:NormalB,ptin:_NormalB,varname:_colorB_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbe818838f3f8a04c85a28d62f07f957,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:9845,x:28990,y:33471,ptovrint:False,ptlb:NormalA,ptin:_NormalA,varname:_colorA_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:246e25d0122e42b4e8693f8b60603801,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:6885,x:28925,y:34248,ptovrint:False,ptlb:NormalC,ptin:_NormalC,varname:_colorC_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6216567a30477c141b155ee21160b2d9,ntxv:3,isnm:True|UVIN-1226-OUT;n:type:ShaderForge.SFN_Tex2d,id:949,x:29030,y:34676,ptovrint:False,ptlb:NormalD,ptin:_NormalD,varname:_colorD_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e62ef818f2b48bb45b234f3bdb2e8f7b,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Vector1,id:5837,x:29650,y:33291,varname:node_5837,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:220,x:30720,y:35116,varname:node_220,prsc:2|A-4576-OUT,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:669,x:30720,y:35407,varname:node_669,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:9326,x:30720,y:35257,varname:node_9326,prsc:2|A-5069-RGB,B-669-OUT;n:type:ShaderForge.SFN_Multiply,id:4116,x:30905,y:35116,varname:node_4116,prsc:2|A-220-OUT,B-9326-OUT,C-6938-OUT;n:type:ShaderForge.SFN_Multiply,id:6938,x:30905,y:35257,varname:node_6938,prsc:2|A-9326-OUT,B-9505-OUT;n:type:ShaderForge.SFN_Clamp01,id:724,x:31076,y:35116,varname:node_724,prsc:2|IN-4116-OUT;n:type:ShaderForge.SFN_Multiply,id:2128,x:30418,y:34704,varname:node_2128,prsc:2|A-5036-B,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:1461,x:30418,y:34995,varname:node_1461,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:971,x:30418,y:34845,varname:node_971,prsc:2|A-5069-RGB,B-1461-OUT;n:type:ShaderForge.SFN_Multiply,id:2404,x:30623,y:34704,varname:node_2404,prsc:2|A-2128-OUT,B-971-OUT,C-6424-OUT;n:type:ShaderForge.SFN_Multiply,id:6424,x:30603,y:34845,varname:node_6424,prsc:2|A-971-OUT,B-2800-OUT;n:type:ShaderForge.SFN_Clamp01,id:577,x:30789,y:34704,varname:node_577,prsc:2|IN-2404-OUT;n:type:ShaderForge.SFN_Multiply,id:2703,x:30092,y:34283,varname:node_2703,prsc:2|A-5036-G,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:5738,x:30092,y:34567,varname:node_5738,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:918,x:30092,y:34424,varname:node_918,prsc:2|A-5069-RGB,B-5738-OUT;n:type:ShaderForge.SFN_Multiply,id:9436,x:30311,y:34306,varname:node_9436,prsc:2|A-2703-OUT,B-918-OUT,C-5687-OUT;n:type:ShaderForge.SFN_Multiply,id:5687,x:30326,y:34445,varname:node_5687,prsc:2|A-918-OUT,B-8129-OUT;n:type:ShaderForge.SFN_Clamp01,id:6349,x:30505,y:34281,varname:node_6349,prsc:2|IN-9436-OUT;n:type:ShaderForge.SFN_Normalize,id:4887,x:35217,y:32763,varname:node_4887,prsc:2|IN-80-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9979,x:28827,y:34481,ptovrint:False,ptlb:NormalC_STR,ptin:_NormalC_STR,varname:node_6915,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:5143,x:28994,y:34438,varname:node_5143,prsc:2|A-9979-OUT,B-9979-OUT;n:type:ShaderForge.SFN_Append,id:7159,x:29138,y:34438,varname:node_7159,prsc:2|A-5143-OUT,B-5090-OUT;n:type:ShaderForge.SFN_Vector1,id:5090,x:28926,y:34606,varname:node_5090,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:4785,x:29252,y:34270,varname:node_4785,prsc:2|A-6885-RGB,B-7159-OUT;n:type:ShaderForge.SFN_Color,id:5880,x:35398,y:32783,ptovrint:False,ptlb:node_5202,ptin:_node_5202,varname:node_5202,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:7514,x:32011,y:33703,ptovrint:False,ptlb:node_3092,ptin:_node_3092,varname:node_3092,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Lerp,id:5117,x:32694,y:32436,varname:node_5117,prsc:2|A-8438-OUT,B-4982-OUT,T-7514-OUT;n:type:ShaderForge.SFN_Lerp,id:3823,x:31426,y:34756,varname:node_3823,prsc:2|A-5815-OUT,B-724-OUT,T-7514-OUT;n:type:ShaderForge.SFN_Slider,id:4510,x:31996,y:33835,ptovrint:False,ptlb:node_3ew,ptin:_node_3ew,varname:_node_3092_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Lerp,id:24,x:32232,y:32078,varname:node_24,prsc:2|A-4676-OUT,B-6774-OUT,T-4510-OUT;n:type:ShaderForge.SFN_Lerp,id:6677,x:31760,y:31713,varname:node_6677,prsc:2|A-7588-OUT,B-7422-OUT,T-393-OUT;n:type:ShaderForge.SFN_Slider,id:393,x:32011,y:33953,ptovrint:False,ptlb:node_3ew_copy,ptin:_node_3ew_copy,varname:_node_3ew_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:8198,x:32966,y:31590,ptovrint:False,ptlb:node_6937,ptin:_node_6937,varname:node_6937,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:66,x:32798,y:32023,ptovrint:False,ptlb:node_3540,ptin:_node_3540,varname:node_3540,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:5824,x:32500,y:32368,varname:node_5824,prsc:2|A-506-OUT,B-8198-RGB,T-66-OUT;n:type:ShaderForge.SFN_Slider,id:4729,x:32798,y:31938,ptovrint:False,ptlb:node_3540_copy,ptin:_node_3540_copy,varname:_node_3540_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1403,x:32798,y:31856,ptovrint:False,ptlb:node_3540_copy_copy,ptin:_node_3540_copy_copy,varname:_node_3540_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:2898,x:32163,y:31940,varname:node_2898,prsc:2|A-7499-OUT,B-8198-RGB,T-4729-OUT;n:type:ShaderForge.SFN_Lerp,id:7394,x:31602,y:31618,varname:node_7394,prsc:2|A-4823-OUT,B-8198-RGB,T-1403-OUT;n:type:ShaderForge.SFN_Slider,id:1106,x:32798,y:31769,ptovrint:False,ptlb:node_3540_copy_copy_copy,ptin:_node_3540_copy_copy_copy,varname:_node_3540_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Lerp,id:2136,x:31313,y:31179,varname:node_2136,prsc:2|A-8843-OUT,B-8198-RGB,T-1106-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2536,x:28745,y:34898,ptovrint:False,ptlb:NormalD_STR,ptin:_NormalD_STR,varname:_node_6915_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:300,x:28922,y:35012,varname:node_300,prsc:2,v1:1;n:type:ShaderForge.SFN_Append,id:1892,x:28922,y:34844,varname:node_1892,prsc:2|A-2536-OUT,B-2536-OUT;n:type:ShaderForge.SFN_Append,id:9296,x:29134,y:34844,varname:node_9296,prsc:2|A-1892-OUT,B-300-OUT;n:type:ShaderForge.SFN_Multiply,id:4488,x:29248,y:34676,varname:node_4488,prsc:2|A-949-RGB,B-9296-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3433,x:28758,y:34096,ptovrint:False,ptlb:NormalB_STR,ptin:_NormalB_STR,varname:_NormalC_STR_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:7992,x:28925,y:34053,varname:node_7992,prsc:2|A-3433-OUT,B-3433-OUT;n:type:ShaderForge.SFN_Append,id:3494,x:29069,y:34053,varname:node_3494,prsc:2|A-7992-OUT,B-4211-OUT;n:type:ShaderForge.SFN_Multiply,id:2870,x:29183,y:33885,varname:node_2870,prsc:2|A-9457-RGB,B-3494-OUT;n:type:ShaderForge.SFN_Vector1,id:4211,x:29203,y:34191,varname:node_4211,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:7989,x:29141,y:33811,varname:node_7989,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:9479,x:28750,y:33699,ptovrint:False,ptlb:NormalA_STR,ptin:_NormalA_STR,varname:_NormalB_STR_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:8736,x:28917,y:33656,varname:node_8736,prsc:2|A-9479-OUT,B-9479-OUT;n:type:ShaderForge.SFN_Append,id:5715,x:29141,y:33638,varname:node_5715,prsc:2|A-8736-OUT,B-7989-OUT;n:type:ShaderForge.SFN_Multiply,id:8056,x:29175,y:33488,varname:node_8056,prsc:2|A-9845-RGB,B-5715-OUT;n:type:ShaderForge.SFN_Tex2d,id:4450,x:34006,y:34128,ptovrint:False,ptlb:TerrainNormal,ptin:_TerrainNormal,varname:node_4332,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_ValueProperty,id:3411,x:31563,y:35691,ptovrint:False,ptlb:TerrainNormal_STR,ptin:_TerrainNormal_STR,varname:_NormalD_STR_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:8515,x:31662,y:35816,varname:node_8515,prsc:2,v1:1;n:type:ShaderForge.SFN_Append,id:2282,x:31955,y:35648,varname:node_2282,prsc:2|A-4368-OUT,B-8515-OUT;n:type:ShaderForge.SFN_Multiply,id:6460,x:31988,y:35480,varname:node_6460,prsc:2|A-4450-RGB,B-2282-OUT;n:type:ShaderForge.SFN_Append,id:4368,x:31730,y:35648,varname:node_4368,prsc:2|A-3411-OUT,B-3411-OUT;n:type:ShaderForge.SFN_NormalBlend,id:2737,x:32443,y:34785,varname:node_2737,prsc:2|BSE-5183-OUT,DTL-6460-OUT;n:type:ShaderForge.SFN_NormalBlend,id:80,x:34416,y:33157,varname:node_80,prsc:2|BSE-4450-RGB,DTL-5183-OUT;n:type:ShaderForge.SFN_Tex2d,id:5256,x:34745,y:33470,ptovrint:False,ptlb:node_5256,ptin:_node_5256,varname:node_5256,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1489-OUT;n:type:ShaderForge.SFN_Lerp,id:5320,x:35229,y:33480,varname:node_5320,prsc:2|A-1294-OUT,B-7862-OUT,T-7448-B;n:type:ShaderForge.SFN_Vector1,id:1294,x:34995,y:33377,varname:node_1294,prsc:2,v1:0;n:type:ShaderForge.SFN_VertexColor,id:7448,x:34935,y:33925,varname:node_7448,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2300,x:35632,y:33283,varname:node_2300,prsc:2|A-8565-OUT,B-6135-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6135,x:35464,y:33391,ptovrint:False,ptlb:node_6135,ptin:_node_6135,varname:node_6135,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:7862,x:35007,y:33502,varname:node_7862,prsc:2|A-5256-RGB,B-5748-RGB;n:type:ShaderForge.SFN_Color,id:5748,x:34807,y:33876,ptovrint:False,ptlb:node_5748,ptin:_node_5748,varname:node_5748,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_TexCoord,id:3920,x:34398,y:33629,varname:node_3920,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Time,id:5162,x:34306,y:33993,varname:node_5162,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7182,x:34599,y:33886,varname:node_7182,prsc:2|A-5162-TSL,B-3720-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7548,x:34296,y:33944,ptovrint:False,ptlb:pppppp_7548,ptin:_pppppp_7548,varname:node_7548,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Panner,id:1523,x:34786,y:33696,varname:node_1523,prsc:2,spu:1,spv:1|UVIN-1208-UVOUT,DIST-7182-OUT;n:type:ShaderForge.SFN_Color,id:2268,x:29078,y:35758,ptovrint:False,ptlb:node_5748_copy,ptin:_node_5748_copy,varname:_node_5748_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_TexCoord,id:563,x:28616,y:35466,varname:node_563,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Time,id:5339,x:28373,y:36291,varname:node_5339,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9601,x:28788,y:35766,varname:node_9601,prsc:2|A-5339-TSL,B-4617-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5362,x:28378,y:35836,ptovrint:False,ptlb:pppppp_7549,ptin:_pppppp_7549,varname:_pppppp_7549,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_Panner,id:454,x:29009,y:35346,varname:node_454,prsc:2,spu:1,spv:1|UVIN-7732-UVOUT,DIST-9601-OUT;n:type:ShaderForge.SFN_Vector1,id:7576,x:29483,y:33362,varname:node_7576,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:8823,x:31467,y:31090,varname:node_8823,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:8565,x:35292,y:33284,varname:node_8565,prsc:2|A-5069-RGB,B-5320-OUT;n:type:ShaderForge.SFN_Color,id:6542,x:34491,y:33316,ptovrint:False,ptlb:node_6542,ptin:_node_6542,varname:node_6542,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7600,x:35341,y:33810,ptovrint:False,ptlb:node_7600,ptin:_node_7600,varname:node_7600,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1523-UVOUT;n:type:ShaderForge.SFN_Add,id:6368,x:36008,y:33527,varname:node_6368,prsc:2|A-2300-OUT,B-7708-OUT;n:type:ShaderForge.SFN_Lerp,id:3102,x:36213,y:33386,varname:node_3102,prsc:2|A-6951-OUT,B-6368-OUT,T-4247-OUT;n:type:ShaderForge.SFN_Vector1,id:6951,x:35874,y:33364,varname:node_6951,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:4803,x:35617,y:33536,varname:node_4803,prsc:2|A-2300-OUT,B-7600-RGB;n:type:ShaderForge.SFN_Multiply,id:9267,x:35306,y:33989,varname:node_9267,prsc:2|A-7448-B,B-1750-OUT;n:type:ShaderForge.SFN_Vector1,id:1750,x:35000,y:34285,varname:node_1750,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:1416,x:35621,y:34102,varname:node_1416,prsc:2|A-7448-B,B-7600-RGB;n:type:ShaderForge.SFN_OneMinus,id:430,x:35621,y:34393,varname:node_430,prsc:2|IN-7600-RGB;n:type:ShaderForge.SFN_Add,id:2123,x:35621,y:34243,varname:node_2123,prsc:2|A-7600-RGB,B-430-OUT;n:type:ShaderForge.SFN_Multiply,id:6980,x:35806,y:34102,varname:node_6980,prsc:2|A-1416-OUT,B-2123-OUT,C-4627-OUT;n:type:ShaderForge.SFN_Multiply,id:4627,x:35806,y:34243,varname:node_4627,prsc:2|A-2123-OUT,B-8845-OUT;n:type:ShaderForge.SFN_Clamp01,id:1109,x:29049,y:35892,varname:node_1109,prsc:2|IN-6980-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8845,x:35450,y:34213,ptovrint:False,ptlb:node_8845,ptin:_node_8845,varname:node_8845,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Multiply,id:7708,x:35843,y:33637,varname:node_7708,prsc:2|A-7600-RGB,B-9899-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9899,x:35680,y:33894,ptovrint:False,ptlb:node_9899,ptin:_node_9899,varname:node_9899,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:2728,x:36490,y:34429,varname:node_2728,prsc:2|A-1523-UVOUT,B-1109-OUT;n:type:ShaderForge.SFN_Multiply,id:4340,x:36258,y:33694,varname:node_4340,prsc:2|A-2728-OUT,B-1109-OUT;n:type:ShaderForge.SFN_Multiply,id:3720,x:34365,y:33792,varname:node_3720,prsc:2|A-5372-OUT,B-7548-OUT;n:type:ShaderForge.SFN_Vector1,id:9627,x:34211,y:33792,varname:node_9627,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:4617,x:28572,y:35728,varname:node_4617,prsc:2|A-6613-OUT,B-5362-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6613,x:28222,y:35628,ptovrint:False,ptlb:node_6613,ptin:_node_6613,varname:node_6613,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_ValueProperty,id:5372,x:34139,y:33735,ptovrint:False,ptlb:node_5372,ptin:_node_5372,varname:node_5372,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:6432,x:29282,y:35444,varname:node_6432,prsc:2|A-454-UVOUT,B-490-OUT;n:type:ShaderForge.SFN_ComponentMask,id:4657,x:27169,y:35690,varname:node_4657,prsc:2,cc1:0,cc2:0,cc3:-1,cc4:-1|IN-5301-R;n:type:ShaderForge.SFN_Vector2,id:7945,x:29411,y:35690,varname:node_7945,prsc:2,v1:1,v2:0;n:type:ShaderForge.SFN_Multiply,id:490,x:29136,y:35518,varname:node_490,prsc:2|A-563-UVOUT,B-7945-OUT;n:type:ShaderForge.SFN_Add,id:1226,x:28474,y:34786,varname:node_1226,prsc:2|A-1290-UVOUT,B-454-UVOUT;n:type:ShaderForge.SFN_Multiply,id:4607,x:27356,y:35690,varname:node_4607,prsc:2|A-6290-OUT,B-4657-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6290,x:26900,y:35953,ptovrint:False,ptlb:node_6613_copy,ptin:_node_6613_copy,varname:_node_6613_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_Multiply,id:6077,x:27544,y:35701,varname:node_6077,prsc:2|A-4607-OUT,B-6290-OUT;n:type:ShaderForge.SFN_Panner,id:1788,x:28311,y:35397,varname:node_1788,prsc:2,spu:1,spv:1|UVIN-6077-OUT,DIST-7786-OUT;n:type:ShaderForge.SFN_Multiply,id:2740,x:27310,y:36130,varname:node_2740,prsc:2|A-6290-OUT,B-5339-TSL;n:type:ShaderForge.SFN_Multiply,id:3401,x:27468,y:36141,varname:node_3401,prsc:2|A-2740-OUT,B-6290-OUT;n:type:ShaderForge.SFN_Multiply,id:6900,x:27644,y:36141,varname:node_6900,prsc:2|A-6290-OUT,B-3401-OUT;n:type:ShaderForge.SFN_Multiply,id:5325,x:27826,y:36156,varname:node_5325,prsc:2|A-6900-OUT,B-6290-OUT;n:type:ShaderForge.SFN_Multiply,id:9246,x:27714,y:35682,varname:node_9246,prsc:2|A-6290-OUT,B-6077-OUT;n:type:ShaderForge.SFN_Add,id:1489,x:34465,y:33521,varname:node_1489,prsc:2|A-9246-OUT,B-1523-UVOUT;n:type:ShaderForge.SFN_Multiply,id:7786,x:27999,y:36108,varname:node_7786,prsc:2|A-5325-OUT,B-6290-OUT;n:type:ShaderForge.SFN_VertexColor,id:5301,x:26680,y:35695,varname:node_5301,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:995,x:26896,y:35575,varname:node_995,prsc:2|IN-5301-R;n:type:ShaderForge.SFN_Add,id:7427,x:29137,y:36087,varname:node_7427,prsc:2|B-2578-OUT;n:type:ShaderForge.SFN_VertexColor,id:9777,x:28196,y:36022,varname:node_9777,prsc:2;n:type:ShaderForge.SFN_OneMinus,id:7857,x:28423,y:36110,varname:node_7857,prsc:2|IN-9777-R;n:type:ShaderForge.SFN_Multiply,id:63,x:28717,y:36232,varname:node_63,prsc:2|A-9777-A,B-7063-OUT;n:type:ShaderForge.SFN_Vector1,id:7063,x:28532,y:36334,varname:node_7063,prsc:2,v1:0.01;n:type:ShaderForge.SFN_Multiply,id:2578,x:28976,y:36217,varname:node_2578,prsc:2|A-7063-OUT,B-63-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7442,x:28531,y:35064,ptovrint:False,ptlb:node_7442,ptin:_node_7442,varname:node_7442,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:6219,x:27797,y:35139,varname:node_6219,prsc:2|A-3778-OUT,B-5449-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:5868,x:27113,y:35062,ptovrint:False,ptlb:node_7442_copy,ptin:_node_7442_copy,varname:_node_7442_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_TexCoord,id:5283,x:27565,y:35235,varname:node_5283,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Panner,id:1290,x:28017,y:35186,varname:node_1290,prsc:2,spu:1,spv:1|UVIN-6219-OUT,DIST-3401-OUT;n:type:ShaderForge.SFN_Multiply,id:6060,x:27393,y:35011,varname:node_6060,prsc:2|A-5868-OUT,B-5301-R;n:type:ShaderForge.SFN_Multiply,id:1947,x:27566,y:34960,varname:node_1947,prsc:2|A-4040-OUT,B-6060-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4040,x:27273,y:34674,ptovrint:False,ptlb:node_4040,ptin:_node_4040,varname:node_4040,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_OneMinus,id:3778,x:27753,y:34951,varname:node_3778,prsc:2|IN-1947-OUT;n:type:ShaderForge.SFN_Clamp01,id:4247,x:35968,y:34085,varname:node_4247,prsc:2|IN-6980-OUT;n:type:ShaderForge.SFN_Multiply,id:7163,x:35637,y:34552,varname:node_7163,prsc:2|A-7448-B,B-5069-RGB;n:type:ShaderForge.SFN_OneMinus,id:5120,x:35637,y:34843,varname:node_5120,prsc:2|IN-5069-RGB;n:type:ShaderForge.SFN_Add,id:7302,x:35637,y:34693,varname:node_7302,prsc:2|A-5069-RGB,B-5120-OUT;n:type:ShaderForge.SFN_Multiply,id:365,x:35822,y:34552,varname:node_365,prsc:2|A-7163-OUT,B-7302-OUT,C-6020-OUT;n:type:ShaderForge.SFN_Multiply,id:6020,x:35822,y:34693,varname:node_6020,prsc:2|A-7302-OUT,B-5293-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5293,x:35466,y:34663,ptovrint:False,ptlb:node_8845_copy,ptin:_node_8845_copy,varname:_node_8845_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Clamp01,id:7965,x:35984,y:34535,varname:node_7965,prsc:2|IN-365-OUT;n:type:ShaderForge.SFN_Lerp,id:4508,x:36445,y:33483,varname:node_4508,prsc:2|A-6951-OUT,B-3102-OUT,T-7965-OUT;n:type:ShaderForge.SFN_Tex2d,id:718,x:34586,y:32902,ptovrint:False,ptlb:node_718,ptin:_node_718,varname:node_718,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:3763,x:35083,y:32823,varname:node_3763,prsc:2|A-3957-OUT,B-3215-OUT,T-4509-G;n:type:ShaderForge.SFN_VertexColor,id:4509,x:34927,y:33072,varname:node_4509,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:329,x:35194,y:32982,ptovrint:False,ptlb:node_329,ptin:_node_329,varname:node_329,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3215,x:34775,y:32900,varname:node_3215,prsc:2|A-718-R,B-7630-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7630,x:34697,y:33059,ptovrint:False,ptlb:node_7630,ptin:_node_7630,varname:node_7630,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Tex2d,id:8966,x:34576,y:33128,ptovrint:False,ptlb:node_8966,ptin:_node_8966,varname:node_8966,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Rotator,id:1208,x:34621,y:33696,varname:node_1208,prsc:2|UVIN-3920-UVOUT,ANG-9840-OUT;n:type:ShaderForge.SFN_Vector1,id:9840,x:34480,y:33792,varname:node_9840,prsc:2,v1:1;n:type:ShaderForge.SFN_Rotator,id:5449,x:27791,y:35344,varname:node_5449,prsc:2|UVIN-5283-UVOUT,ANG-562-OUT;n:type:ShaderForge.SFN_Vector1,id:562,x:27641,y:35431,varname:node_562,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4294,x:28703,y:35613,varname:node_4294,prsc:2,v1:1;n:type:ShaderForge.SFN_Rotator,id:7732,x:28853,y:35526,varname:node_7732,prsc:2|UVIN-563-UVOUT,ANG-4294-OUT;proporder:9505-2800-5069-8129-9457-9845-6885-949-9979-2536-3433-9479-4450-151-3957-9951-6431-8804-9070-9739-2102-5286-703-7514-4510-393-8198-66-4729-1403-1106-5256-6135-5748-7548-5362-7600-8845-9899-6613-5372-6290-7442-5868-4040-5293-718-7630;pass:END;sub:END;*/

Shader "Shader Forge/VertexColorShaderLava2" {
    Properties {
        _BlendStrength_D ("BlendStrength_D", Float ) = 3
        _BlendStrength_C ("BlendStrength_C", Float ) = 3
        _Bledn_B ("Bledn_B", 2D) = "white" {}
        _BlendStrength_B ("BlendStrength_B", Float ) = 3
        _NormalB ("NormalB", 2D) = "bump" {}
        _NormalA ("NormalA", 2D) = "bump" {}
        _NormalC ("NormalC", 2D) = "bump" {}
        _NormalD ("NormalD", 2D) = "bump" {}
        _NormalC_STR ("NormalC_STR", Float ) = 0.1
        _NormalD_STR ("NormalD_STR", Float ) = 0.1
        _NormalB_STR ("NormalB_STR", Float ) = 0.1
        _NormalA_STR ("NormalA_STR", Float ) = 0.1
        _TerrainNormal ("TerrainNormal", 2D) = "bump" {}
        _Metallic_copy ("Metallic_copy", Range(0, 1)) = 0
        _Gloss_copy ("Gloss_copy", Range(0, 1)) = 0
        _TintA ("TintA", Color) = (1,1,1,1)
        _colorB ("colorB", 2D) = "white" {}
        _colorA ("colorA", 2D) = "white" {}
        _colorC ("colorC", 2D) = "white" {}
        _colorD ("colorD", 2D) = "white" {}
        _TintB ("TintB", Color) = (1,1,1,1)
        _TintC ("TintC", Color) = (1,1,1,1)
        _TintD ("TintD", Color) = (1,1,1,1)
        _node_3092 ("node_3092", Range(0, 1)) = 1
        _node_3ew ("node_3ew", Range(0, 1)) = 1
        _node_3ew_copy ("node_3ew_copy", Range(0, 1)) = 1
        _node_6937 ("node_6937", 2D) = "white" {}
        _node_3540 ("node_3540", Range(0, 1)) = 0
        _node_3540_copy ("node_3540_copy", Range(0, 1)) = 0
        _node_3540_copy_copy ("node_3540_copy_copy", Range(0, 1)) = 0
        _node_3540_copy_copy_copy ("node_3540_copy_copy_copy", Range(0, 1)) = 0
        _node_5256 ("node_5256", 2D) = "white" {}
        _node_6135 ("node_6135", Float ) = 0
        _node_5748 ("node_5748", Color) = (1,1,1,1)
        _pppppp_7548 ("pppppp_7548", Float ) = 0
        _pppppp_7549 ("pppppp_7549", Float ) = 0.01
        _node_7600 ("node_7600", 2D) = "white" {}
        _node_8845 ("node_8845", Float ) = 3
        _node_9899 ("node_9899", Float ) = 0
        _node_6613 ("node_6613", Float ) = 0.2
        _node_5372 ("node_5372", Float ) = 0.1
        _node_6613_copy ("node_6613_copy", Float ) = 0.01
        _node_7442 ("node_7442", Float ) = 0.1
        _node_7442_copy ("node_7442_copy", Float ) = 0.2
        _node_4040 ("node_4040", Float ) = 0.1
        _node_8845_copy ("node_8845_copy", Float ) = 3
        _node_718 ("node_718", 2D) = "white" {}
        _node_7630 ("node_7630", Float ) = 0
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
            uniform float _Metallic_copy;
            uniform float _Gloss_copy;
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
            uniform sampler2D _NormalB; uniform float4 _NormalB_ST;
            uniform sampler2D _NormalA; uniform float4 _NormalA_ST;
            uniform sampler2D _NormalC; uniform float4 _NormalC_ST;
            uniform sampler2D _NormalD; uniform float4 _NormalD_ST;
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
            uniform sampler2D _node_5256; uniform float4 _node_5256_ST;
            uniform float _node_6135;
            uniform float4 _node_5748;
            uniform float _pppppp_7548;
            uniform float _pppppp_7549;
            uniform sampler2D _node_7600; uniform float4 _node_7600_ST;
            uniform float _node_8845;
            uniform float _node_9899;
            uniform float _node_6613;
            uniform float _node_5372;
            uniform float _node_6613_copy;
            uniform float _node_7442_copy;
            uniform float _node_4040;
            uniform float _node_8845_copy;
            uniform sampler2D _node_718; uniform float4 _node_718_ST;
            uniform float _node_7630;
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
                float node_7576 = 0.0;
                float3 _NormalA_var = UnpackNormal(tex2D(_NormalA,TRANSFORM_TEX(i.uv0, _NormalA)));
                float3 _NormalB_var = UnpackNormal(tex2D(_NormalB,TRANSFORM_TEX(i.uv0, _NormalB)));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_918 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float4 node_5339 = _Time;
                float node_3401 = ((_node_6613_copy*node_5339.r)*_node_6613_copy);
                float node_5449_ang = 1.0;
                float node_5449_spd = 1.0;
                float node_5449_cos = cos(node_5449_spd*node_5449_ang);
                float node_5449_sin = sin(node_5449_spd*node_5449_ang);
                float2 node_5449_piv = float2(0.5,0.5);
                float2 node_5449 = (mul(i.uv2-node_5449_piv,float2x2( node_5449_cos, -node_5449_sin, node_5449_sin, node_5449_cos))+node_5449_piv);
                float node_7732_ang = 1.0;
                float node_7732_spd = 1.0;
                float node_7732_cos = cos(node_7732_spd*node_7732_ang);
                float node_7732_sin = sin(node_7732_spd*node_7732_ang);
                float2 node_7732_piv = float2(0.5,0.5);
                float2 node_7732 = (mul(i.uv2-node_7732_piv,float2x2( node_7732_cos, -node_7732_sin, node_7732_sin, node_7732_cos))+node_7732_piv);
                float2 node_454 = (node_7732+(node_5339.r*(_node_6613*_pppppp_7549))*float2(1,1));
                float2 node_1226 = ((((1.0 - (_node_4040*(_node_7442_copy*i.vertexColor.r)))*node_5449)+node_3401*float2(1,1))+node_454);
                float3 _NormalC_var = UnpackNormal(tex2D(_NormalC,TRANSFORM_TEX(node_1226, _NormalC)));
                float3 node_971 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_5815 = lerp(lerp(lerp(float3(node_7576,node_7576,node_7576),(_NormalA_var.rgb*float3(float2(_NormalA_STR,_NormalA_STR),1.0)),i.vertexColor.r),(_NormalB_var.rgb*float3(float2(_NormalB_STR,_NormalB_STR),1.0)),saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_918*(node_918*_BlendStrength_B)))),(_NormalC_var.rgb*float3(float2(_NormalC_STR,_NormalC_STR),1.0)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_971*(node_971*_BlendStrength_C))));
                float3 _NormalD_var = UnpackNormal(tex2D(_NormalD,TRANSFORM_TEX(i.uv0, _NormalD)));
                float3 node_9326 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_724 = saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_9326*(node_9326*_BlendStrength_D)));
                float3 node_5183 = lerp(node_5815,(_NormalD_var.rgb*float3(float2(_NormalD_STR,_NormalD_STR),1.0)),node_724);
                float3 node_80_nrm_base = _TerrainNormal_var.rgb + float3(0,0,1);
                float3 node_80_nrm_detail = node_5183 * float3(-1,-1,1);
                float3 node_80_nrm_combined = node_80_nrm_base*dot(node_80_nrm_base, node_80_nrm_detail)/node_80_nrm_base.z - node_80_nrm_detail;
                float3 node_80 = node_80_nrm_combined;
                float3 normalLocal = normalize(node_80);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _node_718_var = tex2D(_node_718,TRANSFORM_TEX(i.uv0, _node_718));
                float gloss = lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
                float perceptualRoughness = 1.0 - lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
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
                float3 specularColor = _Metallic_copy;
                float specularMonochrome;
                float node_8823 = 0.0;
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_7588 = lerp(float3(node_8823,node_8823,node_8823),lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_9763 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_4676 = lerp(node_7588,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_7588,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_9763*(node_9763*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_8014 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_8438 = lerp(node_4676,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_4676,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8014*(node_8014*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_3786 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffuseColor = lerp(node_8438,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_8438,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_3786*(node_3786*_BlendStrength_D))),_node_3092)); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
/////// Diffuse:
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
////// Emissive:
                float node_6951 = 0.0;
                float node_1294 = 0.0;
                float2 node_6077 = ((_node_6613_copy*i.vertexColor.r.rr)*_node_6613_copy);
                float4 node_5162 = _Time;
                float node_1208_ang = 1.0;
                float node_1208_spd = 1.0;
                float node_1208_cos = cos(node_1208_spd*node_1208_ang);
                float node_1208_sin = sin(node_1208_spd*node_1208_ang);
                float2 node_1208_piv = float2(0.5,0.5);
                float2 node_1208 = (mul(i.uv2-node_1208_piv,float2x2( node_1208_cos, -node_1208_sin, node_1208_sin, node_1208_cos))+node_1208_piv);
                float2 node_1523 = (node_1208+(node_5162.r*(_node_5372*_pppppp_7548))*float2(1,1));
                float2 node_1489 = ((_node_6613_copy*node_6077)+node_1523);
                float4 _node_5256_var = tex2D(_node_5256,TRANSFORM_TEX(node_1489, _node_5256));
                float3 node_2300 = ((_Bledn_B_var.rgb*lerp(float3(node_1294,node_1294,node_1294),(_node_5256_var.rgb*_node_5748.rgb),i.vertexColor.b))*_node_6135);
                float4 _node_7600_var = tex2D(_node_7600,TRANSFORM_TEX(node_1523, _node_7600));
                float3 node_2123 = (_node_7600_var.rgb+(1.0 - _node_7600_var.rgb));
                float3 node_6980 = ((i.vertexColor.b*_node_7600_var.rgb)*node_2123*(node_2123*_node_8845));
                float3 node_7302 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 emissive = lerp(float3(node_6951,node_6951,node_6951),lerp(float3(node_6951,node_6951,node_6951),(node_2300+(_node_7600_var.rgb*_node_9899)),saturate(node_6980)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_7302*(node_7302*_node_8845_copy))));
/// Final Color:
                outDiffuse = half4( diffuseColor, 1 );
                outSpecSmoothness = half4( specularColor, gloss );
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( lerp(float3(node_6951,node_6951,node_6951),lerp(float3(node_6951,node_6951,node_6951),(node_2300+(_node_7600_var.rgb*_node_9899)),saturate(node_6980)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_7302*(node_7302*_node_8845_copy)))), 1 );
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
            uniform float _Metallic_copy;
            uniform float _Gloss_copy;
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
            uniform sampler2D _NormalB; uniform float4 _NormalB_ST;
            uniform sampler2D _NormalA; uniform float4 _NormalA_ST;
            uniform sampler2D _NormalC; uniform float4 _NormalC_ST;
            uniform sampler2D _NormalD; uniform float4 _NormalD_ST;
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
            uniform sampler2D _node_5256; uniform float4 _node_5256_ST;
            uniform float _node_6135;
            uniform float4 _node_5748;
            uniform float _pppppp_7548;
            uniform float _pppppp_7549;
            uniform sampler2D _node_7600; uniform float4 _node_7600_ST;
            uniform float _node_8845;
            uniform float _node_9899;
            uniform float _node_6613;
            uniform float _node_5372;
            uniform float _node_6613_copy;
            uniform float _node_7442_copy;
            uniform float _node_4040;
            uniform float _node_8845_copy;
            uniform sampler2D _node_718; uniform float4 _node_718_ST;
            uniform float _node_7630;
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
                float node_7576 = 0.0;
                float3 _NormalA_var = UnpackNormal(tex2D(_NormalA,TRANSFORM_TEX(i.uv0, _NormalA)));
                float3 _NormalB_var = UnpackNormal(tex2D(_NormalB,TRANSFORM_TEX(i.uv0, _NormalB)));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_918 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float4 node_5339 = _Time;
                float node_3401 = ((_node_6613_copy*node_5339.r)*_node_6613_copy);
                float node_5449_ang = 1.0;
                float node_5449_spd = 1.0;
                float node_5449_cos = cos(node_5449_spd*node_5449_ang);
                float node_5449_sin = sin(node_5449_spd*node_5449_ang);
                float2 node_5449_piv = float2(0.5,0.5);
                float2 node_5449 = (mul(i.uv2-node_5449_piv,float2x2( node_5449_cos, -node_5449_sin, node_5449_sin, node_5449_cos))+node_5449_piv);
                float node_7732_ang = 1.0;
                float node_7732_spd = 1.0;
                float node_7732_cos = cos(node_7732_spd*node_7732_ang);
                float node_7732_sin = sin(node_7732_spd*node_7732_ang);
                float2 node_7732_piv = float2(0.5,0.5);
                float2 node_7732 = (mul(i.uv2-node_7732_piv,float2x2( node_7732_cos, -node_7732_sin, node_7732_sin, node_7732_cos))+node_7732_piv);
                float2 node_454 = (node_7732+(node_5339.r*(_node_6613*_pppppp_7549))*float2(1,1));
                float2 node_1226 = ((((1.0 - (_node_4040*(_node_7442_copy*i.vertexColor.r)))*node_5449)+node_3401*float2(1,1))+node_454);
                float3 _NormalC_var = UnpackNormal(tex2D(_NormalC,TRANSFORM_TEX(node_1226, _NormalC)));
                float3 node_971 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_5815 = lerp(lerp(lerp(float3(node_7576,node_7576,node_7576),(_NormalA_var.rgb*float3(float2(_NormalA_STR,_NormalA_STR),1.0)),i.vertexColor.r),(_NormalB_var.rgb*float3(float2(_NormalB_STR,_NormalB_STR),1.0)),saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_918*(node_918*_BlendStrength_B)))),(_NormalC_var.rgb*float3(float2(_NormalC_STR,_NormalC_STR),1.0)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_971*(node_971*_BlendStrength_C))));
                float3 _NormalD_var = UnpackNormal(tex2D(_NormalD,TRANSFORM_TEX(i.uv0, _NormalD)));
                float3 node_9326 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_724 = saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_9326*(node_9326*_BlendStrength_D)));
                float3 node_5183 = lerp(node_5815,(_NormalD_var.rgb*float3(float2(_NormalD_STR,_NormalD_STR),1.0)),node_724);
                float3 node_80_nrm_base = _TerrainNormal_var.rgb + float3(0,0,1);
                float3 node_80_nrm_detail = node_5183 * float3(-1,-1,1);
                float3 node_80_nrm_combined = node_80_nrm_base*dot(node_80_nrm_base, node_80_nrm_detail)/node_80_nrm_base.z - node_80_nrm_detail;
                float3 node_80 = node_80_nrm_combined;
                float3 normalLocal = normalize(node_80);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _node_718_var = tex2D(_node_718,TRANSFORM_TEX(i.uv0, _node_718));
                float gloss = lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
                float perceptualRoughness = 1.0 - lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
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
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic_copy;
                float specularMonochrome;
                float node_8823 = 0.0;
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_7588 = lerp(float3(node_8823,node_8823,node_8823),lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_9763 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_4676 = lerp(node_7588,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_7588,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_9763*(node_9763*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_8014 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_8438 = lerp(node_4676,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_4676,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8014*(node_8014*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_3786 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffuseColor = lerp(node_8438,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_8438,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_3786*(node_3786*_BlendStrength_D))),_node_3092)); // Need this for specular when using metallic
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
////// Emissive:
                float node_6951 = 0.0;
                float node_1294 = 0.0;
                float2 node_6077 = ((_node_6613_copy*i.vertexColor.r.rr)*_node_6613_copy);
                float4 node_5162 = _Time;
                float node_1208_ang = 1.0;
                float node_1208_spd = 1.0;
                float node_1208_cos = cos(node_1208_spd*node_1208_ang);
                float node_1208_sin = sin(node_1208_spd*node_1208_ang);
                float2 node_1208_piv = float2(0.5,0.5);
                float2 node_1208 = (mul(i.uv2-node_1208_piv,float2x2( node_1208_cos, -node_1208_sin, node_1208_sin, node_1208_cos))+node_1208_piv);
                float2 node_1523 = (node_1208+(node_5162.r*(_node_5372*_pppppp_7548))*float2(1,1));
                float2 node_1489 = ((_node_6613_copy*node_6077)+node_1523);
                float4 _node_5256_var = tex2D(_node_5256,TRANSFORM_TEX(node_1489, _node_5256));
                float3 node_2300 = ((_Bledn_B_var.rgb*lerp(float3(node_1294,node_1294,node_1294),(_node_5256_var.rgb*_node_5748.rgb),i.vertexColor.b))*_node_6135);
                float4 _node_7600_var = tex2D(_node_7600,TRANSFORM_TEX(node_1523, _node_7600));
                float3 node_2123 = (_node_7600_var.rgb+(1.0 - _node_7600_var.rgb));
                float3 node_6980 = ((i.vertexColor.b*_node_7600_var.rgb)*node_2123*(node_2123*_node_8845));
                float3 node_7302 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 emissive = lerp(float3(node_6951,node_6951,node_6951),lerp(float3(node_6951,node_6951,node_6951),(node_2300+(_node_7600_var.rgb*_node_9899)),saturate(node_6980)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_7302*(node_7302*_node_8845_copy))));
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
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
            uniform float _Metallic_copy;
            uniform float _Gloss_copy;
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
            uniform sampler2D _NormalB; uniform float4 _NormalB_ST;
            uniform sampler2D _NormalA; uniform float4 _NormalA_ST;
            uniform sampler2D _NormalC; uniform float4 _NormalC_ST;
            uniform sampler2D _NormalD; uniform float4 _NormalD_ST;
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
            uniform sampler2D _node_5256; uniform float4 _node_5256_ST;
            uniform float _node_6135;
            uniform float4 _node_5748;
            uniform float _pppppp_7548;
            uniform float _pppppp_7549;
            uniform sampler2D _node_7600; uniform float4 _node_7600_ST;
            uniform float _node_8845;
            uniform float _node_9899;
            uniform float _node_6613;
            uniform float _node_5372;
            uniform float _node_6613_copy;
            uniform float _node_7442_copy;
            uniform float _node_4040;
            uniform float _node_8845_copy;
            uniform sampler2D _node_718; uniform float4 _node_718_ST;
            uniform float _node_7630;
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
                float node_7576 = 0.0;
                float3 _NormalA_var = UnpackNormal(tex2D(_NormalA,TRANSFORM_TEX(i.uv0, _NormalA)));
                float3 _NormalB_var = UnpackNormal(tex2D(_NormalB,TRANSFORM_TEX(i.uv0, _NormalB)));
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float3 node_918 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float4 node_5339 = _Time;
                float node_3401 = ((_node_6613_copy*node_5339.r)*_node_6613_copy);
                float node_5449_ang = 1.0;
                float node_5449_spd = 1.0;
                float node_5449_cos = cos(node_5449_spd*node_5449_ang);
                float node_5449_sin = sin(node_5449_spd*node_5449_ang);
                float2 node_5449_piv = float2(0.5,0.5);
                float2 node_5449 = (mul(i.uv2-node_5449_piv,float2x2( node_5449_cos, -node_5449_sin, node_5449_sin, node_5449_cos))+node_5449_piv);
                float node_7732_ang = 1.0;
                float node_7732_spd = 1.0;
                float node_7732_cos = cos(node_7732_spd*node_7732_ang);
                float node_7732_sin = sin(node_7732_spd*node_7732_ang);
                float2 node_7732_piv = float2(0.5,0.5);
                float2 node_7732 = (mul(i.uv2-node_7732_piv,float2x2( node_7732_cos, -node_7732_sin, node_7732_sin, node_7732_cos))+node_7732_piv);
                float2 node_454 = (node_7732+(node_5339.r*(_node_6613*_pppppp_7549))*float2(1,1));
                float2 node_1226 = ((((1.0 - (_node_4040*(_node_7442_copy*i.vertexColor.r)))*node_5449)+node_3401*float2(1,1))+node_454);
                float3 _NormalC_var = UnpackNormal(tex2D(_NormalC,TRANSFORM_TEX(node_1226, _NormalC)));
                float3 node_971 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_5815 = lerp(lerp(lerp(float3(node_7576,node_7576,node_7576),(_NormalA_var.rgb*float3(float2(_NormalA_STR,_NormalA_STR),1.0)),i.vertexColor.r),(_NormalB_var.rgb*float3(float2(_NormalB_STR,_NormalB_STR),1.0)),saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_918*(node_918*_BlendStrength_B)))),(_NormalC_var.rgb*float3(float2(_NormalC_STR,_NormalC_STR),1.0)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_971*(node_971*_BlendStrength_C))));
                float3 _NormalD_var = UnpackNormal(tex2D(_NormalD,TRANSFORM_TEX(i.uv0, _NormalD)));
                float3 node_9326 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_724 = saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_9326*(node_9326*_BlendStrength_D)));
                float3 node_5183 = lerp(node_5815,(_NormalD_var.rgb*float3(float2(_NormalD_STR,_NormalD_STR),1.0)),node_724);
                float3 node_80_nrm_base = _TerrainNormal_var.rgb + float3(0,0,1);
                float3 node_80_nrm_detail = node_5183 * float3(-1,-1,1);
                float3 node_80_nrm_combined = node_80_nrm_base*dot(node_80_nrm_base, node_80_nrm_detail)/node_80_nrm_base.z - node_80_nrm_detail;
                float3 node_80 = node_80_nrm_combined;
                float3 normalLocal = normalize(node_80);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _node_718_var = tex2D(_node_718,TRANSFORM_TEX(i.uv0, _node_718));
                float gloss = lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
                float perceptualRoughness = 1.0 - lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic_copy;
                float specularMonochrome;
                float node_8823 = 0.0;
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_7588 = lerp(float3(node_8823,node_8823,node_8823),lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_9763 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_4676 = lerp(node_7588,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_7588,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_9763*(node_9763*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_8014 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_8438 = lerp(node_4676,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_4676,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8014*(node_8014*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_3786 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffuseColor = lerp(node_8438,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_8438,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_3786*(node_3786*_BlendStrength_D))),_node_3092)); // Need this for specular when using metallic
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
            uniform float _Metallic_copy;
            uniform float _Gloss_copy;
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
            uniform float _node_3092;
            uniform float _node_3ew;
            uniform float _node_3ew_copy;
            uniform sampler2D _node_6937; uniform float4 _node_6937_ST;
            uniform float _node_3540;
            uniform float _node_3540_copy;
            uniform float _node_3540_copy_copy;
            uniform float _node_3540_copy_copy_copy;
            uniform sampler2D _node_5256; uniform float4 _node_5256_ST;
            uniform float _node_6135;
            uniform float4 _node_5748;
            uniform float _pppppp_7548;
            uniform sampler2D _node_7600; uniform float4 _node_7600_ST;
            uniform float _node_8845;
            uniform float _node_9899;
            uniform float _node_5372;
            uniform float _node_6613_copy;
            uniform float _node_8845_copy;
            uniform sampler2D _node_718; uniform float4 _node_718_ST;
            uniform float _node_7630;
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
                
                float node_6951 = 0.0;
                float4 _Bledn_B_var = tex2D(_Bledn_B,TRANSFORM_TEX(i.uv0, _Bledn_B));
                float node_1294 = 0.0;
                float2 node_6077 = ((_node_6613_copy*i.vertexColor.r.rr)*_node_6613_copy);
                float4 node_5162 = _Time;
                float node_1208_ang = 1.0;
                float node_1208_spd = 1.0;
                float node_1208_cos = cos(node_1208_spd*node_1208_ang);
                float node_1208_sin = sin(node_1208_spd*node_1208_ang);
                float2 node_1208_piv = float2(0.5,0.5);
                float2 node_1208 = (mul(i.uv2-node_1208_piv,float2x2( node_1208_cos, -node_1208_sin, node_1208_sin, node_1208_cos))+node_1208_piv);
                float2 node_1523 = (node_1208+(node_5162.r*(_node_5372*_pppppp_7548))*float2(1,1));
                float2 node_1489 = ((_node_6613_copy*node_6077)+node_1523);
                float4 _node_5256_var = tex2D(_node_5256,TRANSFORM_TEX(node_1489, _node_5256));
                float3 node_2300 = ((_Bledn_B_var.rgb*lerp(float3(node_1294,node_1294,node_1294),(_node_5256_var.rgb*_node_5748.rgb),i.vertexColor.b))*_node_6135);
                float4 _node_7600_var = tex2D(_node_7600,TRANSFORM_TEX(node_1523, _node_7600));
                float3 node_2123 = (_node_7600_var.rgb+(1.0 - _node_7600_var.rgb));
                float3 node_6980 = ((i.vertexColor.b*_node_7600_var.rgb)*node_2123*(node_2123*_node_8845));
                float3 node_7302 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                o.Emission = lerp(float3(node_6951,node_6951,node_6951),lerp(float3(node_6951,node_6951,node_6951),(node_2300+(_node_7600_var.rgb*_node_9899)),saturate(node_6980)),saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_7302*(node_7302*_node_8845_copy))));
                
                float node_8823 = 0.0;
                float4 _colorA_var = tex2D(_colorA,TRANSFORM_TEX(i.uv0, _colorA));
                float4 _node_6937_var = tex2D(_node_6937,TRANSFORM_TEX(i.uv0, _node_6937));
                float3 node_7588 = lerp(float3(node_8823,node_8823,node_8823),lerp((_TintA.rgb*_colorA_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy_copy),i.vertexColor.r);
                float4 _colorB_var = tex2D(_colorB,TRANSFORM_TEX(i.uv0, _colorB));
                float3 node_9763 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_4676 = lerp(node_7588,lerp((_TintB.rgb*_colorB_var.rgb),_node_6937_var.rgb,_node_3540_copy_copy),lerp(node_7588,saturate(((i.vertexColor.g*_Bledn_B_var.rgb)*node_9763*(node_9763*_BlendStrength_B))),_node_3ew_copy));
                float4 _colorC_var = tex2D(_colorC,TRANSFORM_TEX(i.uv0, _colorC));
                float3 node_8014 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 node_8438 = lerp(node_4676,lerp((_TintC.rgb*_colorC_var.rgb),_node_6937_var.rgb,_node_3540_copy),lerp(node_4676,saturate(((i.vertexColor.b*_Bledn_B_var.rgb)*node_8014*(node_8014*_BlendStrength_C))),_node_3ew));
                float4 _colorD_var = tex2D(_colorD,TRANSFORM_TEX(i.uv0, _colorD));
                float3 node_3786 = (_Bledn_B_var.rgb+(1.0 - _Bledn_B_var.rgb));
                float3 diffColor = lerp(node_8438,lerp((_TintD.rgb*_colorD_var.rgb),_node_6937_var.rgb,_node_3540),lerp(node_8438,saturate((((i.vertexColor.a*1.0)*_Bledn_B_var.rgb)*node_3786*(node_3786*_BlendStrength_D))),_node_3092));
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, _Metallic_copy, specColor, specularMonochrome );
                float4 _node_718_var = tex2D(_node_718,TRANSFORM_TEX(i.uv0, _node_718));
                float roughness = 1.0 - lerp(_Gloss_copy,(_node_718_var.r*_node_7630),i.vertexColor.g);
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
