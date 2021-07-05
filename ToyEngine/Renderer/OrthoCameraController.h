//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_ORTHOCAMERACONTROLLER_H
#define UNTITLED_ORTHOCAMERACONTROLLER_H


#import <Core/Timestep.h>
#import <Events/Event.h>
#import <Events/MouseEvent.h>
#import <Events/ApplicationEvent.h>
#import "OrthoCamera.h"

class OrthoCameraController {

public:
    OrthoCameraController(float aspectRatio, bool rotation = false);

    void OnUpdate(Timestep ts);
    void OnEvent(Event& e);

    void OnResize(float width, float height);

    OrthoCamera& GetCamera() { return m_Camera; }
    const OrthoCamera& GetCamera() const { return m_Camera; }

    float GetZoomLevel() const { return m_ZoomLevel; }
    void SetZoomLevel(float level) { m_ZoomLevel = level; }
private:
    bool OnMouseScrolled(MouseScrolledEvent& e);
    bool OnWindowResized(WindowResizeEvent& e);
private:
    float m_AspectRatio;
    float m_ZoomLevel = 1.0f;
    OrthoCamera m_Camera;

    bool m_Rotation;

    glm::vec3 m_CameraPosition = { 0.0f, 0.0f, 0.0f };
    float m_CameraRotation = 0.0f; //In degrees, in the anti-clockwise direction
    float m_CameraTranslationSpeed = 5.0f, m_CameraRotationSpeed = 180.0f;

};


#endif //UNTITLED_ORTHOCAMERACONTROLLER_H
