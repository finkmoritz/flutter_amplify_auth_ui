# Flutter Amplify Auth UI

Execute the following command in your project's root folder in order to generate authentication widgets
based on your Amplify configuration:

```
flutter packages pub run flutter_amplify_auth_ui:main
```

Easily integrate the generated authentication widgets in your project, e.g.:

``` dart
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'generated_auth_classes/sign_in/sign_in_page.dart'; // <-- Import the generated widget

import 'amplifyconfiguration.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Amplify Auth UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SignInPage( // <-- Include the generated widget in your widget tree
        onSignIn: (context) => Navigator.push(  //TODO Define what to do after sign in
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        ),
      ),
    );
  }

  void _configureAmplify() async {
    if (!mounted) return;

    Amplify.addPlugins([
      AmplifyAuthCognito(),
    ]);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }
}
```
