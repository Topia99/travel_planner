//
//  ChatViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 12/9/24.
//

import Foundation
import OpenAI

final class ChatViewModel: ObservableObject {
    
    // This holds the raw itinerary text, which can be replaced as needed.
    private let client: OpenAI
    var itinerary = ""
    @Published var messages: [Message] = []
    @Published var isLoading = false
    
    // Now we build the system prompt by inserting the itinerary dynamically
    lazy var systemMessagePrompt = """
    You are a Trip Assistant Chatbot. You have been provided with the following trip itinerary details:
    
    \(itinerary)
    
    Instructions for the assistant:
    
    1. Primary Focus:
       The user may request any transformation, editing, or repurposing of the provided itinerary content. For example, the user can ask to format it into a social media post, a travel blog guide, a printable itinerary, or to clarify details about the trip.
    
    2. Scope of Responses:
       If the user’s request is related to the provided trip itinerary—such as editing it, adding details, or turning it into sharable content in any style—comply and help them.
    
       If the user’s request is unrelated to the trip itinerary or travel planning, respond politely with:
       "Your request is not related to travel planning or the provided trip itinerary. Our chat assistant only handles requests related to the given travel details."
    
    4. **Output Regulations:**  
       - Do **not** use bold text, italics, or any special formatting.  
       - Do **not** use emojis or symbols.  
       - Structure all responses as clear and complete paragraphs with appropriate line breaks. Avoid lists or bullet points.
    
    5. Initial Interaction:
       When the user first opens this view (before the user sends any message), greet them warmly and briefly let them know you have details for their trip itinerary (list the title and start date to end date). Then ask how you can assist. Be short, friendly, and inviting.
    
    6. Tone & Style:
       Be friendly, helpful, clear, and concise.
       When declining unrelated requests, remain polite and provide a brief explanation in paragraph form.
    
    You must follow these instructions for every user message.
    """
    
    init(itinerary: String) {
        self.itinerary = itinerary
        
        // Fetch the API token from Info.plist
        guard let apiToken = Bundle.main.object(forInfoDictionaryKey: "Open_api_key") as? String else {
            fatalError("API token not found. Ensure OPENAI_API_TOKEN is set in Info.plist.")
        }
        
        // Initialize the OpenAI client with the fetched API token
        self.client = OpenAI(apiToken: apiToken)
        
        // Trigger initial greeting immediately when ViewModel is created
        sendInitialMessage()
    }
    
    private func sendInitialMessage() {
        // We'll send an empty user message to trigger the assistant to respond with the initial greeting based on the system message
        getBotReply()
    }
    
    func sendNewMessage(content: String) {
        // Append user's message immediately
        let userMessage = Message(content: content, isUser: true)
        self.messages.append(userMessage)
        
        // Now fetch the bot's reply
        getBotReply()
    }
    
    func getBotReply() {
        
        // Construct the query from current messages
        let query = ChatQuery(
            messages: [.init(role: .system, content: systemMessagePrompt)!] + messages.map { .init(role: $0.isUser ? .user : .assistant, content: $0.content)! },
            model: .gpt4_o_mini,
            maxTokens: 500
        )
        
        // Indicate that we're now waiting for a response
        isLoading = true
        
        // Append a placeholder for the streaming response
        let botMessageIndex = messages.count
        self.messages.append(Message(content: "", isUser: false))
        
        client.chatsStream(query: query) { partialResult in
            DispatchQueue.main.async {
                switch partialResult {
                case .success(let chunk):
                    if let token = chunk.choices.first?.delta.content {
                        self.messages[botMessageIndex].content += token
                    }
                case .failure(let error):
                    print("Streaming error: \(error)")
                }
            }
        } completion: { error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let err = error {
                    print("Completed with error: \(err)")
                }
            }
        }
    }
}
