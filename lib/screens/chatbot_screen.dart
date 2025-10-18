import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_constants.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final String _userId = 'user-${const Uuid().v4()}';
  final String _agronomistId = 'agronomist-${const Uuid().v4()}';

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    // Add welcome message
    _messages.add(
      ChatMessage(
        id: 'welcome-${const Uuid().v4()}',
        createdAt: DateTime.now(),
        text: 'Hello! I\'m your AI Agronomist. How can I help you with your farming today?',
        sender: 'agronomist',
      ),
    );
  }

  void _handleSendPressed() {
    if (_textController.text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: 'user-${const Uuid().v4()}',
      createdAt: DateTime.now(),
      text: _textController.text,
      sender: 'user',
    );

    setState(() {
      _messages.add(userMessage);
    });

    _textController.clear();

    // Simulate AI response after a delay
    Future.delayed(const Duration(seconds: 1), () {
      _addAgronomistResponse(_textController.text);
    });
  }

  void _addAgronomistResponse(String userQuery) {
    String response = _getAgronomistResponse(userQuery);

    final agronomistMessage = ChatMessage(
      id: 'agronomist-${const Uuid().v4()}',
      createdAt: DateTime.now(),
      text: response,
      sender: 'agronomist',
    );

    setState(() {
      _messages.add(agronomistMessage);
    });
  }

  String _getAgronomistResponse(String query) {
    // Simple response logic based on query keywords
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.contains('fertilizer') || lowerQuery.contains('manure')) {
      return 'For maize in the rainy season, I recommend using NPK 15-15-15 at planting, '
          'followed by top-dressing with Urea at the 4-6 leaf stage. Apply 100kg per hectare '
          'of NPK at planting and 50kg per hectare of Urea during top-dressing.';
    } else if (lowerQuery.contains('pest') || lowerQuery.contains('insect')) {
      return 'Common pests for maize include stem borers, armyworms, and aphids. '
          'For stem borers, apply Carbofuran at planting (1-2kg per hectare). '
          'For aphids, use Imidacloprid at 0.5ml per liter of water, sprayed weekly '
          'during the growing season.';
    } else if (lowerQuery.contains('water') || lowerQuery.contains('irrigation')) {
      return 'For optimal maize growth, maintain soil moisture at 60-70% of field capacity. '
          'In the absence of rain, irrigate every 3-4 days during the growing season, '
          'applying 25-30mm of water per irrigation. Reduce frequency during the ripening stage.';
    } else if (lowerQuery.contains('plant') || lowerQuery.contains('seed')) {
      return 'For maize, plant seeds at a depth of 2-3cm with spacing of 75cm between rows '
          'and 25-30cm between plants. This gives you approximately 53,000 plants per hectare. '
          'Plant during the onset of rains for optimal germination.';
    } else if (lowerQuery.contains('weather') || lowerQuery.contains('rain')) {
      return 'Based on your location (Kampala, Uganda), we\'re expecting favorable rainfall '
          'for the next two weeks. This is a good time to plant your second season crops. '
          'Monitor soil moisture and consider mulching to retain moisture.';
    } else {
      return 'That\'s an interesting question about farming! Based on your query, '
          'I recommend consulting with local agricultural extension officers for '
          'specific advice. Also, consider factors like your soil type, climate, '
          'and local pest pressures when making farming decisions.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Smart Agronomist'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.language),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: 'lg',
                child: Text('Luganda'),
              ),
              const PopupMenuItem(
                value: 'sw',
                child: Text('Swahili'),
              ),
            ],
            onSelected: (value) {
              // Handle language change
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick action buttons
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildQuickActionButton(
                'Pest Control Tips',
                Icons.bug_report,
                () {
                  _textController.text = 'How do I control pests in my maize farm?';
                  _handleSendPressed();
                },
              ),
              const SizedBox(width: 8),
              _buildQuickActionButton(
                'Best Fertilizer',
                Icons.local_florist,
                () {
                  _textController.text = 'What is the best fertilizer for maize?';
                  _handleSendPressed();
                },
              ),
              const SizedBox(width: 8),
              _buildQuickActionButton(
                'Check Market Prices',
                Icons.trending_up,
                () {
                  _textController.text = 'What are the current market prices for maize?';
                  _handleSendPressed();
                },
              ),
              const SizedBox(width: 8),
              _buildQuickActionButton(
                'Weather Advice',
                Icons.wb_sunny,
                () {
                  _textController.text = 'How will the weather affect my crops this week?';
                  _handleSendPressed();
                },
              ),
            ],
          )),
          const SizedBox(height: 8),
          // Chat messages list
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.sender == 'user';
                
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? AppConstants.primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input area
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _handleSendPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String text, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppConstants.primaryColor,
        side: BorderSide(color: AppConstants.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String id;
  final DateTime createdAt;
  final String text;
  final String sender; // 'user' or 'agronomist'

  ChatMessage({
    required this.id,
    required this.createdAt,
    required this.text,
    required this.sender,
  });
}