//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_SHADER_H
#define UNTITLED_SHADER_H
#import <Metal/Metal.h>
#import <MacTypes.h>
#include <string>
#import <glm/glm.hpp>
#import "VertexBuffer.h"
#import "IndexBuffer.h"

class Shader {

private:
    id<MTLFunction> vertexProgram = nil;
    id<MTLFunction> fragmentProgram = nil;
    id<MTLLibrary> library = nil;
    MTLRenderPipelineDescriptor *pipelineStateDescriptor = nil;
    id<MTLRenderPipelineState> pipelineState = nil;
    MTLVertexDescriptor* m_VertexLayout;
    uint32_t index = 0;
    id<MTLBuffer> uniformBuffer = nil;

    struct VertexBufferUniforms {
        glm::mat4 projectionView =  glm::mat4(1.0f);
        glm::mat4 transform = glm::mat4(1.0f);
    };

    VertexBufferUniforms uniforms;

public:
    Shader(const std::string& srcPath);
    id<MTLRenderPipelineState> GetPipelineState() {return pipelineState;}
    void Bind();
    void SetVertexLayout(MTLVertexDescriptor* vertexLayout);
    void SetMat4(const glm::mat4& mat, uint32_t index = 0);
    void Release();
};


#endif //UNTITLED_SHADER_H
