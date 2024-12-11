//
//  ChatView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 12/9/24.
//

import SwiftUI

struct Message: Identifiable, Equatable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}

struct ChatView: View {
    
    @ObservedObject var vm: ChatViewModel
    @State var messageTextField: String = ""
    @FocusState private var messageFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(vm.messages) { message in
                            MessageView(message: message)
                                .padding(.horizontal)
                        }
//                            Spacer(minLength: 500) // add extra space below
                    }
                    .padding(.top, 20)
                    .onChange(of: vm.messages) { messages in
                        if let lastMessage = messages.last {
                            withAnimation {
                                scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            
            // Input bar
            Divider()
            HStack(alignment: .center) {
                TextField("Message", text: $messageTextField, axis: .vertical)
                    .padding(.horizontal, 5)
                    .focused($messageFieldIsFocused)
                
                Button {
                    let contentToSend = messageTextField
                    messageTextField = ""
                    vm.sendNewMessage(content: contentToSend)
                    messageFieldIsFocused = false
                } label: {
                    Image(systemName: "paperplane")
                        .foregroundStyle(vm.isLoading || messageTextField.isEmpty ? .gray : .blue)
                }
                .disabled(vm.isLoading || messageTextField.isEmpty)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Trip Assistant")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            // Dismiss the keyboard when tapping outside the TextField
            messageFieldIsFocused = false
        }
    }
}


struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack(alignment: .top) {
            if message.isUser {
                Spacer()
                Text(message.content)
                    .padding(12)
                    .foregroundColor(.black)
                    .background(Color(UIColor.systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    
                    Text(message.content)
                        .padding(12)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .frame(maxWidth: 250, alignment: .leading)
                        .contextMenu {
                            Button {
                                UIPasteboard.general.string = message.content
                            } label: {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                        }
                }
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

    
