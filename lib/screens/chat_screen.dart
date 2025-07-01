import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String buyerName;
  final String sellerName;

  const ChatScreen({
    super.key,
    required this.buyerName,
    required this.sellerName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Auto-replies triggered by keywords in user message
  final Map<String, String> _autoReplies = {
    'मुला': 'मुलाको बीउ अहिले मौसमी रुपमा उपयुक्त छ। कृपया परिमाण बताउनुहोस्।',
    'धान': 'धानका लागि हामीसँग Ram Dhan, Sona Mansuli, र Hybrid धान उपलब्ध छन्।',
    'विक्री': 'तपाईं विक्रीका लागि चाहनुहुन्छ भने कृपया मात्रा र स्थान उल्लेख गर्नुहोस्।',
    'किन्न चाहन्छु': 'कृपया कुन बाली किन्न चाहनुहुन्छ? हामी विवरण दिनेछौं।',
    'खाद': 'हामीसँग जैविक र रासायनिक खाद दुवै उपलब्ध छन्। कुन चाहिन्छ?',
    'सहायता': 'कृपया तपाईंलाई कुन विषयमा सहायता चाहिएको हो भन्ने बताउनुहोस्।',
    'पानी': 'सिंचाइको लागि पानी व्यवस्थापन समाधानहरू पनि उपलब्ध छन्।',
    'पेस्टिसाइड': 'पेस्टिसाइडको लागि हामीसँग विभिन्न विकल्प छन्। तपाईको बाली अनुसार सुझाव दिन सक्छौं।',
  };

  // Preset questions and their answers
  final Map<String, String> _qaMap = {
    "तपाईंको उत्पादनको गुणस्तर कस्तो छ?": "हाम्रो उत्पादन उच्च गुणस्तरको र प्रमाणित छ।",
    "मूल्य कति छ?": "हामी उचित मूल्य निर्धारण गर्छौं र आवश्यक परे छुट पनि दिन्छौं।",
    "डेलिभरी समय कति हुन्छ?": "सामान्यतया ३-५ दिन भित्र डेलिभरी गरिन्छ।",
    "भुक्तानीका विकल्पहरू के छन्?": "नगद, मोबाइल बैंकिङ, र बैंक ट्रान्सफर उपलब्ध छन्।",
    "के तपाईंसँग अर्डर कन्फर्मेसन छ?": "हो, हामी तपाईंको अर्डर कन्फर्मेसनको लागि सम्पर्क गर्नेछौं।",
  };

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_Message(sender: widget.buyerName, text: text));
    });

    _controller.clear();
    _scrollToBottom();

    // Check for keyword in text for auto reply
    String reply = 'यो तपाईको सन्देशको प्रतिक्रिया हो: "$text"';
    for (var keyword in _autoReplies.keys) {
      if (text.toLowerCase().contains(keyword)) {
        reply = _autoReplies[keyword]!;
        break;
      }
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add(_Message(sender: widget.sellerName, text: reply));
      });
      _scrollToBottom();
    });
  }

  void _onQuestionTap(String question) {
    setState(() {
      _messages.add(_Message(sender: widget.buyerName, text: question));
      _messages.add(_Message(sender: widget.sellerName, text: _qaMap[question]!));
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
        title: Text('${widget.sellerName} सँग च्याट'),
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
                final isBuyer = message.sender == widget.buyerName;
                return Align(
                  alignment:
                      isBuyer ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color:
                          isBuyer ? Colors.green.shade600 : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft:
                            Radius.circular(isBuyer ? 18 : 4),
                        bottomRight:
                            Radius.circular(isBuyer ? 4 : 18),
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
                        color: isBuyer ? Colors.white : Colors.black87,
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
