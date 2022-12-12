import 'package:flutter/material.dart';
import 'package:possibilico/models/possibilico_user.dart';
import 'package:possibilico/screens/auth/onboarding/program_picker.dart';
import 'package:possibilico/services/db.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  DataService database = DataService();
  String? majorValue, minorValue;
  List<DropdownMenuItem<String>>? majorList, minorList;
  TextEditingController fnController = TextEditingController(),
      lnController = TextEditingController();
  List? programList;
  String? major;
  String? fNameError;
  String? lNameError;
  String? majorError;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PossibilicoUser?>(context);

    return FutureBuilder(
        future: database.getDoc('data', 'programs'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic data = snapshot.data;
            // Validate data
            if (data is Map<String, dynamic>) {
              programList = (data['array'] as List).toSet().toList();

              // return onboarding scaffold
              return Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'User Information',
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30.0)),
                      const Text('First Name'),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'John',
                          errorText: fNameError,
                        ),
                        controller: fnController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      const Text('Last Name'),
                      TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Doe',
                          errorText: lNameError,
                        ),
                        controller: lnController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      const Text('Degree Program'),
                      TextButton(
                        style:
                            const ButtonStyle(alignment: Alignment.centerLeft),
                        onPressed: () {
                          _navigateAndDisplaySelection(context);
                        },
                        child: DropdownButton(
                          isExpanded: true,
                          style: const TextStyle(
                            overflow: TextOverflow.visible,
                          ),
                          hint: const Text('Choose a Major'),
                          items: major != null
                              ? [
                                  DropdownMenuItem(
                                      value: major,
                                      child: Text(major as String))
                                ]
                              : null,
                          value: major,
                          onChanged: null,
                        ),
                      ),
                      Text(
                        majorError != null ? majorError as String : '',
                        style: TextStyle(color: Colors.red[800], fontSize: 12),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[800]),
                        child: const Text('Finish'),
                        onPressed: () async {
                          if (fnController.text != '' &&
                              lnController.text != '' &&
                              major is String) {
                            Map<String, dynamic> newData = {
                              'firstName': fnController.text,
                              'lastName': lnController.text,
                              'degreeProgram': major
                            };
                            database.addDoc(
                                'user', user?.id() as String, newData);
                          } else {
                            if (fnController.text.isEmpty) {
                              setState(() {
                                fNameError = 'Name cannot be empty';
                              });
                            }
                            if (lnController.text.isEmpty) {
                              setState(() {
                                lNameError = 'Last name cannot be empty';
                              });
                            }
                            if (major is! String) {
                              setState(() {
                                majorError = 'Major cannot be empty';
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Save firestore query error
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Error'),
                ),
                body: Column(
                  children: [
                    const Spacer(),
                    Text(
                        'Error: ${data is String ? data : 'Firestore query returned \'$data\''}'),
                    const Spacer(),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProgramPicker(programList)),
    );
    setState(() {
      major = result;
    });
  }
}
