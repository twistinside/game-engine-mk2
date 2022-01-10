#include <metal_stdlib>
using namespace metal;
#import "../../../Application/Common.h"

vertex float4 basicVertexShader(constant Uniforms &uniforms [[ buffer(0) ]],
                                device float3 *vertices [[ buffer(1) ]],
                                uint vertexID [[ vertex_id ]]) {
    return float4(vertices[vertexID], 1) * uniforms.viewMatrix;
}

fragment half4 basicFragmentShader() {
    return half4(1);
}
