//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_CAMERA_H
#define UNTITLED_CAMERA_H

class Camera {
public:
    Camera() = default;
    Camera(const glm::mat4& projection)
            : m_Projection(projection) {}

    virtual ~Camera() = default;

    const glm::mat4& GetProjection() const { return m_Projection; }
protected:
    glm::mat4 m_Projection = glm::mat4(1.0f);
};

#endif //UNTITLED_CAMERA_H
