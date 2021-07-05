//
// Created by __declspec on 4/7/2021.
//

#ifndef UNTITLED_FRAMEBUFFER_H
#define UNTITLED_FRAMEBUFFER_H


#import <cstdint>
#import <Metal/Metal.h>

class FrameBuffer {

private:
    uint32_t m_Width, m_Height = 0;
    id<MTLTexture> m_Texture = nil;
    id<MTLTexture> m_DepthTexture = nil;
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
