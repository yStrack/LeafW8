//
//  ARViewWrapper.swift
//  Balanca
//
//  Created by Yuri Strack on 25/09/20.
//

import Foundation
import SwiftUI
import ARKit

struct ARViewWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARView
    func makeUIViewController(context: Context) -> ARView {
        return ARView()
    }
    func updateUIViewController(_ uiViewController:
                                    ARViewWrapper.UIViewControllerType, context:
                                        UIViewControllerRepresentableContext<ARViewWrapper>) { }
}
