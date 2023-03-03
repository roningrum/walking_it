import 'package:flutter/material.dart';

class RegisterViewPage extends StatefulWidget {
  const RegisterViewPage({Key? key}) : super(key: key);

  @override
  State<RegisterViewPage> createState() => _RegisterViewPageState();
}

class _RegisterViewPageState extends State<RegisterViewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white60 ,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             const Text('Daftar', style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w500, fontSize: 18)),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'name'
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email'
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password'
                ),
              ),
             TextButton(onPressed: (){},
                 style: ButtonStyle(
                   foregroundColor: MaterialStateProperty.all(Colors.blueAccent)
                 ),
                 child: const Text('Daftar'))
            ],
          ),
        ),
      ),
    );
  }
}
