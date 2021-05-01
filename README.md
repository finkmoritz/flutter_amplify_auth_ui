# Flutter Amplify Auth UI

Flutter plugin that automatically generates authentication widgets based on your Amplify CLI configuration.

<img src="https://github.com/finkmoritz/flutter_amplify_auth_ui/raw/master/example/screenshots/preview.png" alt="Preview" height="150px"/>

## Installation

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

### Usage

Execute the following command in your project's root folder:

```
flutter packages pub run flutter_amplify_auth_ui:main
```

Options:
- **--amplifyDir=path/to/amplify/folder** : 
  
  Path to Amplify configuration (usually the `amplify` folder) in your project root (defaults to `./amplify/`).
- **--targetDir=path/to/target/folder** :

  Generated Flutter widgets will be generated within the specified folder (defaults to `./lib/generated_auth_classes/`).


Full example with options:

```
flutter packages pub run flutter_amplify_auth_ui:main --amplifyDir=./amplify/ --targetDir=./lib/generated_auth_classes/
```
