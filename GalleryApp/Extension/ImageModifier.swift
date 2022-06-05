//
//  ImageModifier.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/5/22.
//

import SwiftUI

extension Image {
  func imageModifier() -> some View {
    self
      .resizable()
      .scaledToFill()
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.white, lineWidth: 2))
      .frame(width: 100.0, height: 100.0)
  }
  
  func iconModifier() -> some View {
    self
      .imageModifier()
      .frame(maxWidth: 128)
      .foregroundColor(.purple)
      .opacity(0.5)
  }
}
