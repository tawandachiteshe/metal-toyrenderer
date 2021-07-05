//
// Created by __declspec on 2/7/2021.
//

#import <glm/glm.hpp>
#import <memory>
#import <array>
#import <glm/ext/matrix_transform.hpp>
#include "Renderer2D.h"
#import "VertexBuffer.h"
#import "Texture.h"
#import "Shader.h"
#import "RenderCommand.h"
#import "Renderer.h"


struct ToyRendererVertex {
    glm::vec4 position;
    glm::vec4 color;
    glm::vec2 uvs;
    float textureID;
    float tillingFactor;
};

struct Renderer2DStorage {

    static const uint32_t MaxQuads = 10000;
    static const uint32_t MaxQuadsVertices = MaxQuads * 4;
    const uint32_t MaxQuadsIndices = MaxQuads * 6;

    uint32_t QuadIndexCount = 0;
    static const uint32_t MaxTextureSlots = 16;

    std::shared_ptr<VertexBuffer> quadVertexBuffer;
    std::shared_ptr<IndexBuffer> indexBuffer;
    std::shared_ptr<Texture> whiteTexture;
    std::shared_ptr<Shader> textureShader;


    ToyRendererVertex *QuadVertexBufferBase = nullptr;
    ToyRendererVertex *QuadVertexBufferPtr = nullptr;

    std::array<std::shared_ptr<Texture>, MaxTextureSlots> textureSlots;
    glm::vec4 QuadVertexPositions[4];
    float textureSlotIndex = 1.0f;
};

static Renderer2DStorage s_Storage;

void Renderer2D::InitQuads() {

    uint32_t *QuadIndices = new uint32_t[s_Storage.MaxQuadsIndices];
    uint32_t offset = 0;

    for (int i = 0; i < s_Storage.MaxQuadsIndices; i += 6) {
        QuadIndices[i + 0] = offset + 0;
        QuadIndices[i + 1] = offset + 1;
        QuadIndices[i + 2] = offset + 2;

        QuadIndices[i + 3] = offset + 0;
        QuadIndices[i + 4] = offset + 2;
        QuadIndices[i + 5] = offset + 3;
        offset += 4;
    }


    s_Storage.quadVertexBuffer = std::make_shared<VertexBuffer>(
            Renderer2DStorage::MaxQuadsVertices * sizeof(ToyRendererVertex));

    s_Storage.quadVertexBuffer->SetLayout({
                                                  {ShaderDataType::Float4, "position"},
                                                  {ShaderDataType::Float4, "color"},
                                                  {ShaderDataType::Float2, "uvs"},
                                                  {ShaderDataType::Float1, "textureID"},
                                                  {ShaderDataType::Float1, "tillingFactor"},
                                          });

    s_Storage.QuadVertexBufferBase = new ToyRendererVertex[Renderer2DStorage::MaxQuadsVertices];
    s_Storage.indexBuffer = std::make_shared<IndexBuffer>(QuadIndices, s_Storage.MaxQuadsIndices);

    delete[] QuadIndices;
    s_Storage.QuadVertexPositions[0] = {-0.5f, -0.5f, 0.0f, 1.0f};
    s_Storage.QuadVertexPositions[1] = {0.5f, -0.5f, 0.0f, 1.0f};
    s_Storage.QuadVertexPositions[2] = {0.5f, 0.5f, 0.0f, 1.0f};
    s_Storage.QuadVertexPositions[3] = {-0.5f, 0.5f, 0.0f, 1.0f};

}

