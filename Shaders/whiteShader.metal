#include <metal_stdlib>
using namespace metal;

struct Uniforms {
    float4x4 projectionview;
};

struct VertexIn {
    float3 position [[attribute(0)]];
    float4 color [[attribute(1)]];
    float2 uv [[attribute(2)]];
};

struct VertexOut {

    float4 position [[position]];
    float4 color;
    float2 uv;

};

vertex VertexOut vertex_main(VertexIn in [[stage_in]], constant Uniforms &uniforms [[buffer(1)]]) {
    VertexOut out;
    out.position = uniforms.projectionview * float4(in.position, 1);
    out.color = in.color;
    out.uv = in.uv;
  return out;
}

fragment half4 fragment_main(VertexOut in [[stage_in]], texture2d<half> colorTexture [[ texture(0) ]]) { // 1
    constexpr sampler textureSampler = (mag_filter::linear, min_filter::linear);
    const half4 colorSample = colorTexture.sample(textureSampler, in.uv);
    return colorSample;            // 2
}
