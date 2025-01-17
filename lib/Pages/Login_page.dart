
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trav_in/Admin%20side/admin_page.dart';
import 'package:trav_in/Pages/Registation_page.dart';
import 'package:trav_in/Widgets/BottomNavigation.dart';
import 'package:trav_in/main.dart';
import 'package:trav_in/main_page.dart';

import '../FireBase_database/auth_service.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}
final TextEditingController _email = TextEditingController();
final TextEditingController _pwd = TextEditingController();

class _login_pageState extends State<login_page> {

    void login(BuildContext context) async {
      final authService = AuthService();

      try {
        await authService.signInWithEmailPassword(_email.text,_pwd.text);
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
    bool _showPassword= true;
    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Assets/pic/mainPic.jpg'),
              fit: BoxFit.fill
          ),
        ),
        child: Scaffold(
          appBar: AppBar(title: Text('Trav.In'),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => main_page()));
              },),
            centerTitle: true,),
          backgroundColor: Colors.transparent,

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.all(Radius.circular(21))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Hi,\n' + 'Login Now', textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: TextField(
                            controller: _email,
                            decoration: InputDecoration(
                                label: Text('Email Address',),
                                fillColor: Colors.blueAccent.withAlpha(50),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)))
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)))
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(child: Container(
                          child: Center(child: Text('Login', style: TextStyle(
                              color: Colors.black, fontSize: 15),)),
                          height: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.blueAccent
                          ),
                        ),
                          onTap: () {
                            if ('admin' == _email.text && '123' == _pwd.text) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => admin_page()));
                            }
                            else {
                              login(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.white.withAlpha(200),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21),
                      topRight: Radius.circular(21))
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Container(
                    child: Center(child: Text(
                      'Sign in with Google', style: TextStyle(fontSize: 15),)),
                    height: 62,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blueAccent
                    ),
                  ),
                    onTap: () {

                    },),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Container(
                    child: Center(child: Text('Sign in with FaceBook',
                      style: TextStyle(fontSize: 15),)),
                    height: 62,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blueAccent
                    ),
                  ),
                    onTap: () {

                    },),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I don't have Account? ",),
                    GestureDetector(child: Text('Create Now!', style: TextStyle(
                        color: Colors.blue),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => registration_page()));
                      },)
                  ],
                ),
              ],),
            ),
          ),
        ),
      );
    }
  }