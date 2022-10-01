#ifndef RPIMMALDECODEDISPLAY_H
#define RPIMMALDECODEDISPLAY_H

#include "bcm_host.h"
#include "interface/mmal/mmal.h"
#include "interface/mmal/util/mmal_default_components.h"
#include "interface/vcos/vcos.h"

#include "interface/mmal/util/mmal_graph.h"
//#include "interface/mmal/util/mmal_util_params.h"

#include <cstdint>


/** Context for our application */
struct CONTEXT_T {
    VCOS_SEMAPHORE_T semaphore;
    MMAL_QUEUE_T *queue;
    MMAL_STATUS_T status;
};
// MMAL Decode and MMAL Display all in one.
// Based on https://github.com/t-moe/rpi_mmal_examples/blob/master/graph_decode_render.c
class RPIMMalDecodeDisplay
{
public:
    RPIMMalDecodeDisplay();

    bool initialize(const uint8_t* config_data,const int config_data_size,int width,int height,int fps);

    bool feed_frame(const uint8_t* frame_data,const int frame_data_size);

    void cleanup();

    CONTEXT_T m_context;

    MMAL_STATUS_T m_status = MMAL_EINVAL;

    MMAL_GRAPH_T *m_graph = 0;
    MMAL_COMPONENT_T *m_decoder = 0;
    MMAL_COMPONENT_T *m_renderer=0;
    MMAL_POOL_T *m_pool_in = 0;

private:
    void updateDisplayRegion();
    bool display_region_needs_update=true;

};

#endif // RPIMMALDECODEDISPLAY_H
