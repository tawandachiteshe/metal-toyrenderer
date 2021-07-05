//
// Created by __declspec on 25/6/2021.
//

#include "VertexBuffer.h"
#import "Renderer.h"


static MTLVertexFormat ShaderDataTypeToMetal(ShaderDataType dataType)
{
    switch (dataType) {

        case ShaderDataType::Float1:    return MTLVertexFormatFloat;
        case ShaderDataType::Float2:    return MTLVertexFormatFloat2;
        case ShaderDataType::Float3:    return MTLVertexFormatFloat3;
        case ShaderDataType::Float4:    return MTLVertexFormatFloat4;

        case ShaderDataType::Int:       return MTLVertexFormatInt;
        case ShaderDataType::Int2:      return MTLVertexFormatInt2;
        case ShaderDataType::Int3:      return MTLVertexFormatInt3;
        case ShaderDataType::Int4:      return MTLVertexFormatInt4;
        case ShaderDataType::Byte4:     return MTLVertexFormatUChar4;

        case ShaderDataType::None:
            break;
        case ShaderDataType::Mat3:
            break;
        case ShaderDataType::Mat4:
            break;
        case ShaderDataType::Bool:
            break;
    }
    return MTLVertexFormatInvalid;
}


VertexBuffer::VertexBuffer(void *data, uint32_t size) {
    vertexBuffer = [Renderer::GetDevice() newBufferWithBytes:data length:size options:MTLResourceOptionCPUCacheModeDefault];
}


void VertexBuffer::Bind() {

}

void VertexBuffer::SetLayout(const BufferLayout &layout) {

    vertexDescriptor = [MTLVertexDescriptor vertexDescriptor];

    const auto& elements = layout.GetElements();

    for (int i = 0; i < elements.size(); ++i) {
        vertexDescriptor.attributes[i].offset= elements[i].Offset;
        vertexDescriptor.attributes[i].format = ShaderDataTypeToMetal(elements[i].Type);
        vertexDescriptor.attributes[i].bufferIndex = 0;

    }

    vertexDescriptor.layouts[0].stepRate = 1;
    vertexDescriptor.layouts[0].stepFunction = MTLVertexStepFunctionPerVertex;
    vertexDescriptor.layouts[0].stride = layout.GetStride();
}

VertexBuffer::VertexBuffer(uint32_t size) {
    vertexBuffer = [Renderer::GetDevice() newBufferWithLength: size options: MTLResourceStorageModeShared];
}

void VertexBuffer::SetData(void *data, uint32_t size) {

    void* _data = vertexBuffer.contents;

    memcpy(_data, data, size);

}
