import 'package:flutter/material.dart';

class BuyerChatbotScreen extends StatefulWidget {
  const BuyerChatbotScreen({super.key});

  @override
  State<BuyerChatbotScreen> createState() => _BuyerChatbotScreenState();
}

class _BuyerChatbotScreenState extends State<BuyerChatbotScreen> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Auto-replies based on keywords
  final Map<String, String> _autoReplies = {
    'धान': 'धानका लागि सिफारिस: Ram Dhan, Sona Mansuli, र Hybrid।',
    'मकै': 'मकैको लागि हाइब्रिड र देशी बिउ उपलब्ध छन्।',
    'खाद': 'हामीसँग जैविक र रासायनिक खाद उपलब्ध छन्। कुन चाहिन्छ?',
    'पानी': 'सिंचाइ व्यवस्थापन सेवाहरू पनि उपलब्ध छन्।',
    'पेस्टिसाइड': 'पेस्टिसाइडका लागि कृपया बालीको नाम दिनुहोस्।',
    'ढुवानी': 'ढुवानी सेवा तपाईंको अर्डरपछि उपलब्ध हुन्छ।',
    'सहायता': 'कृपया तपाईंलाई कुन विषयमा सहायता चाहिएको हो भनेर लेख्नुहोस्।',
  };

  // Frequently asked questions
  final Map<String, String> _qaMap = {
    'बाली कस्तो छ?': 'हाम्रो बाली ताजा र उच्च गुणस्तरको हुन्छ।',
    'मूल्य कति छ?': 'मूल्य स्थान र परिमाण अनुसार फरक हुन्छ।',
    'डेलिभरी कसरी हुन्छ?': 'डेलिभरी ३-५ दिन भित्र हुन्छ।',
    'भुक्तानीको तरिका के हो?': 'नगद, इ-सेवा, फोन पे र बैंक ट्रान्सफर।',
    'सम्पर्क कसरी गर्ने?': 'हामीलाई फोन वा च्याट मार्फत सम्पर्क गर्न सक्नुहुन्छ।',
  };

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_Message(sender: 'तपाईं', text: text));
    });

    _controller.clear();
    _scrollToBottom();

    String reply = 'माफ गर्नुहोस्, कृपया स्पष्ट रूपमा सोध्नुहोस्।';
    for (var keyword in _autoReplies.keys) {
      if (text.contains(keyword)) {
        reply = _autoReplies[keyword]!;
        break;
      }
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add(_Message(sender: 'च्याटबोट', text: reply));
      });
      _scrollToBottom();
    });
  }

  void _onQuestionTap(String question) {
    setState(() {
      _messages.add(_Message(sender: 'तपाईं', text: question));
      _messages.add(_Message(sender: 'च्याटबोट', text: _qaMap[question]!));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('क्रेता च्याटबोट सहायता'),
        backgroundColor: Colors.green.shade700,
        elevation: 4,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.sender == 'तपाईं';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.green.shade600
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(isUser ? 18 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 18),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 16,
                        height: 1.3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _qaMap.keys.map((question) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green.shade700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.green.shade50,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                      ),
                      onPressed: () => _onQuestionTap(question),
                      child: Text(
                        question,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'सन्देश लेख्नुहोस्...',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
  final String sender;
  final String text;
  _Message({required this.sender, required this.text});
}
