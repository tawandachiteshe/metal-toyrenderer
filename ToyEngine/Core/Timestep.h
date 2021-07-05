//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_TIMESTEP_H
#define UNTITLED_TIMESTEP_H


class Timestep {
public:
    Timestep(float time = 0.0f)
            : m_Time(time) {
    }

    operator float() const { return m_Time; }

    float GetSeconds() const { return m_Time; }

    float GetMilliseconds() const { return m_Time * 1000.0f; }

private:
    float m_Time;
};


#endif //UNTITLED_TIMESTEP_H
