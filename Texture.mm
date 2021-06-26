//
// Created by __declspec on 26/6/2021.
//

#include "Texture.h"
#import "third_party/stb_image.h"
#import "Renderer.h"
#import <Metal/Metal.h>

Texture::Texture(const std::string &filePath) : filePath(filePath)
{

    int width, height, channels;
    stbi_set_flip_vertically_on_load(1);
    stbi_uc* data = stbi_load(filePath.c_str(), &width, &height, &channels, 0);

    MTLTextureDescriptor* textureDescriptor = [[MTLTextureDescriptor alloc] init];

    textureDescriptor.pixelFormat = MTLPixelFormatBGRA8Unorm;
    textureDescriptor.width = static_cast<NSUInteger>(width);
    textureDescriptor.height = static_cast<NSUInteger>(height);

    NSUInteger bytesPerRow = static_cast<NSUInteger>(4 * width);

    m_Texture = [Renderer::GetDevice() newTextureWithDescriptor:textureDescriptor];
    MTLRegion region = {
            { 0, 0, 0 },                   // MTLOrigin
            {static_cast<NSUInteger>(width), static_cast<NSUInteger>(height), 1} // MTLSize
    };



    [m_Texture replaceRegion:region
               mipmapLevel:0
                 withBytes:(const void*)data
               bytesPerRow:bytesPerRow];
}

void Texture::Bind(uint32_t texId) {
    textureID = texId;
    [Renderer::GetEncoder() setFragmentTexture:m_Texture atIndex:texId];
}
