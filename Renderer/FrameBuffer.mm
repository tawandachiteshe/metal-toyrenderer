//
// Created by __declspec on 4/7/2021.
//

#include "FrameBuffer.h"
#import "Renderer.h"

FrameBuffer::FrameBuffer(uint32_t width, uint32_t height) :
        m_Height(height), m_Width(width) {

    MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
    textureDescriptor.width = m_Width;
    textureDescriptor.height = m_Height;
    textureDescriptor.pixelFormat = MTLPixelFormatBGRA8Unorm;
    textureDescriptor.textureType = MTLTextureType2D;
    textureDescriptor.usage = MTLTextureUsageRenderTarget;

    m_Texture = [Renderer::GetDevice() newTextureWithDescriptor:textureDescriptor];

    [textureDescriptor release];
}

id <MTLRenderCommandEncoder> FrameBuffer::GetEncoder() const {
    return encoder;
}

void FrameBuffer::Bind(uint32_t textureID) {


    MTLRenderPassDescriptor *renderPassDesc = [MTLRenderPassDescriptor renderPassDescriptor];
    renderPassDesc.colorAttachments[0].clearColor = MTLClearColorMake(1.0f, 0.1f, 0.1f,
                                                                      0.1f);
    renderPassDesc.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPassDesc.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPassDesc.colorAttachments[0].texture = m_Texture;
    //renderPassDesc.colorAttachments[0].resolveTexture = m_Texture;


    encoder = [Renderer::GetCommandBuffer() renderCommandEncoderWithDescriptor:renderPassDesc];

    [renderPassDesc release];
}

id <MTLTexture> FrameBuffer::GetTexture() const {
    return m_Texture;
}
