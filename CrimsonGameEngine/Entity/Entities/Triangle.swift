//
//  Cube.swift
//  CrimsonGameEngine
//
//  Created by Karl Groff on 1/15/22.
//

import Foundation

struct Triangle: Renderable {
    let vertices: [float3] = [
        float3( 0, 1, 0), // Top middle
        float3(-1,-1, 0), // Bottom left
        float3( 1,-1, 0)  // Bottom right
    ]
}
