import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiAdvisoryScreen extends StatefulWidget {
  const AiAdvisoryScreen({super.key});

  @override
  State<AiAdvisoryScreen> createState() => _AiAdvisoryScreenState();
}

class _AiAdvisoryScreenState extends State<AiAdvisoryScreen> {
    String apiKey = "AIzaSyA94FF3N-q_j9xZDN-KQaC3cHYcHADQp4U";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.grass, color: Colors.green, size: 26), 
              SizedBox(width: 8),
              Text(
                // Changed title text
                "AI Advisory",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
          child: LlmChatView(
            suggestions: const [
              "What's the best time to plant tomatoes in my region?",
              "What are effective organic ways to control aphids?",
            ],
            style: LlmChatViewStyle(
              backgroundColor: Colors.transparent,
              chatInputStyle: ChatInputStyle(
                hintText: "Ask about soil or pests...",
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              suggestionStyle: SuggestionStyle(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            provider: GeminiProvider(
              model: GenerativeModel(
                model: "gemini-2.0-flash",
                apiKey: apiKey,
                systemInstruction: Content.system(
                  "You are a professional agricultural and crop advisory assistant, specializing in sustainable farming practices. Only respond to questions related to farming, crops, soil health, pest management, and livestock. Provide concise, actionable advice. If a question is unrelated to agriculture, politely inform the user that you can only answer farming and crop-related queries.",
                ),
              ),
            ),

            welcomeMessage:
                "Hello Farmer! 🌾 I'm your digital Agri-Advisor. Ask me anything about your farm, crops, or soil health.",
          ),
        ),
      ),
    );
  }
}
