import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String supplierName;

  const ChatScreen({super.key, required this.supplierName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final Map<String, String> _autoReplies = {
    'मुला': 'मुलाको बीउ अहिले मौसमी रुपमा उपयुक्त छ। कृपया परिमाण बताउनुहोस्।',
    'धान':
        'धानका लागि हामीसँग Ram Dhan, Sona Mansuli, र Hybrid धान उपलब्ध छन्।',
    'विक्री':
        'तपाईं विक्रीका लागि चाहनुहुन्छ भने कृपया मात्रा र स्थान उल्लेख गर्नुहोस्।',
    'किन्न चाहन्छु': 'कृपया कुन बाली किन्न चाहनुहुन्छ? हामी विवरण दिनेछौं।',
    'खाद': 'हामीसँग जैविक र रासायनिक खाद दुवै उपलब्ध छन्। कुन चाहिन्छ?',
    'सहायता': 'कृपया तपाईंलाई कुन विषयमा सहायता चाहिएको हो भन्ने बताउनुहोस्।',
    'पानी': 'सिंचाइको लागि पानी व्यवस्थापन समाधानहरू पनि उपलब्ध छन्।',
    'पेस्टिसाइड':
        'पेस्टिसाइडको लागि हामीसँग विभिन्न विकल्प छन्। तपाईको बाली अनुसार सुझाव दिन सक्छौं।',
  };

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_Message(text: text, isMe: true));
    });

    _controller.clear();

    // Scroll to bottom after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });

    // Auto-reply logic
    Future.delayed(const Duration(milliseconds: 800), () {
      String reply = 'यो तपाईको सन्देशको प्रतिक्रिया हो: "$text"';

      for (var keyword in _autoReplies.keys) {
        if (text.toLowerCase().contains(keyword)) {
          reply = _autoReplies[keyword]!;
          break;
        }
      }

      setState(() {
        _messages.add(_Message(text: reply, isMe: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.supplierName} सँग च्याट')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: message.isMe
                          ? Colors.blueAccent.withOpacity(0.8)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'सन्देश लेख्नुहोस्...',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isMe;
  _Message({required this.text, required this.isMe});
}
