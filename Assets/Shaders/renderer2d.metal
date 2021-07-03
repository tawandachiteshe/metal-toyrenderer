#include <metal_stdlib>
using namespace metal;

struct Uniforms {
    float4x4 projectionview;
};

struct VertexIn {
    float3 position [[attribute(0)]];
    float4 color [[attribute(1)]];
    float2 uv [[attribute(2)]];
    float textureID [[attribute(3)]];
    float tillingFactor [[attribute(4)]];
};

struct VertexOut {

    float4 position [[position]];
    float4 color;
    float2 uv;
    float tillingFactor;
    float textureID;

};

vertex VertexOut vertex_main(VertexIn in [[stage_in]], constant Uniforms &uniforms [[buffer(1)]]) {
    VertexOut out;
    out.position = uniforms.projectionview * float4(in.position, 1);
    out.color = in.color;
    out.tillingFactor = in.tillingFactor;
    out.uv = in.uv;
    out.textureID = in.textureID;
  return out;
}

//texture2d<half> colorTexture [[ texture(0) ]]
    //constexpr sampler textureSampler = (mag_filter::linear, min_filter::linear);
    //const half4 colorSample = colorTexture.sample(textureSampler, in.uv);

fragment half4 fragment_main(VertexOut in [[stage_in]], texture2d<half> colorTexture [[ texture(0) ]],
                                                        texture2d<half> colorTexture1 [[ texture(1) ]],
                                                        texture2d<half> colorTexture2 [[ texture(2) ]],
                                                        texture2d<half> colorTexture3 [[ texture(3) ]],
                                                        texture2d<half> colorTexture4 [[ texture(4) ]],
                                                        texture2d<half> colorTexture5 [[ texture(6) ]],
                                                        texture2d<half> colorTexture6 [[ texture(7) ]],
                                                        texture2d<half> colorTexture7 [[ texture(8) ]]) { // 1
    constexpr sampler textureSampler = (mag_filter::linear, min_filter::linear, address::repeat);
    half4 colorSample;

    switch(int(in.textureID)) {

        case 0:
            colorSample = colorTexture.sample(textureSampler, in.uv);
            break;
        case 1:
            colorSample = colorTexture1.sample(textureSampler, in.uv * in.tillingFactor);
            break;
        case 2:
             colorSample = colorTexture2.sample(textureSampler, in.uv);
             break;
        case 3:
             colorSample = colorTexture3.sample(textureSampler, in.uv);
             break;
        case 4:
            colorSample = colorTexture4.sample(textureSampler, in.uv);
            break;
        case 5:
            colorSample = colorTexture5.sample(textureSampler, in.uv);
            break;
        case 6:
            colorSample = colorTexture6.sample(textureSampler, in.uv);
            break;
        case 7:
            colorSample = colorTexture7.sample(textureSampler, in.uv);
            break;
        default:
            colorSample = colorTexture.sample(textureSampler, in.uv);



    }

    return colorSample * (half4)in.color; // 2
}