void Renderer2D::Init() {
    s_Storage.textureShader = std::make_shared<Shader>("Assets/Shaders/renderer2d.metal");

    InitQuads();
    s_Storage.textureShader->SetVertexLayout(s_Storage.quadVertexBuffer->GetLayout());

    s_Storage.whiteTexture = std::make_shared<Texture>(1, 1);
    uint32_t whiteTextureData = 0xFFFFFFFF;
    s_Storage.whiteTexture->SetData(&whiteTextureData, sizeof(whiteTextureData));


    for (uint32_t i = 0; i < Renderer2DStorage::MaxTextureSlots; i++)
        s_Storage.textureSlots[i] = s_Storage.whiteTexture;

//    int32_t samplers[Renderer2DStorage::MaxTextureSlots];
//    for (uint32_t i = 0; i < Renderer2DStorage::MaxTextureSlots; i++)
//        samplers[i] = i;
//
//    for (uint32_t i = 0; i < Renderer2DStorage::MaxTextureSlots; i++)
//        s_Storage.TextureSlots[i] = s_Storage.WhiteTexture;
//
//
//
//    s_Storage.TextureShader->SetIntArray("u_Textures", samplers, Renderer2DStorage::MaxTextureSlots);
//    s_Storage.TextureSlots[0] = s_Storage.WhiteTexture;
}

void Renderer2D::Shutdown() {

}

void Renderer2D::DrawQuad(const glm::vec3 &position, const glm::vec2 &size, const glm::vec4 &color) {
    glm::mat4 transform = glm::translate(glm::mat4(1.0f), position) * glm::scale(glm::mat4(1.0f), {size.x, size.y, 1.0f});
    DrawQuad(transform, color);
}

void Renderer2D::BeginScene(const glm::mat4& transform) {

    s_Storage.textureShader->Bind();
    s_Storage.textureShader->SetMat4(transform);

    s_Storage.QuadIndexCount = 0;
    s_Storage.QuadVertexBufferPtr = s_Storage.QuadVertexBufferBase;

}

void Renderer2D::Flush() {
    for (uint32_t i = 0; i < s_Storage.MaxTextureSlots; i++)
        s_Storage.textureSlots[i]->Bind(i);

    if (s_Storage.QuadIndexCount != 0) {
        RenderCommand::DrawIndexed(s_Storage.quadVertexBuffer, s_Storage.indexBuffer, s_Storage.textureShader,s_Storage.QuadIndexCount);
    }

}


void Renderer2D::FlushAndReset() {
    EndScene();

    s_Storage.QuadIndexCount = 0;
    s_Storage.QuadVertexBufferPtr = s_Storage.QuadVertexBufferBase;

    s_Storage.textureSlotIndex = 1.0f;
}


void Renderer2D::DrawDestroy() {
    delete[] s_Storage.QuadVertexBufferBase;
}

void Renderer2D::EndScene() {
    uint32_t QuadDataSize = (uint8_t *) s_Storage.QuadVertexBufferPtr - (uint8_t *) s_Storage.QuadVertexBufferBase;
    s_Storage.quadVertexBuffer->SetData(s_Storage.QuadVertexBufferBase, QuadDataSize);

    Flush();
}

void
Renderer2D::DrawRotatedQuad(const glm::vec3 &position, const glm::vec2 &size, float rotation, const glm::vec4 &color) {

}

void Renderer2D::DrawRotatedQuad(const glm::vec3 &position, const glm::vec2 &size, float rotation,
                                 const std::shared_ptr<Texture> &texture, float tilingFactor,
                                 const glm::vec4 &tintColor) {

    glm::mat4 transform = glm::translate(glm::mat4(1.0f), position) * glm::scale(glm::mat4(1.0f), {size.x, size.y, 1.0f}) *
    glm::rotate(glm::mat4(1.0f), glm::radians(rotation), glm::vec3(0.0f, 0.0f, 1.0f));


    constexpr size_t quadVertexCount = (size_t)4;

    float textureIndex = 0.0f; // White Texture
    constexpr glm::vec2 textureCoords[] = { {0.0f, 0.0f},
                                            {1.0f, 0.0f},
                                            {1.0f, 1.0f},
                                            {0.0f, 1.0f} };

    if (s_Storage.QuadIndexCount >= s_Storage.MaxQuadsIndices)
        FlushAndReset();


    for (uint32_t i = 0; i < s_Storage.textureSlotIndex; i++) {

        if(s_Storage.textureSlots[i].get() == texture.get()) {
            textureIndex = (float)i;
            break;
        }
    }

    if (textureIndex == 0.0f) {
        if (s_Storage.textureSlotIndex >= Renderer2DStorage::MaxTextureSlots)
            FlushAndReset();
        textureIndex = (float)s_Storage.textureSlotIndex;
        s_Storage.textureSlots[s_Storage.textureSlotIndex] = texture;
        s_Storage.textureSlotIndex++;
    }


    for (size_t i = 0; i < quadVertexCount; i++) {
        s_Storage.QuadVertexBufferPtr->position = transform * s_Storage.QuadVertexPositions[i];
        s_Storage.QuadVertexBufferPtr->color = tintColor;
        s_Storage.QuadVertexBufferPtr->uvs = textureCoords[i];
        s_Storage.QuadVertexBufferPtr->textureID = textureIndex;
        s_Storage.QuadVertexBufferPtr->tillingFactor = tilingFactor;
        s_Storage.QuadVertexBufferPtr++;
    }

    s_Storage.QuadIndexCount += 6;

}

