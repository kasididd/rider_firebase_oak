import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rider_firebase_oak/logic/class/collection_class.dart';
import 'package:rider_firebase_oak/logic/function/api_function.dart';
import 'package:rider_firebase_oak/presentation/widget/wrap_widget.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});
  final stcFetch = StreamController<bool>.broadcast();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 24, color: Colors.black),
        child: bottomTextInput(
          onSubmitted: (p0) => create(RiderModel(name: p0, age: 0, riderClass: 0)).then((value) => setFetch()),
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
                future: () => getData(read()),
                editWidget: (update, r) => TextField(
                  controller: TextEditingController(text: r.name),
                  onSubmitted: (t) => update(r..name = t).then((value) => stcFetch.add(true)),
                  onChanged: (t) => update(r..name = t),
                ),
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
