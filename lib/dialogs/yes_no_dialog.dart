import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  final VoidCallback onSuccess;
  const YesNoDialog({Key? key, required this.onSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Anime?"),
      content: const Text("Deleted Anime cannot be recovered."),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text("No")),
        const SizedBox(width: 8.0),
        TextButton(onPressed: () {
          onSuccess.call();
        }, child: const Text("Yes"))
      ],
    );
  }
}
