import simd

// Translation implemented with guidance from Apple matrix math documentation
// https://developer.apple.com/documentation/accelerate/working_with_matrices
func createTranslationMatrix(tx: Float, ty: Float, tz: Float) -> simd_float4x4 {
    var translationMatrix = matrix_identity_float4x4
    translationMatrix[3, 0] = tx
    translationMatrix[3, 1] = ty
    translationMatrix[3, 2] = tz
    return translationMatrix
}

// Rotation implemented while cribbing from https://math.stackexchange.com/questions/13272/how-would-i-create-a-rotation-matrix-that-rotates-x-by-a-y-by-b-and-z-by-c
func createRotationMatrix(xRotation: Float, yRotation: Float, zRotation: Float) -> simd_float4x4 {
    let cos = (x: cos(xRotation), y: cos(yRotation), z: cos(zRotation))
    let sin = (x: sin(xRotation), y: sin(yRotation), z: sin(zRotation))
    
    let rotationAroundX: simd_float4x4 = {
        var rotationMatrix = matrix_identity_float4x4
        rotationMatrix[1, 1] =  cos.x
        rotationMatrix[1, 2] =  sin.x
        rotationMatrix[2, 1] = -sin.x
        rotationMatrix[2, 2] =  cos.x
        return rotationMatrix
    }()
    
    let rotationAroundY: simd_float4x4 = {
        var rotationMatrix = matrix_identity_float4x4
        rotationMatrix[0, 0] =  cos.y
        rotationMatrix[0, 2] = -sin.y
        rotationMatrix[2, 0] =  sin.y
        rotationMatrix[2, 2] =  cos.y
        return rotationMatrix
    }()
    
    let rotationAroundZ: simd_float4x4 = {
        var rotationMatrix = matrix_identity_float4x4
        rotationMatrix[0, 0] =  cos.z
        rotationMatrix[0, 1] =  sin.z
        rotationMatrix[1, 0] = -sin.z
        rotationMatrix[1, 1] =  cos.z
        return rotationMatrix
    }()
    
    return rotationAroundX * rotationAroundY * rotationAroundZ
}

func createScaleMatrix(xScale: Float, yScale: Float, zScale: Float) -> simd_float4x4 {
    return simd_float4x4(diagonal: SIMD4<Float>(xScale, yScale, zScale, 1))
}

func createModelMatrix(position: SIMD3<Float>, rotation: SIMD3<Float>, scale: SIMD3<Float>) -> simd_float4x4 {
    return createScaleMatrix(xScale: scale.x, yScale: scale.y, zScale: scale.z) * createRotationMatrix(xRotation: rotation.x, yRotation: rotation.y, zRotation: rotation.z) * createTranslationMatrix(tx: position.x, ty: position.y, tz: position.z)
}
