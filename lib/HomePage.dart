import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:hive_data_base/models.dart/notes_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'boxese.dart/box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 115, 176, 226),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 82, 107),
        centerTitle: true,
        title: Text("Note Pad"),
      ),
      body: ValueListenableBuilder<Box<NotesModles>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, child) {
          var data = box.values.toList().cast<NotesModles>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color.fromARGB(255, 182, 209, 223),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            data[index].title.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                delete(data[index]);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                editDialog(
                                    context,
                                    data[index],
                                    data[index].title.toString(),
                                    data[index].desription.toString());
                              },
                              child: Icon(Icons.edit)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(data[index].desription.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showMyDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void delete(NotesModles notesModles) async {
  await notesModles.delete();
}

Future<void> editDialog(BuildContext context, NotesModles notesModles,
    String title, String description) async {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  titleController.text = title;
  descriptionController.text = description;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Notes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Enter title', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancle')),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                notesModles.title = titleController.text.toString();

                notesModles.desription = descriptionController.text.toString();
                notesModles.save();
                titleController.clear();
                descriptionController.clear();
              },
              child: const Text('Edit')),
        ],
      );
    },
  );
}

Future<void> showMyDialog(BuildContext context) async {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Notes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Enter title', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancle')),
          TextButton(
              onPressed: () {
                final data = NotesModles(
                    title: titleController.text,
                    desription: descriptionController.text);
                final box = Boxes.getData();
                box.add(data);
                //data.save();
                //print(box);
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: const Text('Add')),
        ],
      );
    },
  );
}
