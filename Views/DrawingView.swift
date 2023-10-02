//
//  DrawingView.swift
//  kata (iOS)
//
//  Created by Evgeny Mikhalkov on 2023-09-23.
//

import SwiftUI

struct DrawingView: View {
    var image: UIImage?
    
    var body: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
