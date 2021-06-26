#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[attribute(0)]];
    float4 color [[attribute(1)]];
};

struct VertexOut {

    float4 position [[position]];
    float4 color;

};

vertex VertexOut vertex_main(VertexIn in [[stage_in]]) {
    VertexOut out;
    out.position = float4(in.position, 1);
    out.color = in.color;
  return out;
}

fragment half4 fragment_main(VertexOut in [[stage_in]]) { // 1
    return half4(in.color);              // 2
}
