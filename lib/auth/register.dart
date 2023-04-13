import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth/auth_service.dart';
import 'package:frontend/services/utility/dialog.dart';
import 'package:regexpattern/regexpattern.dart';

// class Register extends StatelessWidget {
//   const Register({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Register'),
//         ),
//         body: const MyRegisterState());
//   }
// }

// class MyRegisterState extends StatefulWidget {
//   const MyRegisterState({Key? key}) : super(key: key);
//   @override
//   State<MyRegisterState> createState() => _MyRegisterState();
// }

// class _MyRegisterState extends State<MyRegisterState> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? username;
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
//               hintText: 'Enter username',
//             ),
//             validator: (String? value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               setState(() {
//                 username = value;
//               });
//             },
//           ),
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
//             child: const Text('Create Account'),
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 bool state = await AuthService.register(User(
//                     username: username!, email: email!, password: password!));
//                 if (state) {
//                   await MyDialog.fullDialog(context, "ACCOUNT CREATED");
//                   Navigator.pushNamed(context, "/login");
//                   return;
//                 }
//                 MyDialog.fullDialog(context, "ACCOUNT ALEARDY EXIST");
//               }
//             },
//           ),
//           ElevatedButton(
//             child: const Text('login'),
//             onPressed: () async {
//               Navigator.pushNamed(context, '/login');
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
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
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "User Name",
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                setState(() {
                                  username = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
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
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
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
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
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
                                          bool state =
                                              await AuthService.register(User(
                                                  username: username!,
                                                  email: email!,
                                                  password: password!));
                                          if (state) {
                                            await MyDialog.fullDialog(
                                                context, "ACCOUNT CREATED");
                                            Navigator.pushNamed(
                                                context, "/login");
                                            return;
                                          }
                                          MyDialog.fullDialog(
                                              context, "ACCOUNT ALEARDY EXIST");
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
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: const Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
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
