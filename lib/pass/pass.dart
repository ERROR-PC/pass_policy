// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pass_policy/pass/pass_field.dart';
import 'package:pass_policy/pass/validation_text.dart';

class PassPage extends StatefulWidget {
  const PassPage({super.key});

  @override
  PassPageState createState() => PassPageState();
}

class PassPageState extends State<PassPage> {
  final _formKey = GlobalKey<FormState>();

  String oldPass = '';
  String newPass = '';
  String confirmPass = '';

  bool includeLower = false;
  bool includeUpper = false;
  bool notEmpty = false;
  bool includeSpecialChar = false;
  bool includeNumber = false;
  bool atLeast8 = false;

  static const Widget _normalSpace = SizedBox(height: 20);
  static const Widget _smallSpace = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _normalSpace,
                const PassFormField(label: 'Old password'),
                _normalSpace,
                PassFormField(
                  label: 'New password',
                  validator: (pass) {
                    if (!atLeast8 ||
                        !includeLower ||
                        !includeUpper ||
                        !includeNumber ||
                        !includeSpecialChar ||
                        !notEmpty) {
                      return 'Not all password rules were fullfilled';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (pass) {
                    newPass = pass;
                    setState(() {
                      atLeast8 = newPass.length >= 8;
                      notEmpty = newPass.isNotEmpty;
                      includeLower = newPass.contains(RegExp(r'[a-z]'));
                      includeUpper = newPass.contains(RegExp(r'[A-Z]'));
                      includeSpecialChar =
                          newPass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                      includeNumber = newPass.contains(RegExp(r'[0-9]'));
                    });
                  },
                ),
                _normalSpace,
                const Text('Password Must:'),
                _smallSpace,
                ValidationText(
                  text: 'Include lowercase characters',
                  isValid: includeLower,
                ),
                _smallSpace,
                ValidationText(
                  text: 'Include uppercase characters',
                  isValid: includeUpper,
                ),
                _smallSpace,
                ValidationText(
                  text: 'Include at least one special character',
                  isValid: includeSpecialChar,
                ),
                _smallSpace,
                ValidationText(
                  text: 'Include numeric character',
                  isValid: includeNumber,
                ),
                _smallSpace,
                ValidationText(
                  text: 'Include at least 8 characters',
                  isValid: atLeast8,
                ),
                _normalSpace,
                PassFormField(
                  label: 'Confirmation',
                  onChanged: (pass) => confirmPass = pass,
                  validator: (pass) {
                    confirmPass = pass ?? '';
                    return newPass == confirmPass ? null : 'Mismatch Password';
                  },
                ),
                _normalSpace,
                const SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 100, 120),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text(
                                'Password was successfully changed',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
