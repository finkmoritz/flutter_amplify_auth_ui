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
  /*+++START usernameAttributes[username]+++*/
  final TextEditingController _usernameController = TextEditingController();
  /*+++END usernameAttributes[username]+++*/
  /*+++START usernameAttributes[email]+++*/
  final TextEditingController _emailController = TextEditingController();
  /*+++END usernameAttributes[email]+++*/
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    /*+++START usernameAttributes[username]+++*/
    _usernameController.dispose();
    /*+++END usernameAttributes[username]+++*/
    /*+++START usernameAttributes[email]+++*/
    _emailController.dispose();
    /*+++END usernameAttributes[email]+++*/
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 700),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*+++START usernameAttributes[username]+++*/
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter your username',
                      labelText: 'Username'
                  ),
                ),
                /*+++END usernameAttributes[username]+++*/
                /*+++START usernameAttributes[email]+++*/
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      hintText: 'Enter your email address',
                      labelText: 'Email address'
                  ),
                ),
                /*+++END usernameAttributes[email]+++*/
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
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text('Sign Up'),
                    ),
                    /*+++START allowUnauthenticatedIdentities+++*/
                    TextButton(
                      onPressed: () => widget.onSignIn(context),
                      child: Text('Sign in as guest'),
                    ),
                    /*+++END allowUnauthenticatedIdentities+++*/
                    ElevatedButton(
                      onPressed: _signIn,
                      child: Text('Sign In'),
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PasswordResetPage()),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                      ),
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    /*+++START authProvidersUserPool[Facebook]+++*/
                    ElevatedButton(
                      onPressed: () => _signInWithWebUI(provider: AuthProvider.facebook),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(66, 103, 178, 1.0)),
                        elevation: MaterialStateProperty.all(4.0),
                      ),
                      child: Text('Sign in with Facebook'),
                    ),
                    /*+++END authProvidersUserPool[Facebook]+++*/
                    /*+++START authProvidersUserPool[Google]+++*/
                    ElevatedButton(
                      onPressed: () => _signInWithWebUI(provider: AuthProvider.google),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(Colors.blueGrey),
                        elevation: MaterialStateProperty.all(4.0),
                      ),
                      child: Text('Sign in with Google'),
                    ),
                    /*+++END authProvidersUserPool[Google]+++*/
                    /*+++START authProvidersUserPool[LoginWithAmazon]+++*/
                    ElevatedButton(
                      onPressed: () => _signInWithWebUI(provider: AuthProvider.amazon),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 153, 0, 1.0)),
                        elevation: MaterialStateProperty.all(4.0),
                      ),
                      child: Text('Sign in with Amazon'),
                    ),
                    /*+++END authProvidersUserPool[LoginWithAmazon]+++*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      await Amplify.Auth.signOut();
      SignInResult result = await Amplify.Auth.signIn(
        /*+++START usernameAttributes[username]+++*/
        username: _usernameController.text.trim(),
        /*+++END usernameAttributes[username]+++*/
        /*+++START usernameAttributes[email]+++
        username: _emailController.text.trim(),
        +++END usernameAttributes[email]+++*/
        password: _passwordController.text.trim(),
      );
      if(result.isSignedIn) {
        widget.onSignIn(context);
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  /*+++START authProvidersUserPool[any]+++*/
  void _signInWithWebUI({AuthProvider? provider}) async {
    try {
      SignInResult result = await Amplify.Auth.signInWithWebUI(provider: provider);
      if(result.isSignedIn) {
        widget.onSignIn(context);
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
  /*+++END authProvidersUserPool[any]+++*/
}

void _defaultOnSignIn(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Successfully signed in'),
  ));
}
