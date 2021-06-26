//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_SHADER_H
#define UNTITLED_SHADER_H
#import <Metal/Metal.h>
#import <MacTypes.h>
#include <string>

class Shader {

private:
    id<MTLFunction> vertexProgram = nil;
    id<MTLFunction> fragmentProgram = nil;
    id<MTLLibrary> library = nil;
    MTLRenderPipelineDescriptor *pipelineStateDescriptor = nil;
    id<MTLRenderPipelineState> pipelineState = nil;
    MTLVertexDescriptor* m_VertexLayout;

public:
    Shader(const std::string& srcPath);
    void Bind();
    void SetVertexLayout(MTLVertexDescriptor* vertexLayout) { m_VertexLayout = vertexLayout; }
    void Release();
};


#endif //UNTITLED_SHADER_H
