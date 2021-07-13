//
// Created by __declspec on 13/7/2021.
//

#ifndef SANDBOX_MATH_H
#define SANDBOX_MATH_H

#include <glm/glm.hpp>


class Math {
public:
    bool static DecomposeTransform(const glm::mat4& transform, glm::vec3& translation, glm::vec3& rotation, glm::vec3& scale);
};


#endif //SANDBOX_MATH_H
