import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /*+++START usernameAttributes[username]+++*/
  final TextEditingController _usernameController = TextEditingController();
  /*+++END usernameAttributes[username]+++*/
  /*+++START requiredAttributes[email]+++*/
  final TextEditingController _emailController = TextEditingController();
  /*+++END requiredAttributes[email]+++*/
  /*+++START requiredAttributes[phone_number]+++*/
  final TextEditingController _phoneNumberController = TextEditingController();
  /*+++END requiredAttributes[phone_number]+++*/
  /*+++START requiredAttributes[nickname]+++*/
  final TextEditingController _nicknameController = TextEditingController();
  /*+++END requiredAttributes[nickname]+++*/
  /*+++START requiredAttributes[preferred_username]+++*/
  final TextEditingController _preferredUsernameController = TextEditingController();
  /*+++END requiredAttributes[preferred_username]+++*/
  /*+++START requiredAttributes[name]+++*/
  final TextEditingController _nameController = TextEditingController();
  /*+++END requiredAttributes[name]+++*/
  /*+++START requiredAttributes[given_name]+++*/
  final TextEditingController _givenNameController = TextEditingController();
  /*+++END requiredAttributes[given_name]+++*/
  /*+++START requiredAttributes[middle_name]+++*/
  final TextEditingController _middleNameController = TextEditingController();
  /*+++END requiredAttributes[middle_name]+++*/
  /*+++START requiredAttributes[family_name]+++*/
  final TextEditingController _familyNameController = TextEditingController();
  /*+++END requiredAttributes[family_name]+++*/
  /*+++START requiredAttributes[birthdate]+++*/
  final TextEditingController _birthdateController = TextEditingController();
  /*+++END requiredAttributes[birthdate]+++*/
  /*+++START requiredAttributes[picture]+++*/
  final TextEditingController _pictureController = TextEditingController();
  /*+++END requiredAttributes[picture]+++*/
  /*+++START requiredAttributes[profile]+++*/
  final TextEditingController _profileController = TextEditingController();
  /*+++END requiredAttributes[profile]+++*/
  /*+++START requiredAttributes[website]+++*/
  final TextEditingController _websiteController = TextEditingController();
  /*+++END requiredAttributes[website]+++*/
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();

  /*+++START requiredAttributes[gender]+++*/
  String _gender = 'other';
  /*+++END requiredAttributes[gender]+++*/

  int _stepIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    /*+++START usernameAttributes[username]+++*/
    _usernameController.dispose();
    /*+++END usernameAttributes[username]+++*/
    /*+++START requiredAttributes[email]+++*/
    _emailController.dispose();
    /*+++END requiredAttributes[email]+++*/
    /*+++START requiredAttributes[phone_number]+++*/
    _phoneNumberController.dispose();
    /*+++END requiredAttributes[phone_number]+++*/
    /*+++START requiredAttributes[nickname]+++*/
    _nicknameController.dispose();
    /*+++END requiredAttributes[nickname]+++*/
    /*+++START requiredAttributes[preferred_username]+++*/
    _preferredUsernameController.dispose();
    /*+++END requiredAttributes[preferred_username]+++*/
    /*+++START requiredAttributes[name]+++*/
    _nameController.dispose();
    /*+++END requiredAttributes[name]+++*/
    /*+++START requiredAttributes[given_name]+++*/
    _givenNameController.dispose();
    /*+++END requiredAttributes[given_name]+++*/
    /*+++START requiredAttributes[middle_name]+++*/
    _middleNameController.dispose();
    /*+++END requiredAttributes[middle_name]+++*/
    /*+++START requiredAttributes[family_name]+++*/
    _familyNameController.dispose();
    /*+++END requiredAttributes[family_name]+++*/
    /*+++START requiredAttributes[birthdate]+++*/
    _birthdateController.dispose();
    /*+++END requiredAttributes[birthdate]+++*/
    /*+++START requiredAttributes[picture]+++*/
    _pictureController.dispose();
    /*+++END requiredAttributes[picture]+++*/
    /*+++START requiredAttributes[profile]+++*/
    _profileController.dispose();
    /*+++END requiredAttributes[profile]+++*/
    /*+++START requiredAttributes[website]+++*/
    _websiteController.dispose();
    /*+++END requiredAttributes[website]+++*/
    _passwordController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 700),
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
                title: Text('Sign Up'),
                content: _buildSignUpForm(),
                isActive: _stepIndex == 0,
                state: _stepIndex > 0 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: Text('Confirm'),
                content: _buildConfirmationForm(),
                isActive: _stepIndex == 1,
                state: _stepIndex > 1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: Text('Done'),
                content: Text('You successfully signed up.'),
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
                        onPressed: _signUp,
                        child: const Text('Sign Up'),
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
                      TextButton(
                        onPressed: _resend,
                        child: const Text('Resend Code'),
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

  Widget _buildSignUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*+++START requiredAttributes[email]+++*/
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              icon: Icon(Icons.mail),
              hintText: 'Enter your email address',
              labelText: 'Email address',
          ),
        ),
        /*+++END requiredAttributes[email]+++*/
        /*+++START requiredAttributes[phone_number]+++*/
        TextFormField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            icon: Icon(Icons.phone),
            hintText: 'Enter your phone number',
            labelText: 'Phone number',
          ),
        ),
        /*+++END requiredAttributes[phone_number]+++*/
        /*+++START usernameAttributes[username]+++*/
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Choose your username',
              labelText: 'Username',
          ),
        ),
        /*+++END usernameAttributes[username]+++*/
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Choose your password',
              labelText: 'Password',
          ),
        ),
        /*+++START requiredAttributes[nickname]+++*/
        TextFormField(
          controller: _nicknameController,
          decoration: InputDecoration(
              icon: Icon(Icons.person_outline),
              hintText: 'Enter your nickname',
              labelText: 'Nickname',
          ),
        ),
        /*+++END requiredAttributes[nickname]+++*/
        /*+++START requiredAttributes[preferred_username]+++*/
        TextFormField(
          controller: _preferredUsernameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person_outline),
            hintText: 'Enter your preferred username',
            labelText: 'Preferred username',
          ),
        ),
        /*+++END requiredAttributes[preferred_username]+++*/
        /*+++START requiredAttributes[name]+++*/
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person_outline),
            hintText: 'Enter your full name',
            labelText: 'Full name',
          ),
        ),
        /*+++END requiredAttributes[name]+++*/
        /*+++START requiredAttributes[given_name]+++*/
        TextFormField(
          controller: _givenNameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person_outline),
            hintText: 'Enter your given name',
            labelText: 'Given name',
          ),
        ),
        /*+++END requiredAttributes[given_name]+++*/
        /*+++START requiredAttributes[middle_name]+++*/
        TextFormField(
          controller: _middleNameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person_outline),
            hintText: 'Enter your middle name',
            labelText: 'Middle name',
          ),
        ),
        /*+++END requiredAttributes[middle_name]+++*/
        /*+++START requiredAttributes[family_name]+++*/
        TextFormField(
          controller: _familyNameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person_outline),
            hintText: 'Enter your family name',
            labelText: 'Family name',
          ),
        ),
        /*+++END requiredAttributes[family_name]+++*/
        /*+++START requiredAttributes[gender]+++*/
        DropdownButtonFormField(
          value: _gender,
          decoration: InputDecoration(
            icon: Icon(Icons.attribution_outlined),
            labelText: 'Gender',
          ),
          items: ['male', 'female', 'other'].map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _gender = value ?? '';
            });
          },
        ),
        /*+++END requiredAttributes[gender]+++*/
        /*+++START requiredAttributes[birthdate]+++*/
        TextFormField(
          controller: _birthdateController,
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Enter your date of birth',
            labelText: 'Date of Birth',
          ),
          onTap: () {
            // Do not display keyboard
            FocusScope.of(context).requestFocus(FocusNode());
            showDatePicker(
              context: context,
              fieldHintText: 'Enter your date of birth',
              fieldLabelText: 'Date of Birth',
              initialDate: DateTime.now(),
              currentDate: _birthdateController.text.isEmpty
                ? null
                : DateTime.parse(_birthdateController.text),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ).then((date) {
              if(date != null) {
                _birthdateController.text = date.toIso8601String().substring(0, 10);
              }
            });
          },
        ),
        /*+++END requiredAttributes[birthdate]+++*/
        /*+++START requiredAttributes[picture]+++*/
        TextFormField(
          controller: _pictureController,
          decoration: InputDecoration(
            icon: Icon(Icons.photo_camera_outlined),
            hintText: 'Enter your picture URL',
            labelText: 'Picture URL',
          ),
        ),
        /*+++END requiredAttributes[picture]+++*/
        /*+++START requiredAttributes[profile]+++*/
        TextFormField(
          controller: _profileController,
          decoration: InputDecoration(
            icon: Icon(Icons.web),
            hintText: 'Enter your profile URL',
            labelText: 'Profile URL',
          ),
        ),
        /*+++END requiredAttributes[profile]+++*/
        /*+++START requiredAttributes[website]+++*/
        TextFormField(
          controller: _websiteController,
          decoration: InputDecoration(
            icon: Icon(Icons.public),
            hintText: 'Enter your website URL',
            labelText: 'Website URL',
          ),
        ),
        /*+++END requiredAttributes[website]+++*/
      ],
    );
  }

  Widget _buildConfirmationForm() {
    return Column(
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
            labelText: 'Email address',
          ),
        ),
        /*+++END usernameAttributes[email]+++*/
        /*+++START usernameAttributes[phone_number]+++*/
        TextFormField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            icon: Icon(Icons.phone),
            hintText: 'Enter your phone number',
            labelText: 'Phone number',
          ),
        ),
        /*+++END usernameAttributes[phone_number]+++*/
        TextFormField(
          controller: _confirmationCodeController,
          decoration: InputDecoration(
              icon: Icon(Icons.check),
              hintText: 'Enter your confirmation code',
              labelText: 'Confirmation code'
          ),
        ),
      ],
    );
  }

  void _signUp() async {
    try {
      await Amplify.Auth.signUp(
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
        options: CognitoSignUpOptions(
            userAttributes: {
              /*+++START requiredAttributes[email]+++*/
              'email': _emailController.text.trim(),
              /*+++END requiredAttributes[email]+++*/
              /*+++START requiredAttributes[phone_number]+++*/
              'phone_number': _phoneNumberController.text.trim(),
              /*+++END requiredAttributes[phone_number]+++*/
              /*+++START requiredAttributes[nickname]+++*/
              'nickname': _nicknameController.text.trim(),
              /*+++END requiredAttributes[nickname]+++*/
              /*+++START requiredAttributes[preferred_username]+++*/
              'preferred_username': _preferredUsernameController.text.trim(),
              /*+++END requiredAttributes[preferred_username]+++*/
              /*+++START requiredAttributes[name]+++*/
              'name': _nameController.text.trim(),
              /*+++END requiredAttributes[name]+++*/
              /*+++START requiredAttributes[given_name]+++*/
              'given_name': _givenNameController.text.trim(),
              /*+++END requiredAttributes[given_name]+++*/
              /*+++START requiredAttributes[middle_name]+++*/
              'middle_name': _middleNameController.text.trim(),
              /*+++END requiredAttributes[middle_name]+++*/
              /*+++START requiredAttributes[family_name]+++*/
              'family_name': _familyNameController.text.trim(),
              /*+++END requiredAttributes[family_name]+++*/
              /*+++START requiredAttributes[gender]+++*/
              'gender': _gender,
              /*+++END requiredAttributes[gender]+++*/
              /*+++START requiredAttributes[birthdate]+++*/
              'birthdate': DateTime.parse(_birthdateController.text),
              /*+++END requiredAttributes[birthdate]+++*/
              /*+++START requiredAttributes[picture]+++*/
              'picture': _pictureController.text.trim(),
              /*+++END requiredAttributes[picture]+++*/
              /*+++START requiredAttributes[profile]+++*/
              'profile': _profileController.text.trim(),
              /*+++END requiredAttributes[profile]+++*/
              /*+++START requiredAttributes[website]+++*/
              'website': _websiteController.text.trim(),
              /*+++END requiredAttributes[website]+++*/
              /*+++START requiredAttributes[updated_at]+++*/
              'updated_at': DateTime.now().millisecondsSinceEpoch * 1000,
              /*+++END requiredAttributes[updated_at]+++*/
            },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully signed up'),
      ));
      setState(() {
        _stepIndex = 1;
      });
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _resend() async {
    try {
      await Amplify.Auth.resendSignUpCode(
        /*+++START usernameAttributes[username]+++*/
        username: _usernameController.text.trim(),
        /*+++END usernameAttributes[username]+++*/
        /*+++START usernameAttributes[email]+++
        username: _emailController.text.trim(),
        +++END usernameAttributes[email]+++*/
        /*+++START usernameAttributes[phone_number]+++
        username: _phoneNumberController.text.trim(),
        +++END usernameAttributes[phone_number]+++*/
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sent confirmation code'),
      ));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _confirm() async {
    try {
      SignUpResult result = await Amplify.Auth.confirmSignUp(
        /*+++START usernameAttributes[username]+++*/
        username: _usernameController.text.trim(),
        /*+++END usernameAttributes[username]+++*/
        /*+++START usernameAttributes[email]+++
        username: _emailController.text.trim(),
        +++END usernameAttributes[email]+++*/
        /*+++START usernameAttributes[phone_number]+++
        username: _phoneNumberController.text.trim(),
        +++END usernameAttributes[phone_number]+++*/
        confirmationCode: _confirmationCodeController.text.trim(),
      );
      if (result.isSignUpComplete) {
        setState(() {
          _stepIndex = 2;
        });
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
