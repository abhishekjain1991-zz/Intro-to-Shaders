v2f vert_specmappixellit(a2v input) { v2f output;
output.sv = mul(UNITY_MATRIX_MVP, input.v);
output.vWorldPos = mul(_Object2World, input.v).xyz;
// To transform normals, we want to use the inverse transpose of upper left 3x3
// Putting input.n in first argument is like doing trans((float3x3)_World2Object) * input.n; output.nWorld = normalize(mul(input.n, (float3x3) _World2Object));
output.tWorld = normalize(mul((float3x3) _Object2World, input.t.xyz));
output.btWorld = normalize(cross(output.nWorld, output.tWorld)
* input.t.w); // Flip tangents if needed (memory saving trick) float A=0.2;
float B=1;
float C=3;
float D=0.02;
float E=5;
float F=6;
input.tc.x+=A*sin(B*input.tc.y)*sin(C*_Time.x); input.tc.y+=D*sin(E*input.tc.x)*sin(F*_Time.x); output.bmap_tc = TRANSFORM_TEX(input.tc, _BaseTex); output.nmap_tc = TRANSFORM_TEX(input.tc, _NormalMap); return output;
}