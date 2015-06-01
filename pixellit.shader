float4 frag_specmappixellit(v2f input) : COLOR { // Unity light position convention is:
// w = 0, directional light, with x y z pointing in opposite of light direction
// w = 1, point light, with x y z indicating position coordinates
float3 lightDir = normalize(_WorldSpaceLightPos0.xyz - input.vWorldPos * _WorldSpaceLightPos0.w); float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - input.vWorldPos);
float3 h = normalize(lightDir + eyeDir);
// renormalizing because the GPU's interpolator doesn't know this is a unit vector float3 n = normalize(input.nWorld);
//float3 diff_almost = 2*unity_LightColor0.rgb * max(0, dot(n, lightDir));
float w = (1+(dot(n,lightDir)))/2;
float3 diff_almost=lerp(float3(0,0,1),float3(1,1,0),w);
float ndoth = max(0, dot(n, h));
float3 spec_almost = 2*unity_LightColor0.rgb * _SpecColor.rgb * pow(ndoth, _Shininess*128.0); //float3 spec_almost =0;
float4 base = tex2D(_BaseTex, input.tc);
float3 output = (diff_almost + 2*0*UNITY_LIGHTMODEL_AMBIENT.rgb) * base.rgb
+ 0*spec_almost.rgb * base.a; return(float4(output,1));
}