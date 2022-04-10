import 'package:flutter/material.dart';

void main() {
  runApp(const Phonebookapp());
}

class Contact {
  String name;
  String phone;
  Contact({required this.name, required this.phone});
}

class Phonebookapp extends StatefulWidget {
  const Phonebookapp({Key? key}) : super(key: key);

  @override
  _PhonebookappState createState() => _PhonebookappState();
}

class _PhonebookappState extends State<Phonebookapp> {
  var contacts = <Contact>[];
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  onAddContact() {
    if (formKey.currentState!.validate()) {
      setState(() {
        contacts.add(
            Contact(name: nameController.text, phone: phoneController.text));
      });

      nameController.clear();
      phoneController.clear();
    }
  }

  showAddContactForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Tambah Data Kontak'),
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        label: Text('Nama'), prefixIcon: Icon(Icons.person)),
                    validator: (String? value) {
                      if (value == '' || value!.isEmpty) {
                        return 'Nama wajib diisi!';
                      }
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        label: Text('Nomer telepon'),
                        prefixIcon: Icon(Icons.phone)),
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value == '' || value!.isEmpty) {
                        return 'Nomer telepon wajib diisi!';
                      }
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Simpan'),
                      onPressed: () {
                        onAddContact();
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  )
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Phonebook App'),
            actions: [
              Builder(
                  builder: (context) => IconButton(
                        onPressed: () {
                          showAddContactForm(context);
                        },
                        icon: const Icon(Icons.add),
                      ))
            ],
          ),
          body: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(contacts[i].name),
                  subtitle: Text(contacts[i].phone),
                );
              })),
    );
  }
}
