//
// Created by __declspec on 26/6/2021.
//

#include "Texture.h"
#import "third_party/stb_image.h"
#import "Renderer.h"
#import <Metal/Metal.h>
#import "RenderCommand.h"

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

    char* dta_ = (char*)malloc(width * height * 4);
    [m_Texture getBytes:dta_ bytesPerRow: bytesPerRow fromRegion:region mipmapLevel:0];

    char* dta2 = dta_;


}

void Texture::Bind(uint32_t texId) {
    textureID = texId;
    [RenderCommand::GetCommandEncoder() setFragmentTexture:m_Texture atIndex:texId];
}

Texture::Texture(uint32_t width, uint32_t height) :
m_Height(height), m_Width(width)
{

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


}

void Texture::SetData(void *data, uint32_t size) {

    NSUInteger bytesPerRow = static_cast<NSUInteger>(4 * m_Width);

    MTLRegion region = {
            { 0, 0, 0 },                   // MTLOrigin
            {static_cast<NSUInteger>(m_Width), static_cast<NSUInteger>(m_Height), 1} // MTLSize
    };


    [m_Texture replaceRegion:region
                 mipmapLevel:0
                   withBytes:(const void*)data
                 bytesPerRow:bytesPerRow];

}
