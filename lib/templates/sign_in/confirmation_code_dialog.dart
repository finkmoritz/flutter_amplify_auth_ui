import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class ConfirmationCodeDialog extends StatefulWidget {
  final void Function(BuildContext) onSignIn;

  const ConfirmationCodeDialog({Key? key, required this.onSignIn})
      : super(key: key);

  @override
  _ConfirmationCodeDialogState createState() => _ConfirmationCodeDialogState();
}

class _ConfirmationCodeDialogState extends State<ConfirmationCodeDialog> {
  final TextEditingController _confirmationCodeController =
      TextEditingController();

  @override
  void dispose() {
    _confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation Code'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Please enter the confirmation code we sent you.'),
            TextFormField(
              controller: _confirmationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(Icons.check_outlined),
                  hintText: 'Enter your confirmation code',
                  labelText: 'Confirmation code'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _confirm();
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  }

  void _confirm() async {
    try {
      var result = await Amplify.Auth.confirmSignIn(
        confirmationValue: _confirmationCodeController.text.trim(),
      );
      if (result.isSignedIn) {
        Navigator.of(context).pop();
        widget.onSignIn(context);
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
