//
// Created by __declspec on 5/7/2021.
//

#include <Renderer/RenderCommand.h>
#import <Renderer/Renderer2D.h>
#import <glm/ext/matrix_transform.hpp>
#import <glm/gtc/type_ptr.hpp>
#import <ImGuizmo.h>
#include "SandBox2D.h"
#include "Core/Input.h"
#include "imgui.h"
#include <Core/Math.h>

struct Vertex {
    glm::vec3 position;
    glm::vec4 color;
    glm::vec2 uv;
};

static float frameTime = 0.0f;
static float degrees = 0.0f;

bool useWindow = false;
int gizmoCount = 1;
float camDistance = 8.f;
int lastUsing = 0;
static ImGuizmo::OPERATION mCurrentGizmoOperation(ImGuizmo::TRANSLATE);

void EditTransform(EditorCamera& camera, glm::mat4* transform, bool editTransformDecomposition)
{
    ImGuizmo::BeginFrame();
    static ImGuizmo::MODE mCurrentGizmoMode(ImGuizmo::LOCAL);
    static bool useSnap = false;
    static float snap[3] = { 1.f, 1.f, 1.f };
    static float bounds[] = { -0.5f, -0.5f, -0.5f, 0.5f, 0.5f, 0.5f };
    static float boundsSnap[] = { 0.1f, 0.1f, 0.1f };
    static bool boundSizing = false;
    static bool boundSizingSnap = false;

    if (editTransformDecomposition)
    {
        if (ImGui::IsKeyPressed(90))
            mCurrentGizmoOperation = ImGuizmo::TRANSLATE;
        if (ImGui::IsKeyPressed(69))
            mCurrentGizmoOperation = ImGuizmo::ROTATE;
        if (ImGui::IsKeyPressed(82)) // r Key
            mCurrentGizmoOperation = ImGuizmo::SCALE;
        if (ImGui::RadioButton("Translate", mCurrentGizmoOperation == ImGuizmo::TRANSLATE))
            mCurrentGizmoOperation = ImGuizmo::TRANSLATE;
        ImGui::SameLine();
        if (ImGui::RadioButton("Rotate", mCurrentGizmoOperation == ImGuizmo::ROTATE))
            mCurrentGizmoOperation = ImGuizmo::ROTATE;
        ImGui::SameLine();
        if (ImGui::RadioButton("Scale", mCurrentGizmoOperation == ImGuizmo::SCALE))
            mCurrentGizmoOperation = ImGuizmo::SCALE;
        float matrixTranslation[3], matrixRotation[3], matrixScale[3];
        ImGuizmo::DecomposeMatrixToComponents(reinterpret_cast<const float *>(transform), matrixTranslation, matrixRotation, matrixScale);
        ImGui::InputFloat3("Tr", matrixTranslation);
        ImGui::InputFloat3("Rt", matrixRotation);
        ImGui::InputFloat3("Sc", matrixScale);
        ImGuizmo::RecomposeMatrixFromComponents(matrixTranslation, matrixRotation, matrixScale,
                                                reinterpret_cast<float *>(transform));

        if (mCurrentGizmoOperation != ImGuizmo::SCALE)
        {
            if (ImGui::RadioButton("Local", mCurrentGizmoMode == ImGuizmo::LOCAL))
                mCurrentGizmoMode = ImGuizmo::LOCAL;
            ImGui::SameLine();
            if (ImGui::RadioButton("World", mCurrentGizmoMode == ImGuizmo::WORLD))
                mCurrentGizmoMode = ImGuizmo::WORLD;
        }
        if (ImGui::IsKeyPressed(83))
            useSnap = !useSnap;
        ImGui::Checkbox("", &useSnap);
        ImGui::SameLine();

        switch (mCurrentGizmoOperation)
        {
            case ImGuizmo::TRANSLATE:
                ImGui::InputFloat3("Snap", &snap[0]);
                break;
            case ImGuizmo::ROTATE:
                ImGui::InputFloat("Angle Snap", &snap[0]);
                break;
            case ImGuizmo::SCALE:
                ImGui::InputFloat("Scale Snap", &snap[0]);
                break;
            case ImGuizmo::TRANSLATE_X:
                break;
            case ImGuizmo::TRANSLATE_Y:
                break;
            case ImGuizmo::TRANSLATE_Z:
                break;
            case ImGuizmo::ROTATE_X:
                break;
            case ImGuizmo::ROTATE_Y:
                break;
            case ImGuizmo::ROTATE_Z:
                break;
            case ImGuizmo::ROTATE_SCREEN:
                break;
            case ImGuizmo::SCALE_X:
                break;
            case ImGuizmo::SCALE_Y:
                break;
            case ImGuizmo::SCALE_Z:
                break;
            case ImGuizmo::BOUNDS:
                break;
        }
        ImGui::Checkbox("Bound Sizing", &boundSizing);
        if (boundSizing)
        {
            ImGui::PushID(3);
            ImGui::Checkbox("", &boundSizingSnap);
            ImGui::SameLine();
            ImGui::InputFloat3("Snap", boundsSnap);
            ImGui::PopID();
        }
    }

    ImGuiIO& io = ImGui::GetIO();
    float viewManipulateRight = io.DisplaySize.x;
    float viewManipulateTop = 0;
    if (useWindow)
    {
        ImGui::SetNextWindowSize(ImVec2(800, 400));
        ImGui::SetNextWindowPos(ImVec2(400,20));
        ImGui::PushStyleColor(ImGuiCol_WindowBg, (ImVec4)ImColor(0.35f, 0.3f, 0.3f));
        ImGui::Begin("Gizmo", 0, ImGuiWindowFlags_NoMove);
        ImGuizmo::SetDrawlist();
        auto windowWidth = (float)ImGui::GetWindowWidth();
        auto windowHeight = (float)ImGui::GetWindowHeight();
        ImGuizmo::SetRect(ImGui::GetWindowPos().x, ImGui::GetWindowPos().y, windowWidth, windowHeight);
        viewManipulateRight = ImGui::GetWindowPos().x + windowWidth;
        viewManipulateTop = ImGui::GetWindowPos().y;
    }
    else
    {
        ImGuizmo::SetRect(0, 0, io.DisplaySize.x, io.DisplaySize.y);
    }

    ImGuizmo::DrawGrid(glm::value_ptr(camera.GetViewMatrix()), glm::value_ptr(camera.GetProjection()), glm::value_ptr(glm::mat4(1.0f)), 30.0f);
    //ImGuizmo::DrawCubes(glm::value_ptr(camera.GetViewMatrix()), glm::value_ptr(camera.GetProjection()), glm::value_ptr(transform), gizmoCount);
    ImGuizmo::Manipulate(glm::value_ptr(camera.GetViewMatrix()), glm::value_ptr(camera.GetProjection()), mCurrentGizmoOperation, mCurrentGizmoMode,
                         reinterpret_cast<float *>(transform), NULL, useSnap ? &snap[0] : NULL, boundSizing ? bounds : NULL, boundSizingSnap ? boundsSnap : NULL);

    ImGuizmo::ViewManipulate(const_cast<float *>(glm::value_ptr(camera.GetViewMatrix())), camDistance, ImVec2(viewManipulateRight - 128, viewManipulateTop), ImVec2(128, 128), 0x10101010);

    if (useWindow)
    {
        ImGui::End();
        ImGui::PopStyleColor(1);
    }
}


