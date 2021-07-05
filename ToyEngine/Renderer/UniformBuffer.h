//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_UNIFORMBUFFER_H
#define UNTITLED_UNIFORMBUFFER_H


#import <cstdint>
#import <Core/Base.h>
#import <MacTypes.h>
#import <Metal/Metal.h>

class UniformBuffer {

private:
    id<MTLBuffer> uniformBuffer = nil;
public:
    virtual ~UniformBuffer() {}
    void SetData(const void* data, uint32_t size, uint32_t offset = 0);

    UniformBuffer(uint32_t size, uint32_t binding);

};


#endif //UNTITLED_UNIFORMBUFFER_H
