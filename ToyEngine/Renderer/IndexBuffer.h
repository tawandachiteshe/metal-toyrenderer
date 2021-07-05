//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_INDEXBUFFER_H
#define UNTITLED_INDEXBUFFER_H

#import <MacTypes.h>
#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>

class IndexBuffer {

private:

    id<MTLBuffer> indexBuffer = nil;
    uint32_t count;

public:
    IndexBuffer(){}
    IndexBuffer(uint32_t* data, uint32_t count);
    IndexBuffer(uint32_t* data);

    uint32_t GetCount() { return count; }

    id<MTLBuffer> GetBuffer() { return indexBuffer; }

    void Bind();

};


#endif //UNTITLED_INDEXBUFFER_H
