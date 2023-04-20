import 'package:flutter/material.dart';

class CreateLogin extends StatefulWidget {
  const CreateLogin({super.key});

  @override
  State<CreateLogin> createState() => _CreateLoginState();
}

class _CreateLoginState extends State<CreateLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordIsValid = false;
  bool _passwordFieldTapped = false;

  bool _obscureText = true;
  bool _hasMinLength = false;
  bool _hasLowerCase = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  TextStyle textStyle = const TextStyle(color: Colors.white);

  void _checkPasswordValidity() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasLowerCase = password.contains(RegExp(r'[a-z]'));
      _hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _passwordIsValid = _hasMinLength &&
          _hasLowerCase &&
          _hasUpperCase &&
          _hasNumber &&
          _hasSpecialChar;
    });
  }

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 33, 45),
      appBar: AppBar(
        title: const Text('Login Screen'),
        backgroundColor: const Color.fromARGB(255, 9, 33, 45),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 89, 109, 119),
                    border: OutlineInputBorder(),
                    hintText: 'eample@mail.com'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              //SizedBox(height: 16.0),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Password",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: _obscureText,
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 89, 109, 119),
                  hintText: 'Choose a secure password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
                onTap: () {
                  setState(() {
                    _passwordFieldTapped = true;
                  });
                },
                onChanged: (_) => _checkPasswordValidity(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (!_passwordIsValid) {
                    return 'Please enter a valid Password';
                  }
                  return null;
                },
              ),
              // const SizedBox(height: 16.0),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Password",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 89, 109, 119),
                  hintText: 'Choose a secure password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  // if (value != _passwordController.text) {
                  //   return 'Passwords do not match';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(100, 50)),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 249, 213, 103))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {
                      _passwordFieldTapped = false;
                    });
                    if (_confirmPasswordController.text !=
                        _passwordController.text) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            alignment: AlignmentDirectional.topCenter,
                            title: const Text("This page says"),
                            content: SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                child: const Text(
                                    "Re-enter password do not match")),
                            actions: [
                              ElevatedButton(
                                style: const ButtonStyle(
                                    minimumSize: MaterialStatePropertyAll(
                                        Size(100, 50))),
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );

                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Login successful'),
                      ),
                    );
                    clearText();
                  }
                },
                child: const Text('Create Account'),
              ),
              const SizedBox(height: 8.0),
              _passwordFieldTapped
                  ? Text(
                      " Your password must contain:",
                      style: textStyle,
                    )
                  : const SizedBox(),
              const SizedBox(height: 8.0),
              validationText(
                  isValidate: _hasMinLength, text: "At least 8 characters"),
              validationText(
                  isValidate: _hasLowerCase, text: "A lower case letter"),
              validationText(
                  isValidate: _hasUpperCase, text: "An upper case letter"),
              validationText(isValidate: _hasMinLength, text: "A number"),
              validationText(
                  isValidate: _hasSpecialChar, text: "A special character"),
            ],
          ),
        ),
      ),
    );
  }

  Widget validationText({required String text, required bool isValidate}) {
    return _passwordFieldTapped
        ? Expanded(
            child: ListTile(
              horizontalTitleGap: 0,
              leading: isValidate
                  ? const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : const SizedBox(),
              title: Text(text, style: textStyle),
            ),
          )
        : const SizedBox();
  }
}
