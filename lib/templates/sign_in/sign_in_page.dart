import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import '../password_management/password_reset_page.dart';
import '../sign_up/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  final void Function(BuildContext) onSignIn;

  const SignInPage({
    Key? key,
    this.onSignIn = _defaultOnSignIn,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
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
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Enter your password',
                labelText: 'Password'
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PasswordResetPage()),
                  );
                },
                child: Text(
                  'Reset Password',
                ),
              ),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
              ),
            ],
          ),
          /*+++START allowUnauthenticatedIdentities+++*/
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => widget.onSignIn(context),
                child: Text(
                  'Sign in as guest',
                ),
              ),
            ],
          ),
          /*+++END allowUnauthenticatedIdentities+++*/
        ],
      ),
    );
  }

  void _signIn() async {
    var username = _usernameController.text.trim();
    var password = _passwordController.text.trim();
    try {
      await Amplify.Auth.signOut();
      SignInResult result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      if(result.isSignedIn) {
        widget.onSignIn(context);
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

void _defaultOnSignIn(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Successfully signed in'),
  ));
}
