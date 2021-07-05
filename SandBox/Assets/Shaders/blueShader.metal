vertex float4 vertex_main(                           // 1
  const device packed_float3* vertex_array [[ buffer(0) ]], // 2
  unsigned int vid [[ vertex_id ]]) {                 // 3
  return float4(vertex_array[vid], 1.0);              // 4
}

fragment half4 fragment_main() { // 1
  return half4(0.0, 0.0, 1.0, 1.0);              // 2
}
