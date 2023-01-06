import 'package:admin_dashboard/provider/auth_admin_provider.dart';
import 'package:admin_dashboard/provider/member_provider.dart';
import 'package:admin_dashboard/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginAdminPage extends StatefulWidget{
  static const routeName = '/LoginAdminPage';
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.yellow
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 70,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/champions.jpg'),
                  radius: 60,
                ),
              ),
              SizedBox(height: 15,),
              const Text(
                'Champions Fitness',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 480,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text('Hello',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Please Login to Your Admin Account',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    EmailTextField(emailController: _emailController),
                    PasswordTextField(passwordController: _passwordController),
                    LoginButton(
                        emailController: _emailController,
                        passwordController: _passwordController
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextField(
        controller: _emailController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Email Address",
          suffixIcon: Icon(Icons.email, size: 17,),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Password",
          suffixIcon: Icon(Icons.password, size: 17,),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget{
  const LoginButton({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) :  _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () async{
              final loginResult = await Provider.of<AuthAdminProvider>(context, listen: false)
                  .loginAdmin(_emailController.text, _passwordController.text);
              if(loginResult != null){
                Provider.of<MemberProvider>(context, listen: false)
                    .fetchMemberList();
                Navigator.pushReplacementNamed(context, ResponsiveLayout.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Email atau password salah",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Login',
              ),
            ),
          ),
        ),
      ),
    );
  }
}