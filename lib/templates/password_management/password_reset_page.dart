import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();

  int _stepIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 700),
          child: Stepper(
            currentStep: _stepIndex,
            onStepCancel: () {
              if (_stepIndex > 0) {
                setState(() {
                  _stepIndex--;
                });
              }
            },
            onStepContinue: () {
              if (_stepIndex < 2) {
                setState(() {
                  _stepIndex++;
                });
              }
            },
            onStepTapped: (index) {
              if (_stepIndex != index && index < 2) {
                setState(() {
                  _stepIndex = index;
                });
              }
            },
            steps: [
              Step(
                title: Text('Request Password Reset'),
                content: _buildResetPasswordForm(),
                isActive: _stepIndex == 0,
                state: _stepIndex > 0 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: Text('Confirm New Password'),
                content: _buildConfirmationForm(),
                isActive: _stepIndex == 1,
                state: _stepIndex > 1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: Text('Done'),
                content: Text('Your password was successfully reset.'),
                isActive: _stepIndex == 2,
                state: _stepIndex == 2 ? StepState.complete : StepState.indexed,
              ),
            ],
            controlsBuilder: (BuildContext context,
                {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              switch (_stepIndex) {
                case 0:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: onStepContinue,
                        child: const Text('Skip'),
                      ),
                      ElevatedButton(
                        onPressed: _resetPassword,
                        child: const Text('Reset Password'),
                      ),
                    ],
                  );
                case 1:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: onStepCancel,
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: _confirm,
                        child: const Text('Confirm'),
                      ),
                    ],
                  );
                case 2:
                  return ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Text('Sign In'),
                  );
                default:
                  throw Exception('Index out of bounds: $_stepIndex');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your username',
              labelText: 'Username'
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'We sent you an email with your confirmation code. Please check your inbox.'),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your username',
              labelText: 'Username'
          ),
        ),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Enter your new password',
              labelText: 'New password'
          ),
        ),
        TextFormField(
          controller: _confirmationCodeController,
          decoration: InputDecoration(
              icon: Icon(Icons.check),
              hintText: 'Enter confirmation code',
              labelText: 'Confirmation code'
          ),
        ),
      ],
    );
  }

  void _resetPassword() async {
    try {
      await Amplify.Auth.resetPassword(
        username: _usernameController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully sent confirmation code'),
      ));
      setState(() {
        _stepIndex = 1;
      });
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _confirm() async {
    try {
      await Amplify.Auth.confirmPassword(
        username: _usernameController.text.trim(),
        newPassword: _passwordController.text.trim(),
        confirmationCode: _confirmationCodeController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully reset password'),
      ));
      setState(() {
        _stepIndex = 2;
      });
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
