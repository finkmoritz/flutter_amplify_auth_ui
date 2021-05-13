# Flutter Amplify Auth UI

Flutter plugin that automatically generates authentication widget templates based on your Amplify CLI Authentication configuration.

<img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignInPage_light.png" alt="Preview" height="500px"/>

## Features

### SignInPage
- Sign in via password and one of the following
    - username
    - email
    - phone number
- Sign in as guest (if configured)
- Sign in with social providers:
    - Facebook
    - Google
    - Amazon

### SignUpPage
- Sign up via password and one of the following (plus confirmation code):
    - username
    - email
    - phone number
- Additional required attributes (if configured):
    - Nickname
    - Date of Birth
    - Phone number

### PasswordResetPage
- Reset password via confirmation code and one of the following
    - username
    - email
    - phone number

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
      home: SignInPage( // <-- Include the generated widget in your widget tree
        onSignIn: (context) {
          //TODO Define what to do after sign in
        },
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

## Showroom

The following images display the outcome of a particular Amplify configuration.

### SignInPage

<p float="left">
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignInPage_light.png" alt="Preview" height="500px"/>
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignInPage_dark.png" alt="Preview" height="500px"/>
</p>

### SignUpPage

<p float="left">
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignUpPage1_light.png" alt="Preview" height="500px"/>
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignUpPage1_dark.png" alt="Preview" height="500px"/>
</p>
<p float="left">
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignUpPage2_light.png" alt="Preview" height="500px"/>
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/SignUpPage2_dark.png" alt="Preview" height="500px"/>
</p>

### PasswordResetPage

<p float="left">
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/PasswordResetPage_light.png" alt="Preview" height="500px"/>
    <img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/main/example/screenshots/PasswordResetPage_dark.png" alt="Preview" height="500px"/>
</p>
