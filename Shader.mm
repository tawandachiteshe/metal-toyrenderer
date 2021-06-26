//
// Created by __declspec on 26/6/2021.
//

#import <sstream>
#import <fstream>
#include "Shader.h"
#import "Renderer.h"


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
    pipelineState = [Renderer::GetDevice() newRenderPipelineStateWithDescriptor:pipelineStateDescriptor error:nil];
    [Renderer::GetEncoder() setRenderPipelineState:pipelineState];
}

void Shader::Release() {
    [vertexProgram release];
    [fragmentProgram release];
    [library release];
}
