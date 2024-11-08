import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updateuser extends StatefulWidget {
  Updateuser({super.key});

  @override
  State<Updateuser> createState() => _UpdateuserState();
}

class _UpdateuserState extends State<Updateuser> {
  final List<String> bloodgroups = ["A+", 'A-', 'B+', "B-", 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;
  TextEditingController namecntrl = TextEditingController();
  TextEditingController phcntrl = TextEditingController();
  final CollectionReference donner = FirebaseFirestore.instance.collection('donner');

  void updatedoner(String docid) {
    final data = {
      'name': namecntrl.text,
      'phone': phcntrl.text,
      'group': selectedGroup,
    };

    donner.doc(docid).update(data).then((_) {
      print("Document updated with: $data"); // Debugging line
      Navigator.pop(context); // Navigate back after update
    }).catchError((error) {
      print("Failed to update document: $error");
      // Handle the error appropriately here
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    namecntrl.text = args['name'];
    phcntrl.text = args['phone'];
    selectedGroup = args['group'];
    final String docid = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: namecntrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Doner Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phcntrl,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                value: selectedGroup,
                decoration: const InputDecoration(
                  labelText: 'Select Blood Group',
                ),
                items: bloodgroups.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedGroup = val;
                    print("Selected Blood Group: $selectedGroup"); // Debugging line
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedGroup != null) {
                  print("Updating document with ID: $docid"); // Debugging line
                  updatedoner(docid);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a blood group')),
                  );
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text("Update", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