void SandBox2D::OnImGuiRender() {

    ImGui::Begin("Tawanda");
    ImGui::Text("Frame time %f", frameTime);
    ImGui::Text("FPS %f", (1000.0f / frameTime));
    ImGui::DragFloat3("position", const_cast<float *>(glm::value_ptr(m_Position)), 0.01f);
    ImGui::DragFloat("rotations", &degrees, 15.0f);
    if (ImGuizmo::IsUsing())
    {
        ImGui::Text("Using gizmo");
    }
    else
    {
        ImGui::Text(ImGuizmo::IsOver()?"Over gizmo":"");
        ImGui::SameLine();
        ImGui::Text(ImGuizmo::IsOver(ImGuizmo::TRANSLATE) ? "Over translate gizmo" : "");
        ImGui::SameLine();
        ImGui::Text(ImGuizmo::IsOver(ImGuizmo::ROTATE) ? "Over rotate gizmo" : "");
        ImGui::SameLine();
        ImGui::Text(ImGuizmo::IsOver(ImGuizmo::SCALE) ? "Over scale gizmo" : "");
    }
    ImGui::End();

    for (int matId = 0; matId < gizmoCount; matId++)
    {
        ImGuizmo::SetID(matId);

        EditTransform(editorCamera, &transform, lastUsing == matId);
        if (ImGuizmo::IsUsing())
        {
            glm::vec3 translation, rotation, scale;
            Math::DecomposeTransform(transform, translation, rotation, scale);

            //glm::vec3 deltaRotation = rotation - tc.Rotation;
            m_Position = translation;
            //tc.Rotation += deltaRotation;
            m_Scale = scale;
        }
    }
}

