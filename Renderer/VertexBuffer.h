//
// Created by __declspec on 25/6/2021.
//

#ifndef UNTITLED_VERTEXBUFFER_H
#define UNTITLED_VERTEXBUFFER_H


#import <cstdint>
#import <MacTypes.h>
#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>
#import "BufferLayout.h"

class VertexBuffer {

private:

    id<MTLBuffer> vertexBuffer = nil;
    MTLVertexDescriptor* vertexDescriptor;

public:
    VertexBuffer(void* data, uint32_t size);
    VertexBuffer(uint32_t size);


    void SetData(void* data, uint32_t size);

    id<MTLBuffer> GetBuffer() { return vertexBuffer; }
    MTLVertexDescriptor* GetLayout() { return vertexDescriptor; }

    void SetLayout(const BufferLayout& layout);

    void Bind();

};


#endif //UNTITLED_VERTEXBUFFER_H
