import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import '../password_management/password_reset_page.dart';
import '../sign_up/sign_up_page.dart';
/*+++START mfaConfiguration[ON]+++*/
import 'confirmation_code_dialog.dart';
/*+++END mfaConfiguration[ON]+++*/

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
  /*+++START usernameAttributes[phone_number]+++*/
  final TextEditingController _phoneNumberController = TextEditingController();
  /*+++END usernameAttributes[phone_number]+++*/
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    /*+++START usernameAttributes[username]+++*/
    _usernameController.dispose();
    /*+++END usernameAttributes[username]+++*/
    /*+++START usernameAttributes[email]+++*/
    _emailController.dispose();
    /*+++END usernameAttributes[email]+++*/
    /*+++START usernameAttributes[phone_number]+++*/
    _phoneNumberController.dispose();
    /*+++END usernameAttributes[phone_number]+++*/
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
                      icon: Icon(Icons.person_outline),
                      hintText: 'Enter your username',
                      labelText: 'Username'),
                ),
                /*+++END usernameAttributes[username]+++*/
                /*+++START usernameAttributes[email]+++*/
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline),
                      hintText: 'Enter your email address',
                      labelText: 'Email address'),
                ),
                /*+++END usernameAttributes[email]+++*/
                /*+++START usernameAttributes[phone_number]+++*/
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone_outlined),
                      hintText: 'Enter your phone number',
                      labelText: 'Phone number'),
                ),
                /*+++END usernameAttributes[phone_number]+++*/
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      hintText: 'Enter your password',
                      labelText: 'Password'),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordResetPage()),
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
                    /*+++START authProvidersUserPool[graph.facebook.com]+++*/
                    ElevatedButton(
                      onPressed: () =>
                          _signInWithWebUI(provider: AuthProvider.facebook),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(66, 103, 178, 1.0)),
                        elevation: MaterialStateProperty.all(4.0),
                      ),
                      child: Text('Sign in with Facebook'),
                    ),
                    /*+++END authProvidersUserPool[graph.facebook.com]+++*/
                    /*+++START authProvidersUserPool[accounts.google.com]+++*/
                    ElevatedButton(
                      onPressed: () =>
                          _signInWithWebUI(provider: AuthProvider.google),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blueGrey),
                        elevation: MaterialStateProperty.all(4.0),
                      ),
                      child: Text('Sign in with Google'),
                    ),
                    /*+++END authProvidersUserPool[accounts.google.com]+++*/
                    /*+++START authProvidersUserPool[www.amazon.com]+++*/
                    ElevatedButton(
                      onPressed: () =>
                          _signInWithWebUI(provider: AuthProvider.amazon),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(255, 153, 0, 1.0)),
                        elevation: MaterialStateProperty.all(4.0),
                      ),
                      child: Text('Sign in with Amazon'),
                    ),
                    /*+++END authProvidersUserPool[www.amazon.com]+++*/
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
      await Amplify.Auth.signIn(
        /*+++START usernameAttributes[username]+++*/
        username: _usernameController.text.trim(),
        /*+++END usernameAttributes[username]+++*/
        /*+++START usernameAttributes[email]+++
        username: _emailController.text.trim(),
        +++END usernameAttributes[email]+++*/
        /*+++START usernameAttributes[phone_number]+++
        username: _phoneNumberController.text.trim(),
        +++END usernameAttributes[phone_number]+++*/
        password: _passwordController.text.trim(),
      );
      /*+++START mfaConfiguration[OFF]+++*/
      widget.onSignIn(context);
      /*+++END mfaConfiguration[OFF]+++*/
      /*+++START mfaConfiguration[ON]+++*/
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationCodeDialog(onSignIn: widget.onSignIn);
          });
      /*+++END mfaConfiguration[ON]+++*/
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  /*+++START authProvidersUserPool[any]+++*/
  void _signInWithWebUI({AuthProvider? provider}) async {
    try {
      var result =
          await Amplify.Auth.signInWithWebUI(provider: provider);
      if (result.isSignedIn) {
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
