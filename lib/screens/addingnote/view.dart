import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/addingnote/controller.dart';
import 'package:note/screens/addingnote/states.dart';

class AddingNoteScreen extends StatelessWidget {
  final String? title;
  final String? note;
  final String? docsId;
  final bool? isUpdate;
  const AddingNoteScreen(
      {Key? key, this.isUpdate, this.note, this.docsId, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          AddingNoteController()..startValue(isUpdate, title, note),
      child: BlocBuilder<AddingNoteController, AddingNoteState>(
        builder: (context, state) {
          final controller = AddingNoteController.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                isUpdate == true ? "Edit Note" : "Add Note",
                style: TextStyle(
                    fontFamily: 'head', fontSize: size.shortestSide * .075),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: size.shortestSide * .07)),
              actions: [
                IconButton(
                    onPressed: () {
                      if (isUpdate == true) {
                        controller.updateNote(context, docsId);
                      } else {
                        controller.uploadNote(context);
                      }
                    },
                    icon: Icon(Icons.done, size: size.shortestSide * .08))
              ],
            ),
            body: controller.isDone
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.titleController,
                          decoration: InputDecoration(
                              hintText: "Title",
                              hintStyle: TextStyle(
                                  fontSize: size.shortestSide * .07,
                                  color: Colors.grey.shade400),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                          style: TextStyle(fontSize: size.shortestSide * .055),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        TextField(
                          controller: controller.noteDetailsController,
                          maxLines: 23,
                          decoration: InputDecoration(
                            hintText: "Start typing",
                            hintStyle: TextStyle(
                                fontSize: size.shortestSide * .05,
                                color: Colors.grey.shade400),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                          style: TextStyle(fontSize: size.shortestSide * .045),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
