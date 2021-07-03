//
// Created by __declspec on 2/7/2021.
//

#ifndef UNTITLED_RENDERER2D_H
#define UNTITLED_RENDERER2D_H


#import "Texture.h"

class Renderer2D {

public:
    static void Init();
    static void Shutdown();
    static void DrawQuad(const glm::vec3 &position, const glm::vec2 &size, const glm::vec4 &color);
    static void DrawQuad(const glm::mat4& transform, const glm::vec4 &color);
    static void BeginScene(const glm::mat4& transform = glm::mat4(1.0f));
    static void EndScene();
    static void DrawRotatedQuad(const glm::vec3 &position, const glm::vec2 &size, float rotation,
                                     const glm::vec4 &color);
    static void DrawRotatedQuad(const glm::vec3 &position, const glm::vec2 &size, float rotation,
                                     const std::shared_ptr<Texture> &texture, float tilingFactor, const glm::vec4 &tintColor);

    static void DrawQuad(const glm::vec3 &position, const glm::vec2 &size, const std::shared_ptr<Texture> &texture, float tilingFactor = 1.0f,
                         const glm::vec4 &tintColor = {1.0f, 1.0f, 1.0f, 1.0f});

private:
    static void FlushAndReset();
    static void Flush();
    static void DrawDestroy();
    static void InitQuads();


};


#endif //UNTITLED_RENDERER2D_H
