//
// Created by __declspec on 4/7/2021.
//

#ifndef UNTITLED_FRAMEBUFFER_H
#define UNTITLED_FRAMEBUFFER_H


#import <cstdint>
#import <Metal/Metal.h>
#import <glm/vec4.hpp>

class FrameBuffer {

private:
    uint32_t m_Width, m_Height = 0;
    id<MTLTexture> m_Texture = nil;
    id<MTLTexture> m_DepthTexture = nil;
    glm::vec4 m_ClearColor;
    MTLRenderPassDescriptor *renderPassDesc = nil;
public:

    MTLRenderPassDescriptor* GetRenderPassDesc() { return renderPassDesc; }


    void SetClearColor(const glm::vec4 &mClearColor = glm::vec4(0.3f, 0.3f, 0.3f, 1.0f)) {
        m_ClearColor = mClearColor;
    }

public:
    id <MTLTexture> GetTexture() const;

private:
    id <MTLRenderCommandEncoder> encoder;
public:
    id <MTLRenderCommandEncoder> GetEncoder() const;

public:
    FrameBuffer(uint32_t width, uint32_t height);
    void Bind(uint32_t textureID = 0);

};


#endif //UNTITLED_FRAMEBUFFER_H
