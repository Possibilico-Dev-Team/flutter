import 'package:flutter/material.dart';

class ProgramPicker extends StatefulWidget {
  final List? data;
  const ProgramPicker(this.data, {super.key});

  @override
  State<ProgramPicker> createState() => _ProgramPickerState();
}

class _ProgramPickerState extends State<ProgramPicker> {
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );
  Widget customSearchBar = const Text('');
  List? programs;

  @override
  Widget build(BuildContext context) {
    List? allPrograms = widget.data;
    programs ??= allPrograms;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: customSearchBar,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  );
                  customSearchBar = ListTile(
                    title: TextField(
                      onChanged: searchMajors,
                      decoration: InputDecoration(
                        hintText: 'Find your Major...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(
                    Icons.search,
                    color: Colors.black,
                  );
                  customSearchBar = const Text('');
                }
              });
            },
            icon: customIcon,
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: programs?.length as int,
          itemBuilder: ((context, index) {
            final program = programs?[index];

            return ListTile(
              title: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, program);
                  },
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      fixedSize: const Size.fromHeight(75.0)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      program,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )),
            );
          }),
        ),
      ),
    );
  }

  void searchMajors(String query) {
    final suggestions = widget.data
        ?.where((program) =>
            program.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      programs = suggestions as List;
    });
  }
}