void SandBox2D::OnAttach() {

}

void SandBox2D::OnDetach() {

}

void SandBox2D::OnUpdate(Timestep ts) {

    transform = glm::translate(glm::mat4(1.0f), m_Position) * glm::rotate(glm::mat4(1.0f), glm::radians(degrees), {0.0f, 0.0f, 1.0f})
            * glm::scale(glm::mat4(1.0f), m_Scale);

    m_CameraController.OnUpdate(ts);
    editorCamera.OnUpdate(ts);
    frameTime = ts.GetMilliseconds();
    //if u dont clear doesnt work
    RenderCommand::Clear({0.1f, 0.1f, 0.1f, 1.0f});
    texture->Bind();


    Renderer::BeginRender(editorCamera);
    Renderer::Submit(vertexBuffer, indexBuffer, whiteShader, transform);
    Renderer::EndRender();

//
//    Renderer2D::BeginScene( m_CameraController.GetCamera().GetProjectionMatrix());
//    Renderer2D::DrawQuad({0.0f, 0.0f, 1.0f}, {1.0f, 1.0f}, {1.0f, 1.0f, 1.0f, 1.0f});
//    Renderer2D::EndScene();

}

void SandBox2D::OnEvent(Event &e) {
    m_CameraController.OnEvent(e);
    editorCamera.OnEvent(e);

}

SandBox2D::SandBox2D() :
        Layer("Sandbox2D"), m_CameraController(1280.0f / 720.0f), m_SquareColor({ 0.2f, 0.3f, 0.8f, 1.0f }),
        editorCamera(45.0f, 1280.0f/720.0f, 0.01, 1000.0f)
{

    Vertex positions[] = {{{-0.5f, -0.5f, 0.0f}, {1.0f, 0.0f, 1.0f, 1.0f}, {0.0f, 0.0f}},
                          {{0.5f,  -0.5f, 0.0f}, {1.0f, 1.0f, 0.0f, 1.0f}, {1.0f, 0.0f}},
                          {{0.5f,  0.5f,  0.0f}, {0.0f, 1.0f, 1.0f, 1.0f}, {1.0f, 1.0f}},
                          {{-0.5f, 0.5f,  0.0f}, {0.0f, 1.0f, 1.0f, 1.0f}, {0.0f, 1.0f}}};

    uint32_t indices[] = {
            0, 1, 2, 0, 2, 3
    };

    texture = std::make_shared<Texture>("Assets/textures/waifu.png");
    texture2 = std::make_shared<Texture>(800, 600);


    vertexBuffer = std::make_shared<VertexBuffer>(sizeof(positions));
    vertexBuffer->SetData((void *) positions, sizeof(positions));

    vertexBuffer->SetLayout({{ShaderDataType::Float3, "position"},
                             {ShaderDataType::Float4, "color"},
                             {ShaderDataType::Float2, "uv"}});

    indexBuffer = std::make_shared<IndexBuffer>(indices, 6);

    whiteShader = std::make_shared<Shader>("Assets/Shaders/whiteShader.metal");
    whiteShader->SetVertexLayout(vertexBuffer->GetLayout());
    whiteShader2 = std::make_shared<Shader>("Assets/Shaders/blueandlit.metal");
    whiteShader2->SetVertexLayout(vertexBuffer->GetLayout());

}
