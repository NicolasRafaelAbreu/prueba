import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginScreenForm(),
    );
  }
}

class _LoginScreenForm extends StatelessWidget {
  const _LoginScreenForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 127),
            SvgPicture.asset(
              'assets/logo_Horizontal.svg',
              width: 191,
              height: 54,
            ),
            const SizedBox(
              height: 86,
            ),
            const SizedBox(
                width: 400,
                child: Text(
                  'EMAIL',
                  style: TextStyle(
                      color: Color(0xFF006EAA),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'email@mail.com',
                  labelStyle: TextStyle(color: Color(0xFFB0BEC5)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF9A14C), width: 2),
                  )),
            ),
            const SizedBox(height: 20),
            const SizedBox(
                width: 400,
                child: Text(
                  'PASSWORD',
                  style: TextStyle(
                      color: Color(0xFF006EAA),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )),
            TextFormField(
              textAlign: TextAlign.start,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: '********',
                  labelStyle: TextStyle(color: Color(0xFFB0BEC5)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF9A14C), width: 2),
                  )),
            ),
            const SizedBox(height: 11),
            SizedBox(
              width: 400,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot your password?',
                  textAlign: TextAlign.end,
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF006EAA)),
                    alignment: Alignment.bottomRight),
              ),
            ),
            const SizedBox(height: 36),
            MaterialButton(
              elevation: 4,
              onPressed: () {},
              minWidth: 348,
              height: 54,
              color: const Color(0xFF1DA2FC),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 115,
                  height: 16,
                  child: Text(
                    'or continue with',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
            const SizedBox(height: 38),
            MaterialButton(
              elevation: 4,
              onPressed: () {},
              minWidth: 52,
              height: 52,
              child: SvgPicture.asset('assets/loginGoogle.svg'),
            ),
            const SizedBox(height: 38),
            const SizedBox(
              height: 16,
              child: Text(
                'Don´t have an account?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF979797)),
              ),
            ),
            const SizedBox(height: 17),
            MaterialButton(
              onPressed: () {},
              minWidth: 348,
              height: 54,
              shape: const BeveledRectangleBorder(
                  side: BorderSide(
                color: Color(0xFF1DA2FC),
              )),
              color: Colors.white,
              child: const Text('Register',
                  style: TextStyle(color: Color(0xFF1DA2FC), fontSize: 18)),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
