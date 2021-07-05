//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_INPUT_H
#define UNTITLED_INPUT_H

#import <glm/vec2.hpp>
#import "KeyCodes.h"

class Input
{
public:
    static bool IsKeyPressed(Key::KeyCode key);

    static bool IsMouseButtonPressed(MouseCode button);
    static glm::vec2 GetMousePosition();
    static float GetMouseX();
    static float GetMouseY();
};

#endif //UNTITLED_INPUT_H
