//
// Created by __declspec on 6/7/2021.
//

#include "Swapchain.h"
#import "Renderer.h"
#import "InitMetal.h"


Scope<Swapchain::SwapchainData> Swapchain::s_SwapchainData = CreateScope<Swapchain::SwapchainData>();


void Swapchain::Init(uint32_t mWidth, uint32_t mHeight)
{
    s_SwapchainData->swapchain = [CAMetalLayer layer];
    s_SwapchainData->swapchain.device = InitMetal::GetDevice();
    s_SwapchainData->swapchain.pixelFormat = MTLPixelFormatBGRA8Unorm;
    s_SwapchainData->swapchain.drawableSize = CGSizeMake(mWidth, mHeight);
    s_SwapchainData->swapchain.framebufferOnly = YES;
    s_SwapchainData->swapchain.opaque = YES;
    s_SwapchainData->swapchain.displaySyncEnabled = NO;


}

void Swapchain::SetSize(uint32_t width, uint32_t height) {
    s_SwapchainData->swapchain.drawableSize = CGSizeMake(width, height);
}

void Swapchain::Swapbuffers() {


    [InitMetal::GetCommandEncoder() endEncoding];
    [InitMetal::GetCommandBuffer() presentDrawable:s_SwapchainData->drawable];
    [InitMetal::GetCommandBuffer() commit];
}

void Swapchain::NextDrawable() {
    s_SwapchainData->drawable = [s_SwapchainData->swapchain nextDrawable];
}
