import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth/auth_service.dart';
import 'package:frontend/services/utility/dialog.dart';
import 'package:regexpattern/regexpattern.dart';

// class Login extends StatelessWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Login"),
//         ),
//         body: const MyLoginState());
//   }
// }

// class MyLoginState extends StatefulWidget {
//   const MyLoginState({Key? key}) : super(key: key);
//   @override
//   State<MyLoginState> createState() => _MyLoginState();
// }

// class _MyLoginState extends State<MyLoginState> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   @override
//   Widget build(BuildContext mycontext) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Enter Email',
//             ),
//             validator: (String? value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               if (!value.isEmail()) {
//                 return 'Please enter valid email';
//               }
//               setState(() {
//                 email = value;
//               });
//             },
//           ),
//           TextFormField(
//             decoration: const InputDecoration(hintText: 'Enter Password'),
//             obscureText: true,
//             enableSuggestions: false,
//             autocorrect: false,
//             validator: (String? value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               setState(() {
//                 password = value;
//               });
//             },
//           ),
//           ElevatedButton(
//             child: const Text('Login'),
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 final bool state =
//                     await AuthService.login(User.instance(email!, password!));
//                 if (state) {
//                   Navigator.pushNamed(context, "/home");
//                   return;
//                 }
//                 await MyDialog.fullDialog(context, "BAD INFORMATION");
//               }
//             },
//           ),
//           ElevatedButton(
//             child: const Text('No account'),
//             onPressed: () async {
//               Navigator.pushNamed(context, '/register');
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (!value.isEmail()) {
                                  return 'Please enter valid email';
                                }
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: const TextStyle(),
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final bool state =
                                              await AuthService.login(
                                                  User.instance(
                                                      email!, password!));
                                          if (state) {
                                            Navigator.pushNamed(
                                                context, "/home");
                                            return;
                                          }
                                          await MyDialog.fullDialog(
                                              context, "BAD INFORMATION");
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: const ButtonStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
