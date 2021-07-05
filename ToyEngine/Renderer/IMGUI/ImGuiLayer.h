//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_IMGUILAYER_H
#define UNTITLED_IMGUILAYER_H


#import <Events/Event.h>
#import <Core/Layer.h>

class ImGuiLayer : public Layer
{
public:
    ImGuiLayer();
    ~ImGuiLayer() = default;

    virtual void OnAttach() override;
    virtual void OnDetach() override;
    virtual void OnEvent(Event& e) override;

    void Begin();
    void End();

    void BlockEvents(bool block) { m_BlockEvents = block; }

    void SetDarkThemeColors();
private:
    bool m_BlockEvents = true;
};


#endif //UNTITLED_IMGUILAYER_H
