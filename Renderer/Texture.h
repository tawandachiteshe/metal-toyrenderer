//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_TEXTURE_H
#define UNTITLED_TEXTURE_H


#import <string>
#import <Metal/Metal.h>

class Texture {
private:
    std::string filePath;
    id<MTLTexture> m_Texture = nil;
    uint32_t textureID = 0;
    int32_t m_Width, m_Height = 0;

public:
    uint32_t GetTextureID() {return textureID;}
    Texture(const std::string &filePath);
    Texture(uint32_t width, uint32_t height);
    void SetData(void* data, uint32_t size);
    void Bind(uint32_t texId = 0);
    id<MTLTexture>  GetTexture() { return m_Texture; }

};


#endif //UNTITLED_TEXTURE_H
