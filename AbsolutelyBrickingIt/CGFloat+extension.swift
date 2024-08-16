//
// CGFloat+extension.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 16/08/2024.
// 

import Foundation

extension CGFloat {
    
    func clamp(min: CGFloat, max: CGFloat) -> CGFloat {
        if self < min {
            return min
        } else if self > max {
            return max
        } else {
            return self
        }
    }
}
