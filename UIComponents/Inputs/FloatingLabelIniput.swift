//
//  FloatingLabelIniput.swift
//  UIComponents
//
//  Created by Fernando Florez on 3/02/24.
//

import SwiftUI

struct FloatingLabelIniput: View {
    var label: String
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    @Namespace private var labelNameSpace
    @State private var shouldShowLabelOnTop = false
    
    private var labelAnimationId = "LabelAnimationID"
    
    private var isFocusedOrFilled: Bool {
        isFocused || !text.isEmpty
    }
    
    init(_ label: String, text: Binding<String>) {
        self.label = label
        self._text = text
    }
    
    var body: some View {
        TextField("", text: $text)
            .focused($isFocused)
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 8)
            .frame(height: 48)
            .foregroundStyle(Color(fromAssets: .textFieldTextColor))
            .overlay(alignment: .leading) {
                if !shouldShowLabelOnTop && text.isEmpty {
                    Text(label)
                        .font(.body)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .foregroundStyle(Color(fromAssets: .textFieldLabel))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .matchedGeometryEffect(
                            id: labelAnimationId,
                            in: labelNameSpace,
                            anchor: .bottom
                        )
                }
            }
            .overlay(alignment: .topLeading) {
                if shouldShowLabelOnTop || isFocusedOrFilled {
                    Text(label)
                        .font(.footnote)
                        .padding(.horizontal, 16)
                        .padding(.top, 6)
                        .foregroundStyle(Color(fromAssets: .textFieldLabel))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .matchedGeometryEffect(
                            id: labelAnimationId,
                            in: labelNameSpace,
                            anchor: .top
                        )
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: -2)
                    .stroke(
                        Color(fromAssets: isFocused ? .textFieldBorderFocused : .textFieldBoder),
                        lineWidth: 2
                    )
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.2)) {
                    shouldShowLabelOnTop = true
                    isFocused = true
                }
            }
            .onChange(of: isFocused) {
                guard !isFocused else { return }
                
                withAnimation(.spring(response: 0.2)) {
                    shouldShowLabelOnTop = false
                }
            }
    }
}

struct FormView: View {
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 32) {
            Text("How to create a TextField\nwith a floating label???")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
            
            FloatingLabelIniput("Your insta’s username", text: $text)
        }
        .padding(20)
    }
}

#Preview {
    FormView()
}
