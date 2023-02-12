//
//  File.swift
//  
//
//  Created by Denny on 11/02/23.
//

import Foundation
import SwiftUI

public enum CellState: Equatable {
    case unowned
    case owned(Owner)
    case burnt
    
    public var image: String {
        switch self {
        case .unowned:
            return "square.fill"
        case let .owned(owner):
            return owner.image
        case .burnt:
            return "flame.fill"
            
        }
    }
    
    public var background: Color {
        switch self {
        case .unowned:
            return .gray
        case .owned(let owner):
            return owner.background
        case .burnt:
            return .clear
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (let .owned(a), let .owned(b)):
            return a == b
        case (.unowned, .unowned), (.burnt, .burnt):
            return true
        default:
            return false
        }
    }
}

public enum Owner {
    case cross, zero
    
    var image: String {
        switch self {
        case .cross:
            return "multiply"
        case .zero:
            return "circle"
        }
    }
    
    var background: Color {
        switch self {
        case .cross:
            return .red
        case .zero:
            return .green
        }
    }
}

public struct CellIndex {
    public let row: Int
    public let column: Int
    
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    var id: String {
        "\(row)\(column)"
    }
    
    var nextRow: CellIndex {
        .init(row: row+1, column: 0)
    }
    
    var nextColumn: CellIndex {
        .init(row: row, column: column+1)
    }
}

public final class CellViewModel: ObservableObject, Identifiable {
    @Published public var state: CellState = .unowned
    public var isLocked: Bool = false
    public var index: CellIndex
    public var id: String {
        index.id
    }
    
    public weak var delegate: GameGridDelegate?
    
    public init(_ index: CellIndex, delegate: GameGridDelegate? = nil) {
        self.index = index
        self.delegate = delegate
    }
    
    public func didChangeState() {
        isLocked = true
        state = .owned(.zero)
        delegate?.shouldCheckMatch()
    }
}
