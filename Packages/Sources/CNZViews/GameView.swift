
import CNZModels
import SwiftUI

public struct GameView: View {
    
    @ObservedObject private var grid: GameGrid = GameGrid()
    
    public init() {}
    
    public var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            rows(grid.rows)
        }
        .padding(16)
        .frame(width: UIScreen.main.bounds.width)
    }
    
    @ViewBuilder
    private func rows(_ rows: [GameGridRow]) -> some View {
        ForEach(rows) { row in
            GridRow {
                columns(row)
            }
        }
    }
    
    @ViewBuilder
    private func columns(_ row: GameGridRow) -> some View {
        ForEach(row.items) { vm in
            Cell(vm)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
