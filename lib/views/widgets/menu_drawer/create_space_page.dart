import 'package:flutter/material.dart';

class CreateSpacePage extends StatelessWidget {
  final VoidCallback onCancel;
  final Function(String) onConfirm;

  CreateSpacePage({super.key, required this.onConfirm, required this.onCancel});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  const Text('Create a new space'),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Space name...',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => onConfirm(_nameController.text),
                  child: const Text('Confirm'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blue[100],
                  ),
                  onPressed: onCancel,
                  child: const Text('Cancel'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
