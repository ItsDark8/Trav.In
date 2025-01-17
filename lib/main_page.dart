import 'package:flutter/material.dart';
import 'package:trav_in/Pages/Login_page.dart';
import 'package:trav_in/Pages/Registation_page.dart';

class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text('Trav.In',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(width: 15,),
                  const Text('Welcome to Trav.In',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      child: Text('Login',style: TextStyle(fontSize: 16,color: Colors.white,)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueAccent
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>login_page()));
                    },
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      child: Text('Register',style: TextStyle(fontSize: 16,color: Colors.white,)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueAccent
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>registration_page()));
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
