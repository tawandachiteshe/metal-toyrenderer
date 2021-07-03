//
// Created by __declspec on 26/6/2021.
//

#include "RenderCommand.h"
#import "Renderer.h"

void RenderCommand::DrawIndexed(const std::shared_ptr<VertexBuffer> &vertexBuffer,
                                const std::shared_ptr<IndexBuffer> &indexBuffer, const std::shared_ptr<Shader>& shader, uint32_t count) {

    [Renderer::GetEncoder() setRenderPipelineState:shader->GetPipelineState()];

    [Renderer::GetEncoder() setVertexBuffer:vertexBuffer->GetBuffer() offset:0 atIndex:0];
    [Renderer::GetEncoder() drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:count == 0 ? indexBuffer->GetCount() : count indexType:MTLIndexTypeUInt32
                       indexBuffer:indexBuffer->GetBuffer() indexBufferOffset:0];



}

void RenderCommand::Init() {

}
