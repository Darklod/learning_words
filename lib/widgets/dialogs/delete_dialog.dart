import 'package:flutter/material.dart';
import 'package:learningwords/widgets/dialogs/custom_action.dart';

class DeleteDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      title: const Text('Confirm Delete'),
      content: const Text("Are you sure you want to delete selected words?"),
      actions: [
        CustomDialogAction(
          title: "CANCEL",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CustomDialogAction(
          title: "OK",
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

