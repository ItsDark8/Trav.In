import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trav_in/Pages/Login_page.dart';
import 'package:trav_in/Widgets/BottomNavigation.dart';
import 'package:trav_in/main_page.dart';

import '../FireBase_database/auth_service.dart';

class registration_page extends StatefulWidget {
  const registration_page({super.key});

  @override
  State<registration_page> createState() => _registration_pageState();
}

final TextEditingController _email = TextEditingController();
final TextEditingController _pwd = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _lastname = TextEditingController();
final TextEditingController _firstname = TextEditingController();

class _registration_pageState extends State<registration_page> {

  void signUp(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signUpWithEmailPassword(_email.text, _pwd.text,_phone.text,_firstname.text,_lastname.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => bottomnavigation()),
      );
    }

    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('Assets/pic/mainPic.jpg'),
        fit: BoxFit.fill
    ),
        ),
    child:Scaffold(
        appBar: AppBar(title: Text('Trav.In'),
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>main_page()));
          },),
          backgroundColor: Colors.transparent,
          centerTitle: true,),
          backgroundColor: Colors.transparent,

      body: ListView(
            children: [
              Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(200),
                  borderRadius: BorderRadius.all(Radius.circular(21))
                ),
                child: Column(
                  children: [
                    Container(height: 150,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 35,
                      child: Icon(Icons.person,size: 50,color: Colors.white,),
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          controller: _firstname,
                          decoration: InputDecoration(
                              label: Text('First name',),
                              fillColor: Colors.blueAccent.withAlpha(50),
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          controller: _lastname,
                          decoration: InputDecoration(
                              label: Text('Last name'),
                              fillColor: Colors.blueAccent.withAlpha(50),
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                              label: Text('Email Address'),
                              fillColor: Colors.blueAccent.withAlpha(50),
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          controller: _pwd,
                          obscureText: _showPassword,
                          decoration: InputDecoration(
                              label: Text('Password',),
                              fillColor: Colors.blueAccent.withAlpha(50),
                              filled: true,
                              suffixIcon: IconButton(onPressed: (){_showPassword=!_showPassword;}, icon: Icon(Icons.visibility_off_outlined)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextField(
                          controller: _phone,
                          decoration: InputDecoration(
                              label: Text('Phone',),
                              fillColor: Colors.blueAccent.withAlpha(50),
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Container(
                        child: Center(child: Text('Register',style: TextStyle(fontSize: 15),)),
                        height: 62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueAccent
                        ),
                      ),
                      onTap: (){
                        signUp(context);
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>bottomnavigation()));
                      },),
                    ),
                  ],
                ),
              ),
                            ),]
          ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 10,left: 10),
        decoration: BoxDecoration(
        color: Colors.white.withAlpha(240),
        borderRadius: BorderRadius.only(topRight: Radius.circular(21),topLeft: Radius.circular(21))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('I already have account? ',),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>login_page()));},
              child: Text("Login now",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    )
    );
  }
}
