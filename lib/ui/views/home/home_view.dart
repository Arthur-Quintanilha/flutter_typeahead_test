import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Teste - Typehead'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: FormExample(),
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormExampleViewModel>.reactive(
      viewModelBuilder: () => FormExampleViewModel(),
      builder: (context, viewModel, _) => GestureDetector(
        // close the suggestions box when the user taps outside of it
        onTap: () {
          viewModel.suggestionBoxController.close();
        },
        child: Container(
          color: Colors.amber.withOpacity(0),
          child: Form(
            key: viewModel.formKey,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: const InputDecoration(
                              labelText: 'Atividade',
                              border: OutlineInputBorder(),
                            ),
                            controller: viewModel.activityController,
                          ),
                          suggestionsCallback: (pattern) async {
                            return Service.getSuggestions(pattern);
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          itemSeparatorBuilder: (context, index) {
                            return const Divider();
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (String suggestion) {
                            viewModel.activityController.text = suggestion;
                          },
                          suggestionsBoxController:
                          viewModel.suggestionBoxController,
                          validator: (value) => viewModel.isValid(value)
                              ? 'Esse campo não pode ser nulo'
                              : null,
                          onSaved: (value) =>
                          viewModel.activity = value,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Tempo',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) =>
                          viewModel.hour = value,
                          controller: viewModel.hourController,
                          validator: (value) => viewModel.hourValid(value)
                              ? ''
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    child: const Text('Salvar'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      if (viewModel.formKey.currentState!.validate()) {
                        viewModel.formKey.currentState!.save();
                        viewModel.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Salvo com Sucesso!${viewModel.activity} - ${viewModel.hour}'),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class Service {
  static List<String>  _suggestions = [
    'Alinhamento',
    'blabla',
    'qualquer coisa',
    'working day',
    'celulose',
    'dgfb',
    'hffhb' 'kxp',
    'timesheet',
    'ojfhf',
    'ofuvv',
    'hfuho',
    'ojfjfj',
    'ojrjtv' 'fyff',
    'hfrufhtuf',
    'gfhfhi4',
    'akurhf',
    'grygt'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(_suggestions);
    matches.sort((a, b) {
      bool aStartsWithQuery = a.toLowerCase().startsWith(query.toLowerCase());
      bool bStartsWithQuery = b.toLowerCase().startsWith(query.toLowerCase());
      if (aStartsWithQuery && !bStartsWithQuery) {
        return -1;
      } else if (!aStartsWithQuery && bStartsWithQuery) {
        return 1;
      } else {
        bool aContainsWithQuery = a.contains(query.toLowerCase());
        bool bContainsWithQuery = b.contains(query.toLowerCase());
        if (aContainsWithQuery && !bContainsWithQuery) {
          return -1;
        } else {
          if (!aContainsWithQuery && bContainsWithQuery) {
            return 1;
          } else {
            return a.compareTo(b);
          }
        }
      }
    });
    return matches.take(4).toList();
  }

  static void add(String txt) {
    _suggestions.add(txt);
  }
}

class FormExampleViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController activityController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  String? activity;
  String? hour;

  void save() {
    Service.add(activityController.text);
    //selectedSuggestion = typeAheadController.text;
  }

  bool isValid(value) {
    return value.isEmpty;
  }

  bool hourValid(value) {
    return value.isEmpty;
  }
}
