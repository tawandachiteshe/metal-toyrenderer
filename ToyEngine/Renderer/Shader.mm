//
// Created by __declspec on 26/6/2021.
//

#import <sstream>
#import <fstream>
#include "Shader.h"
#import "Renderer.h"
#include <glm/gtc/type_ptr.hpp>
#import "RenderCommand.h"
#import "InitMetal.h"


#pragma clang diagnostic push
#pragma ide diagnostic ignored "err_typecheck_invalid_operands"


Shader::Shader(const std::string &srcPath) {


    uniformBuffer = [InitMetal::GetDevice() newBufferWithBytes: &uniforms length: sizeof(uniforms) options: MTLResourceStorageModeShared];

    std::ifstream file;
    file.open(srcPath);
    std::string line;
    std::stringstream src;
    while (std::getline(file, line)) {
        src << line << "\n";
    }

    file.close();

    NSString* shaderSrc = [NSString stringWithUTF8String:src.str().data()];
    NSError *error = nil;

    library = [InitMetal::GetDevice() newLibraryWithSource:shaderSrc options:nil error:&error];
    vertexProgram = [library newFunctionWithName:@"vertex_main"];
    fragmentProgram = [library newFunctionWithName:@"fragment_main"];

    if(vertexProgram == nil || fragmentProgram == nil) {
        NSLog(@"Error: failed to create Metal library: %@", error);
    }

    pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
}

void Shader::Bind() {
    [InitMetal::GetCommandEncoder() setRenderPipelineState:pipelineState];
}

void Shader::Release() {
    [vertexProgram release];
    [fragmentProgram release];
    [library release];
    [pipelineState release];
}

void Shader::SetMat4(const glm::mat4 &mat, uint32_t index) {

    VertexBufferUniforms* pBufferUniforms = (VertexBufferUniforms*)uniformBuffer.contents;

    switch (index) {
        case 0:
            memcpy((void *) glm::value_ptr(pBufferUniforms->projectionView), glm::value_ptr(mat), sizeof(mat));
            break;
        case 1:
            memcpy((void *) glm::value_ptr(pBufferUniforms->transform), glm::value_ptr(mat), sizeof(mat));
            break;
        default:
            break;
    }

    [InitMetal::GetCommandEncoder() setVertexBuffer: uniformBuffer offset: 0 atIndex:1];

}

void Shader::SetVertexLayout(MTLVertexDescriptor *vertexLayout) {

    [pipelineStateDescriptor setVertexFunction:vertexProgram];
    [pipelineStateDescriptor setFragmentFunction:fragmentProgram];
    [pipelineStateDescriptor setVertexDescriptor:vertexLayout];
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    pipelineStateDescriptor.colorAttachments[0].blendingEnabled = YES;
    pipelineStateDescriptor.colorAttachments[0].rgbBlendOperation = MTLBlendOperationAdd;
    pipelineStateDescriptor.colorAttachments[0].sourceRGBBlendFactor = MTLBlendFactorSourceAlpha;
    pipelineStateDescriptor.colorAttachments[0].destinationRGBBlendFactor = MTLBlendFactorOneMinusSourceAlpha;
    pipelineStateDescriptor.colorAttachments[0].alphaBlendOperation = MTLBlendOperationAdd;
    pipelineStateDescriptor.colorAttachments[0].sourceAlphaBlendFactor = MTLBlendFactorOne;
    pipelineStateDescriptor.colorAttachments[0].destinationAlphaBlendFactor = MTLBlendFactorOneMinusSourceAlpha;

    NSError* error = NULL;
    MTLRenderPipelineReflection* reflectionObj;
    MTLPipelineOption option = MTLPipelineOptionBufferTypeInfo | MTLPipelineOptionArgumentInfo;

    pipelineState = [InitMetal::GetDevice() newRenderPipelineStateWithDescriptor:pipelineStateDescriptor options:option reflection:&reflectionObj error:&error];



}

#pragma clang diagnostic pop