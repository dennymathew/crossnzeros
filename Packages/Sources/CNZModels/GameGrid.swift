//
//  File.swift
//  
//
//  Created by Denny on 12/02/23.
//

import Foundation

public protocol GameGridDelegate: AnyObject {
    func shouldCheckMatch()
}

public final class GameGrid: ObservableObject, GameGridDelegate {
    @Published public var rows: [GameGridRow] = []
    
    public init() {
        self.rows = initializeGrid()
    }
    
    private func initializeCell(row: Int, column: Int) -> CellViewModel {
        .init(.init(row: row, column: column), delegate: self)
    }
    
    private func initializeRow(_ index: Int) -> GameGridRow {
        let row = GameGridRow(index, items: [])
        for column in 0..<10 {
            row.append(initializeCell(row: index, column: column))
        }
        return row
    }
    
    private func initializeGrid() -> [GameGridRow] {
        var grid: [GameGridRow] = []
        for row in 0..<10 {
            grid.append(initializeRow(row))
        }
        return grid
    }
    
    public func resetGrid() {
        self.rows = initializeGrid()
    }
    
    public func shouldCheckMatch() {
        let state: CellState = .owned(.zero)
        if rows[0].items[0].state == state &&
            rows[0].items[1].state == state &&
            rows[0].items[2].state == state {
            rows[0].items[0].state = .burnt
            rows[0].items[1].state = .burnt
            rows[0].items[2].state = .burnt
        }
    }
}


public final class GameGridRow: Identifiable {
    public let id: Int
    public var items: [CellViewModel] = []
    
    public init(_ id: Int, items: [CellViewModel]) {
        self.id = id
        self.items = items
    }
    
    func append(_ item: CellViewModel) {
        items.append(item)
    }
}
