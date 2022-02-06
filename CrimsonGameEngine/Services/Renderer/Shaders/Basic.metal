#include <metal_stdlib>
using namespace metal;
#import "../../../Application/Common.h"

vertex float4 basic_vertex_shader(constant Uniforms        & uniforms    [[ buffer(0) ]],
                                  constant matrix_float4x4 & modelMatrix [[ buffer(1) ]],
                                  constant float3          * vertices    [[ buffer(2) ]],
                                           uint              vertexID    [[ vertex_id ]]) {
    return uniforms.projectionMatrix * uniforms.viewMatrix * modelMatrix * float4(vertices[vertexID], 1);
}

fragment half4 basic_fragment_shader() {
    return half4(1);
}
