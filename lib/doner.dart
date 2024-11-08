import 'package:donnerfirebase/update.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doner extends StatelessWidget {
  Doner({super.key});
  final CollectionReference donner = FirebaseFirestore.instance.collection('donner');
  void  deletedonner(docid){
    donner.doc(docid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      body: StreamBuilder(
        stream: donner.orderBy('name').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs; // Accessing the documents list
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot donnersnap = docs[index];
                final data = donnersnap.data() as Map<String, dynamic>?; // Safely cast to map

                if (data == null) {
                  return Container(); // Return an empty container if data is null
                }

                // Safely get the fields and convert to string
                final String group = data.containsKey('group') ? data['group'].toString() : 'Unknown';
                final String name = data.containsKey('name') ? data['name'].toString() : 'Unknown';
                final String phone = data.containsKey('phone') ? data['phone'].toString() : 'Unknown';

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 28,
                            child: Text(group),
                          ),
                          SizedBox(width: 10), // Add some spacing
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(name, style: TextStyle(fontSize: 18)),
                              Text(phone, style: TextStyle(fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.pushNamed(context, '/update',
                                    arguments:{
                                      'name':donnersnap['name'],
                                      'phone':donnersnap['phone'].toString(),
                                      'group':donnersnap['group'].toString(),
                                      'id':donnersnap.id



                                    }
                                  );
                                }, icon: Icon(Icons.edit),iconSize: 28,),
                                IconButton(onPressed: (){
                                  deletedonner(donnersnap.id);
                                }, icon: Icon(Icons.delete),iconSize: 28,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
