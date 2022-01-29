// Matrix globals implemented with guidance from Apple matrix math documentation
// https://developer.apple.com/documentation/accelerate/working_with_matrices

import simd

func createTranslationMatrix(tx: Float, ty: Float, tz: Float) -> simd_float4x4 {
    var translationMatrix = matrix_identity_float4x4
    
    translationMatrix[3, 0] = tx
    translationMatrix[3, 1] = ty
    translationMatrix[3, 2] = tz
    
    return translationMatrix
}

func createScaleMatrix(xScale: Float, yScale: Float, zScale: Float) -> simd_float4x4 {
    return simd_float4x4(diagonal: SIMD4<Float>(xScale, yScale, zScale, 1))
}
