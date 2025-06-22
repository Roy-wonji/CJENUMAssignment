//
//  ProductRowView.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/22/25.
//

import SwiftUI

struct ProductRowView: View {
  let product: ProductResponseModel
  @State private var isPressed = false

  var body: some View {
    HStack(spacing: 12) {
      AsyncImage(url: URL(string:  product.image)) { image in
        image.resizable().scaledToFill()
      } placeholder: {
        Color(.systemGray5)
      }
      .frame(width: 80, height: 80)
      .cornerRadius(8)
      .accessibilityHidden(true)

      VStack(alignment: .leading, spacing: 6) {
        Text(product.name)
          .font(.headline)
          .lineLimit(2)
        HStack(spacing: 4) {
          Text("\(product.price.formatted(.number))원")
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.purple)
          if product.discountRate > 0 {
            Text("\(product.discountRate)%")
              .font(.caption2)
              .foregroundColor(.secondary)
          }
        }
      }
      Spacer()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    )
    .scaleEffect(isPressed ? 0.97 : 1.0)
    .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
      withAnimation(.easeInOut(duration: 0.2)) { isPressed = pressing }
    }, perform: {})
    .accessibilityElement(children: .combine)
    .accessibilityIdentifier("ProductRowButton_\(product.id)")
    .accessibilityLabel("\(product.name), 가격 \(product.price)원, 할인율 \(product.discountRate)%")
  }
}
