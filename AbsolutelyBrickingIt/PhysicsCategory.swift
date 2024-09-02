//
// PhysicsCategory.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 02/09/2024.
// 

import Foundation

enum PhysicsCategory {
    static let ball: UInt32 = 0x1
    static let paddle: UInt32 = 0x1 << 1
    static let wall: UInt32 = 0x1 << 2
    static let outOfBounds: UInt32 = 0x1 << 3
    static let brick: UInt32 = 0x1 << 4
}
