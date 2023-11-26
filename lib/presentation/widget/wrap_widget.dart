import 'dart:async';
import 'package:flutter/material.dart';

Stack bottomTextInput({
  required Widget child,
  void Function(String)? onChanged,
  void Function(String)? onSeaching,
  void Function(String)? onSubmitted,
}) {
  final controller = TextEditingController();
  final stcSet = StreamController<bool>.broadcast();

  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: StreamBuilder<bool>(
            stream: stcSet.stream,
            builder: (context, snapshot) {
              return child;
            }),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<bool>(
              stream: stcSet.stream,
              initialData: false,
              builder: (context, seaching) {
                void addData() {
                  if (!seaching.data!) {
                    onSubmitted?.call(controller.text);
                    controller.clear();
                  }
                }

                return Container(
                  margin: const EdgeInsets.all(8),
                  height: 40,
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.all(4),
                        border: const OutlineInputBorder(),
                        prefixIcon: InkWell(
                            onTap: () {
                              if (seaching.data!) controller.clear();
                              onSeaching?.call(controller.text);
                              stcSet.add(!seaching.data!);
                            },
                            child: Icon(
                              Icons.search,
                              color: seaching.data! ? Colors.blue : Colors.grey,
                            )),
                        suffixIcon: IconButton(
                            onPressed: () {
                              addData();
                            },
                            icon: const Icon(Icons.send))),
                    onSubmitted: (p0) {
                      addData();
                    },
                    onChanged: (t) {
                      if (seaching.data!) {
                        onSeaching?.call(t);
                        stcSet.add(true);
                      }
                      onChanged?.call(t);
                    },
                    controller: controller,
                  ),
                );
              }),
        ],
      )
    ],
  );
}

/// ใช้สำหรับสร้าง [ListTile] ที่สามารถนำไปใช้ในการ read update delete ข้อมูลจาก API
///
/// `update` and `delete` สามารถนำไปใช้ใน Widget [editWidget].
///
Expanded fetchDataLisTile<T>({
  required Future<List<T>> Function() future,
  required Future<void> Function(T r)? callbackDelete,
  required Future<void> Function(T r) callbackUpdate,
  required StreamController<bool> stcFetch,
  required String Function(List<T> r, int index) callbackText,
  T Function(T, String)? onChanged,
  String Function(T)? callbacEdit,
  List Function(Future<void> Function(T r) updaet, T r)? editWidget,
}) {
  var resFuture = future();
  return Expanded(
    child: StreamBuilder<bool>(
        stream: stcFetch.stream,
        initialData: true,
        builder: (context, fetc) {
          bool status = fetc.data == true;
          if (status) resFuture = future();
          return FutureBuilder(
              future: resFuture,
              builder: (_, data) {
                var respon = (data.data ?? []).reversed.toList();
                if (data.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                return ListView.builder(
                  itemCount: respon.length,
                  itemBuilder: (_, index) {
                    var res = respon[index];
                    List? edit = editWidget?.call(callbackUpdate, res);
                    Widget? widgetEdit = edit?.first;
                    Function onSubmitted = edit?.last;
                    return ListTile(
                      leading: Stack(
                        children: [
                          Text('${respon.length - index}', style: const TextStyle(fontSize: 24)), //main text
                          Text('${respon.length} :', style: const TextStyle(fontSize: 24, color: Colors.transparent)), //size text
                          const Positioned(right: 0, child: Text(':', style: TextStyle(fontSize: 24))) // :
                        ],
                      ),
                      titleAlignment: ListTileTitleAlignment.top,
                      title: status
                          ? Text(
                              callbackText(respon, index),
                              style: const TextStyle(fontSize: 24),
                            )
                          : widgetEdit ?? const SizedBox.shrink(),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (!status) onSubmitted();
                                stcFetch.add(!status);
                              },
                              icon: Icon(
                                !status ? Icons.check : Icons.edit,
                                color: Colors.grey,
                              )),
                          IconButton(
                              onPressed: () {
                                if (!status) return stcFetch.add(true);
                                callbackDelete?.call(res).then((value) => stcFetch.add(true));
                              },
                              icon: Icon(
                                !status ? Icons.close : Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    );
                  },
                );
              });
        }),
  );
}