void Renderer2D::DrawQuad(const glm::mat4 &transform, const glm::vec4 &color) {

    constexpr size_t quadVertexCount = (size_t)4;

    const float textureIndex = 0.0f; // White Texture
    constexpr glm::vec2 textureCoords[] = { {0.0f, 0.0f},
                                            {1.0f, 0.0f},
                                            {1.0f, 1.0f},
                                            {0.0f, 1.0f} };
    const float tilingFactor = 1.0f;
    const float pointsize = 1.0f;
    const float radius = 0.0f;

    if (s_Storage.QuadIndexCount >= s_Storage.MaxQuadsIndices)
        FlushAndReset();

    for (size_t i = 0; i < quadVertexCount; i++) {
        s_Storage.QuadVertexBufferPtr->position = transform * s_Storage.QuadVertexPositions[i];
        s_Storage.QuadVertexBufferPtr->color = color;
        s_Storage.QuadVertexBufferPtr->uvs = textureCoords[i];
        s_Storage.QuadVertexBufferPtr->textureID = textureIndex;
        s_Storage.QuadVertexBufferPtr->tillingFactor = tilingFactor;
        s_Storage.QuadVertexBufferPtr++;
    }

    s_Storage.QuadIndexCount += 6;

}

void Renderer2D::DrawQuad(const glm::vec3 &position, const glm::vec2 &size, const std::shared_ptr<Texture> &texture,
                          float tilingFactor, const glm::vec4 &tintColor) {

    glm::mat4 transform = glm::translate(glm::mat4(1.0f), position) * glm::scale(glm::mat4(1.0f), {size.x, size.y, 1.0f});


    constexpr size_t quadVertexCount = (size_t)4;

    float textureIndex = 0.0f; // White Texture
    constexpr glm::vec2 textureCoords[] = { {0.0f, 0.0f},
                                            {1.0f, 0.0f},
                                            {1.0f, 1.0f},
                                            {0.0f, 1.0f} };

    if (s_Storage.QuadIndexCount >= s_Storage.MaxQuadsIndices)
        FlushAndReset();


    for (uint32_t i = 0; i < s_Storage.textureSlotIndex; i++) {

        if(s_Storage.textureSlots[i].get() == texture.get()) {
            textureIndex = (float)i;
            break;
        }
    }

    if (textureIndex == 0.0f) {
        if (s_Storage.textureSlotIndex >= Renderer2DStorage::MaxTextureSlots)
            FlushAndReset();
        textureIndex = (float)s_Storage.textureSlotIndex;
        s_Storage.textureSlots[s_Storage.textureSlotIndex] = texture;
        s_Storage.textureSlotIndex++;
    }


    for (size_t i = 0; i < quadVertexCount; i++) {
        s_Storage.QuadVertexBufferPtr->position = transform * s_Storage.QuadVertexPositions[i];
        s_Storage.QuadVertexBufferPtr->color = tintColor;
        s_Storage.QuadVertexBufferPtr->uvs = textureCoords[i];
        s_Storage.QuadVertexBufferPtr->textureID = textureIndex;
        s_Storage.QuadVertexBufferPtr->tillingFactor = tilingFactor;
        s_Storage.QuadVertexBufferPtr++;
    }

    s_Storage.QuadIndexCount += 6;


}
