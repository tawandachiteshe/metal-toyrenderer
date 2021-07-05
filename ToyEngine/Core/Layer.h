//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_LAYER_H
#define UNTITLED_LAYER_H


#include <string>
#import <Events/Event.h>
#import "Timestep.h"

class Layer {

public:
    Layer(const std::string& name = "Layer");
    virtual ~Layer() = default;

    virtual void OnAttach() {}
    virtual void OnDetach() {}
    virtual void OnUpdate(Timestep ts) {}
    virtual void OnImGuiRender() {}
    virtual void OnEvent(Event& event) {}

    const std::string& GetName() const { return m_DebugName; }
protected:
    std::string m_DebugName;


};


#endif //UNTITLED_LAYER_H
