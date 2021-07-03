//
// Created by __declspec on 25/6/2021.
//

#ifndef UNTITLED_APPLICATION_H
#define UNTITLED_APPLICATION_H
#include <memory>
#import "Window/Window.h"
#import "Renderer/Renderer.h"
#import "Renderer/IndexBuffer.h"
#import "Renderer/Texture.h"

class Application {

private:
    std::shared_ptr<Window> window;
    std::shared_ptr<Renderer> renderer;
    std::shared_ptr<VertexBuffer> vertexBuffer;
    std::shared_ptr<IndexBuffer> indexBuffer;
    std::shared_ptr<Shader> whiteShader;
    std::shared_ptr<Shader> whiteShader2;
    std::shared_ptr<Texture> texture;
    glm::mat4 projectionview;
    void Render();

public:

    Application() {}

    void Init();
    void Run();



};


#endif //UNTITLED_APPLICATION_H
