//
//  Header.h
//  Game Engine
//
//  Created by Karl Groff on 1/5/22.
//

#ifndef Header_h
#define Header_h

#import <simd/simd.h>

typedef struct {
    float3 position;
    float4 color;
} VertexIn;

typedef struct {
    float4 position [[ position ]];
    float4 color;
} RasterizerData;

#endif /* Header_h */
