//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_KEYEVENT_H
#define UNTITLED_KEYEVENT_H


#import <Core/KeyCodes.h>
#import "Event.h"

class KeyEvent : public Event
{
public:
    Key::KeyCode GetKeyCode() const { return m_KeyCode; }

    EVENT_CLASS_CATEGORY(EventCategoryKeyboard | EventCategoryInput)
protected:
    KeyEvent(const Key::KeyCode keycode)
            : m_KeyCode(keycode) {}

    Key::KeyCode m_KeyCode;
};

class KeyPressedEvent : public KeyEvent
{
public:
    KeyPressedEvent(const Key::KeyCode keycode, const uint16_t repeatCount)
            : KeyEvent(keycode), m_RepeatCount(repeatCount) {}

    uint16_t GetRepeatCount() const { return m_RepeatCount; }

    std::string ToString() const
    {
        std::stringstream ss;
        ss << "KeyPressedEvent: " << m_KeyCode << " (" << m_RepeatCount << " repeats)";
        return ss.str();
    }

    EVENT_CLASS_TYPE(KeyPressed)
private:
    uint16_t m_RepeatCount;
};

class KeyReleasedEvent : public KeyEvent
{
public:
    KeyReleasedEvent(const Key::KeyCode keycode)
            : KeyEvent(keycode) {}

    std::string ToString() const
    {
        std::stringstream ss;
        ss << "KeyReleasedEvent: " << m_KeyCode;
        return ss.str();
    }

    EVENT_CLASS_TYPE(KeyReleased)
};

class KeyTypedEvent : public KeyEvent
{
public:
    KeyTypedEvent(const Key::KeyCode keycode)
            : KeyEvent(keycode) {}

    std::string ToString() const
    {
        std::stringstream ss;
        ss << "KeyTypedEvent: " << m_KeyCode;
        return ss.str();
    }

    EVENT_CLASS_TYPE(KeyTyped)
};

#endif //UNTITLED_KEYEVENT_H
