import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rider_firebase_oak/logic/class/collection_class.dart';
import 'package:rider_firebase_oak/logic/function/api_function.dart';
import 'package:rider_firebase_oak/presentation/widget/state_widget.dart';
import 'package:rider_firebase_oak/presentation/widget/wrap_widget.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});
  final stcFetch = StreamController<bool>.broadcast();
  @override
  Widget build(BuildContext context) {
    Future<Iterable<Map<String, dynamic>>>? getDataApi;
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 24, color: Colors.black),
        child: bottomTextInput(
          onSeaching: (t) async {
            getDataApi = read(t);
            if (t.isEmpty) getDataApi = null;
            stcFetch.add(true);
          },
          onSubmitted: (p0) => create(RiderModel(name: p0, age: 0, riderClass: 0, timeCreate: DateTime.now())).then((value) => setFetch()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 24),
                child: InkWell(
                  onTap: setFetch,
                  child: const Text(
                    "Data Getting List Click Refresh",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              fetchDataLisTile(
                stcFetch: stcFetch,
                callbacEdit: (r) => r.name,
                callbackText: (respon, index) => respon[index].name,
                future: () => getData(getDataApi ?? read()),
                editWidget: (update, r) {
                  final tecName = TextEditingController(text: r.name);
                  final tecAge = TextEditingController(text: r.age.toString());
                  final tecClass = TextEditingController(text: r.riderClass.toString());
                  void onSubmitted([String? t]) {
                    update(
                      r
                        ..name = tecName.text
                        ..age = int.parse(tecAge.text)
                        ..riderClass = int.parse(tecClass.text),
                    ).then((value) => stcFetch.add(true));
                  }

                  return [
                    Column(
                      children: [
                        TextInputSmall(text: 'Name', controller: tecName, onSubmitted: onSubmitted),
                        TextInputSmall(text: 'Age', controller: tecAge, onSubmitted: onSubmitted),
                        TextInputSmall(text: 'RiderClass', controller: tecClass, onSubmitted: onSubmitted),
                      ],
                    ),
                    onSubmitted,
                  ];
                },
                callbackDelete: delete,
                onChanged: (r, t) => r..name = t,
                callbackUpdate: update,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setFetch() => stcFetch.add(true);
}
