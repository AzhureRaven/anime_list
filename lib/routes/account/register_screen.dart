import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../utlis/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey <FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Anime List', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 24),
                const Text('Create your account', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  validator: (data) {
                    if (data != null && data != "") {
                      return null;
                    } else {
                      return "Field is required";
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  validator: (data) {
                    if (data != null && data != "") {
                      return null;
                    } else {
                      return "Field is required";
                    }
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.loaderOverlay.show();
                      try{
                        final navigator = Navigator.of(context);
                        final snackbar = ScaffoldMessenger.of(context);
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        navigator.pop();
                        snackbar.showSnackBar(basicSnackBar("Register Succesful!"));
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(basicSnackBar(e.toString()));
                      }finally{
                        context.loaderOverlay.hide();
                      }
                    }
                  },
                  child: const Text('Register', style: TextStyle(fontSize: 18)),
                ),
                TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Already have an account? Login Here!"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }
}
