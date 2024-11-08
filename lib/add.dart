import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Adduser extends StatefulWidget {
   Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  final  bloodgroups=["A+",'A-','B+',"B-",'O+','O-','AB+','AB-'];
  String? selectedGroup;
  TextEditingController namecntrl=TextEditingController();
  TextEditingController phcntrl=TextEditingController();
  final CollectionReference donner = FirebaseFirestore.instance.collection('donner');
  void addDoner(){
    final data={"name":namecntrl.text,"phone":phcntrl.text,"group":selectedGroup};
    donner.add(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("add donners"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: namecntrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Donner Name"
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: phcntrl,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Select BloodGroup'
                    ),
                    items: bloodgroups.map((e) => DropdownMenuItem(child: Text(e),value: e,),).toList(), onChanged: (val){
                  selectedGroup=val;
                }),
              ),
              ElevatedButton(onPressed: ()  {
                // final FirebaseFirestore db = FirebaseFirestore.instance;
                // final CollectionReference donner = db.collection('donner');
                // final Map<String,dynamic>userFields={
                //   'name':'${namecntrl.text}',
                //   'phone':'${phcntrl.text}'
                // };
                // await donner.add(userFields);
                // Navigator.pushNamed(context, '/');
               addDoner();
               Navigator.pop(context);


              },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text("Submit",style: TextStyle(fontSize: 20),),)
            ],
          ),
        )
    );
  }
}

// Future<void> submitt() async{
// final FirebaseFirestore db = FirebaseFirestore.instance;
// final CollectionReference donner = db.collection('donner');
//   final Map<String,dynamic>userFields={
//     'name':'',
//     'phone':'7895321459'
//   };
//   await donner.doc('9874258614').set(userFields);
// }