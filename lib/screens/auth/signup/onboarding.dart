import 'package:flutter/material.dart';
import 'package:possibilico/models/possibilico_user.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PossibilicoUser?>(context);
    List<DropdownMenuItem<String>> toDropdownItems(dynamic dataList) {
      return dataList
          .map<DropdownMenuItem<String>>(((Map<String, dynamic> item) {
        return DropdownMenuItem<String>(
          value: item['name'],
          child: Text(item['value']),
        );
      })).toList();
    }

    return FutureBuilder(
        future: Future.wait(
            [database.getCollection('major'), database.getCollection('minor')]),
        builder: (context, snapshot) {
          String errorText = '';

          if (snapshot.hasData) {
            dynamic data = snapshot.data;
            // Validate data
            if (data[0] is List<Map<String, dynamic>>) {
              majorList = toDropdownItems(data[0]);
              minorList = toDropdownItems(data[1]);

              // return onboarding scaffold
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.purple[800],
                  elevation: 0.0,
                  title: const Text('User Information'),
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('First Name'),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'John',
                        ),
                        controller: fnController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      const Text('Last Name'),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Doe',
                        ),
                        controller: lnController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Row(
                        children: [
                          const Spacer(),
                          DropdownButton<String>(
                            hint: const Text('Pick a Major'),
                            value: majorValue,
                            onChanged: (String? value) => setState(() {
                              majorValue = value;
                            }),
                            items: majorList,
                          ),
                          const Spacer(),
                          DropdownButton<String>(
                            hint: const Text('Pick a Minor'),
                            value: minorValue,
                            onChanged: (String? value) => setState(() {
                              minorValue = value;
                            }),
                            items: minorList,
                          ),
                          const Spacer(),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[800]),
                        child: const Text('Finish'),
                        onPressed: () async {
                          Map<String, dynamic> newData = {
                            'first name': fnController.text,
                            'last name': lnController.text,
                            'major': majorValue,
                            'minor': minorValue
                          };
                          database.addDoc(
                              'user', user?.id() as String, newData);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Save firestore query error
              errorText =
                  'Error: ${data is String ? data : 'Firestore query returned \'$data\''}';
            }
          } else {
            // No data was returned from future, save error string
            errorText = 'Error: No data returned from future';
          }

          // return view with error
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Column(
              children: [
                const Spacer(),
                Text(errorText),
                const Spacer(),
              ],
            ),
          );
        });
  }
}

class onBoardingScaffold extends Scaffold {
  const onBoardingScaffold({super.body});
}
