# Flutter Amplify Auth UI

Flutter plugin that automatically generates authentication widgets based on your Amplify CLI configuration.

<img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/preview.png" alt="Preview" height="500px"/>

## Features

### SignInPage
- Sign in via username and password
- Sign in as guest (if configured)

### SignUpPage
- Sign up via username, password and email address (plus confirmation code)
- Additional required attributes (if configured):
    - Nickname
    - Date of Birth

### PasswordResetPage
- Reset password via username and confirmation code

## Install

To use this plugin, add `flutter_amplify_auth_ui` as a `dev_dependency` in your pubspec.yaml:
```
dev_dependencies:
  flutter_amplify_auth_ui: ^0.1.0
```

Run `flutter pub get` to install the plugin.

If you have not already done so, follow the 
[official Amplify documentation](https://docs.amplify.aws/start/q/integration/flutter)
in order to integrate [Amplify](https://docs.amplify.aws/start/q/integration/flutter)
with [Authentication](https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter)
into your project.

## Generate Authentication Widgets

Execute the following command in your project's root folder in order to generate authentication widgets
based on your Amplify configuration:

```
flutter packages pub run flutter_amplify_auth_ui:main
```

**Options**:
- **--amplifyDir=path/to/amplify/folder** : 
  
  Path to Amplify configuration (usually the `amplify` folder) in your project root (defaults to `./amplify/`).
- **--targetDir=path/to/target/folder** :

  Generated Flutter widgets will be generated within the specified folder (defaults to `./lib/generated_auth_classes/`).


Full example with options:

```
flutter packages pub run flutter_amplify_auth_ui:main --amplifyDir=./amplify/ --targetDir=./lib/generated_auth_classes/
```

## Use Generated Widgets

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('flutter_amplify_auth_ui Demo'),
        ),
        body: SignInPage(), // <-- Include the generated widget in your widget tree
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
