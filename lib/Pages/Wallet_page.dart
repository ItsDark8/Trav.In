import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class wallet_page extends StatefulWidget {
  const wallet_page({super.key});

  @override
  State<wallet_page> createState() => _wallet_pageState();
}
List<String> options = ['Upi','net banking'];
class _wallet_pageState extends State<wallet_page> {
String currentOption = options[0];
Map<String, dynamic>? userData;
double totalTicketPrice = 0.0;
double currentWalletAmount = 0.0;

@override
void initState() {
  super.initState();
  fetchAndUpdateWallet();
}

Future<void> fetchAndUpdateWallet() async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String uid = currentUser.uid;

      // Fetch user data to get wallet amount and u_id
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        userData = userDoc.data();
        String? userId = userData?['u_id'];

        if (userId != null) {
          // Fetch ticket details and calculate total ticket price
          QuerySnapshot<Map<String, dynamic>> ticketDocs = await FirebaseFirestore.instance
              .collection('Ticket_details')
              .where('u_id', isEqualTo: userId)
              .get();

          totalTicketPrice = ticketDocs.docs.fold(0.0, (sum, ticket) {
            return sum + (double.tryParse(ticket['price'].toString()) ?? 0.0);
          });

          // Update wallet amount
          currentWalletAmount = double.parse(userData?['wallet'].toString() ?? '0');
          double newWalletAmount = currentWalletAmount - totalTicketPrice;

          await FirebaseFirestore.instance.collection('Users').doc(uid).update({'wallet': newWalletAmount,
          });

          setState(() {
            userData?['wallet'] = newWalletAmount; // Update local state
          });

          print('Wallet amount updated successfully');
        } else {
          print('No user ID found for this user.');
        }
      } else {
        print('No user data found for this UID.');
      }
    } else {
      print('No user is currently logged in.');
    }
  } catch (e) {
    print('Error fetching or updating data: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    String walletAmount = userData!['wallet'].toString();
    return userData == null
        ? Center(child: CircularProgressIndicator()):
    Scaffold(
      appBar: AppBar(title: Text('Wallet',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(icon: ImageIcon(AssetImage('Assets/Icons/menu.png'),
          color: Colors.blue,),
          onPressed: (){},),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(child: Image.asset('Assets/Icons/profile-icon/wallet.png'),
            height: 100,
            width: 100,),
            Text('Wallet',style: TextStyle(fontSize: 35,color: Colors.blue),),
            
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('RS.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,),),
                  Text(walletAmount,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(child: Column(
                children: [Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      child: Text('Withdraw',style: TextStyle(fontSize: 16,color: Colors.white,)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueAccent
                      ),
                    ),
                    onTap: (){
                      //showModalBottomSheet(context: context, builder: (BuildContext context){});
                    },
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        child: Text('Deposit',style: TextStyle(fontSize: 16,color: Colors.white,)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueAccent
                        ),
                      ),
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (BuildContext context){
                          return SizedBox(
                            height: 180,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                        Row(
                                          children: [
                                            Radio(
                                                value: options[0], groupValue: currentOption,
                                                onChanged:(choise){
                                                  setState(() {
                                                    currentOption = choise.toString();
                                                  });
                                                }),
                                            Text('UPI'),
                                          ],
                                        ),
                                      Padding(
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
                                            //walletAmount = walletAmount + 1000;
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>wallet_page()));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),),
            )
          ],
        ),
      ),
    );
  }
}
