//
//  SwiftUIView.swift
//  
//
//  Created by Denny on 11/02/23.
//

import CNZModels
import SwiftUI

struct Cell: View {
    
    @ObservedObject private var viewModel: CellViewModel
    
    public init(_ viewModel: CellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
            viewModel.didChangeState()
        } label: {
            Image(systemName: viewModel.state.image)
                .resizable()
                .tint(.gray)
                .aspectRatio(.init(exactly: 1), contentMode: .fit)
                .padding(8)
                .background(viewModel.state.background)
        }
        .disabled(viewModel.isLocked)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Cell(CellViewModel.init(.init(row: 0, column: 0)))
    }
}
