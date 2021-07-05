//
// Created by __declspec on 26/6/2021.
//

#include "RenderCommand.h"
#import "Renderer.h"

id<MTLRenderCommandEncoder> RenderCommand::commandEncoder = nil;
MTLRenderPassDescriptor* RenderCommand::renderPassDescriptor = nil;

void RenderCommand::DrawIndexed(const std::shared_ptr<VertexBuffer> &vertexBuffer,
                                const std::shared_ptr<IndexBuffer> &indexBuffer, const std::shared_ptr<Shader>& shader, uint32_t count) {


}

void RenderCommand::Init() {

}

void RenderCommand::SetCommandEncoder(id <MTLRenderCommandEncoder> encoder) {

    RenderCommand::commandEncoder = encoder;
}

id <MTLRenderCommandEncoder> RenderCommand::GetCommandEncoder() {
    return commandEncoder;
}

void RenderCommand::EndCommandEncoder() {
    [commandEncoder endEncoding];
    [commandEncoder release];
}

