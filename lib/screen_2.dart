// Screen2.dart (to be implemented in module 2)
import 'package:flutter/material.dart';
import 'package:flutter_module3_shared/shared_communicator.dart';
import 'package:flutter_module3_shared/shared_object.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final TextEditingController _messageController = TextEditingController();
  Color _selectedColor = Colors.white;

  // Predefined color options
  final List<Color> _colorOptions = [
    Colors.white,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.pink[100]!,
    Colors.yellow[100]!,
    Colors.purple[100]!,
  ];

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      final messageShared = SharedCommunicator().get<SharedMessage>('messages');
      if (messageShared != null) {
        messageShared.sendMessage(message);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent to Screen 1!')),
        );
      }
    }
  }

  void _updateBackgroundColor(Color color) {
    setState(() {
      _selectedColor = color;
    });

    final uiState = SharedCommunicator().get<SharedUIState>('uiState');
    if (uiState != null) {
      uiState.updateProperty('backgroundColor', color);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Background color updated on Screen 1!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Send a message to Screen 1:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type a message...',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send Message'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Change background color of Screen 1:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _colorOptions.map((color) {
                return GestureDetector(
                  onTap: () => _updateBackgroundColor(color),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: _selectedColor == color
                            ? Colors.black
                            : Colors.grey,
                        width: _selectedColor == color ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
