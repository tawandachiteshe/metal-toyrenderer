//
// Created by __declspec on 6/7/2021.
//

#ifndef SANDBOX_SWAPCHAIN_H
#define SANDBOX_SWAPCHAIN_H


#import <cstdint>
#import <QuartzCore/QuartzCore.h>
#import <MacTypes.h>
#import <Core/Base.h>

class Swapchain {

private:

    struct SwapchainData {
        uint32_t m_Width, m_Height = 0;
        CAMetalLayer * swapchain = nil;
        id<CAMetalDrawable> drawable = nil;
    };

    static Scope<SwapchainData> s_SwapchainData;


public:

    static void NextDrawable();
    static void Init(uint32_t mWidth, uint32_t mHeight);
    static void Swapbuffers();
    static CAMetalLayer* GetSwapchain() { return s_SwapchainData->swapchain; }
    static id<MTLTexture> GetTexture() { return s_SwapchainData->drawable.texture; }
    static id<CAMetalDrawable> GetDrawable() { return s_SwapchainData->drawable; }


    static void SetSize(uint32_t width, uint32_t height);


};


#endif //SANDBOX_SWAPCHAIN_H
