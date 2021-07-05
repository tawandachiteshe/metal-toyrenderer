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
    textureDescriptor.usage =  MTLTextureUsageShaderRead | MTLTextureUsageRenderTarget;
   // textureDescriptor.storageMode = MTLStorageModePrivate;

    MTLTextureDescriptor *depthTextureDescriptor = [[MTLTextureDescriptor alloc] init];
    depthTextureDescriptor.width = m_Width;
    depthTextureDescriptor.height = m_Height;
    depthTextureDescriptor.pixelFormat = MTLPixelFormatDepth32Float_Stencil8;
    depthTextureDescriptor.textureType = MTLTextureType2D;
    depthTextureDescriptor.usage = MTLTextureUsageRenderTarget;
    depthTextureDescriptor.storageMode = MTLStorageModePrivate;

    m_Texture = [Renderer::GetDevice() newTextureWithDescriptor:textureDescriptor];
    m_Texture.label = @"FrameBuffer";
    m_DepthTexture = [Renderer::GetDevice() newTextureWithDescriptor:depthTextureDescriptor];


    [textureDescriptor release];
    [depthTextureDescriptor release];
}

id <MTLRenderCommandEncoder> FrameBuffer::GetEncoder() const {
    return encoder;
}

void FrameBuffer::Bind(uint32_t textureID) {


    MTLRenderPassDescriptor *renderPassDesc = [MTLRenderPassDescriptor renderPassDescriptor];
    renderPassDesc.colorAttachments[0].clearColor = MTLClearColorMake(m_ClearColor.r, m_ClearColor.g, m_ClearColor.b,
                                                                      m_ClearColor.a);
    renderPassDesc.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPassDesc.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPassDesc.colorAttachments[0].texture = m_Texture;

    renderPassDesc.depthAttachment.loadAction = MTLLoadActionClear;
    renderPassDesc.depthAttachment.storeAction = MTLStoreActionStore;
    renderPassDesc.depthAttachment.texture = m_DepthTexture;
    renderPassDesc.stencilAttachment.texture = m_DepthTexture;

    encoder = [Renderer::GetCommandBuffer() renderCommandEncoderWithDescriptor:renderPassDesc];
    [renderPassDesc release];
}

id <MTLTexture> FrameBuffer::GetTexture() const {
    return m_Texture;
}
