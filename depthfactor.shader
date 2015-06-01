struct v2f { // vertex to fragment float4 sv: SV_POSITION;
float2 tc: TEXCOORD0; // not same as TEXCOORD0 above
float2 depthFactor:TEXCOORD1; };
v2f vert_texturedstruct(a2v input) {
v2f output;
output.sv = mul(UNITY_MATRIX_MVP, input.v);
// Make sure you TRANSFORM_TEX the vertex shader, not the fragment shader!
float e=5;
float s=-2;
output.depthFactor = (max(0,min(1,(e-output.sv.y)/(e-s))),max(0,min(1,(e-output.sv.y)/(e-s)))); output.tc = (TRANSFORM_TEX(input.tc, _BaseTex));
return output;
}
float4 frag_texturedstruct(v2f input) : COLOR { return(tex2D(_BaseTex, input.tc)*input.depthFactor.y); }