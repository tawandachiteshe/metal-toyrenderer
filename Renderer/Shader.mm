//
// Created by __declspec on 26/6/2021.
//

#import <sstream>
#import <fstream>
#include "Shader.h"
#import "Renderer.h"
#include <glm/gtc/type_ptr.hpp>


Shader::Shader(const std::string &srcPath) {

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

    library = [Renderer::GetDevice() newLibraryWithSource:shaderSrc options:nil error:&error];
    vertexProgram = [library newFunctionWithName:@"vertex_main"];
    fragmentProgram = [library newFunctionWithName:@"fragment_main"];

    if(vertexProgram == nil || fragmentProgram == nil) {
        NSLog(@"Error: failed to create Metal library: %@", error);
    }
}

void Shader::Bind() {
    pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    [pipelineStateDescriptor setVertexFunction:vertexProgram];
    [pipelineStateDescriptor setFragmentFunction:fragmentProgram];
    [pipelineStateDescriptor setVertexDescriptor:m_VertexLayout];
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    pipelineStateDescriptor.colorAttachments[0].blendingEnabled = YES;
    pipelineStateDescriptor.colorAttachments[0].rgbBlendOperation = MTLBlendOperationAdd;
    pipelineStateDescriptor.colorAttachments[0].sourceRGBBlendFactor = MTLBlendFactorSourceAlpha;
    pipelineStateDescriptor.colorAttachments[0].destinationRGBBlendFactor = MTLBlendFactorOneMinusSourceAlpha;
    pipelineStateDescriptor.colorAttachments[0].alphaBlendOperation = MTLBlendOperationAdd;
    pipelineStateDescriptor.colorAttachments[0].sourceAlphaBlendFactor = MTLBlendFactorOne;
    pipelineStateDescriptor.colorAttachments[0].destinationAlphaBlendFactor = MTLBlendFactorOneMinusSourceAlpha;
    pipelineState = [Renderer::GetDevice() newRenderPipelineStateWithDescriptor:pipelineStateDescriptor error:nil];
    [Renderer::GetEncoder() setRenderPipelineState:pipelineState];
}

void Shader::Release() {
    [vertexProgram release];
    [fragmentProgram release];
    [library release];
}

void Shader::SetMat4(const glm::mat4 &mat) {

    [Renderer::GetEncoder() setVertexBytes:glm::value_ptr(mat) length:sizeof(mat) atIndex:1];

}