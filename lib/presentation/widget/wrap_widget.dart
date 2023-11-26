import 'dart:async';
import 'package:flutter/material.dart';

Stack bottomTextInput({required Widget child, void Function(String)? onChanged, void Function(String)? onSubmitted}) {
  final controller = TextEditingController();
  return Stack(
    children: [
      child,
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(4),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        onSubmitted?.call(controller.text);
                        controller.clear();
                      },
                      icon: const Icon(Icons.send))),
              onSubmitted: (p0) => {
                onSubmitted?.call(p0),
                controller.clear(),
              },
              onChanged: onChanged,
              controller: controller,
            ),
          ),
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
  Widget Function(Future<void> Function(T r) updaet, T r)? editWidget,
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
                    return ListTile(
                      leading: Stack(
                        children: [
                          Text('${respon.length - index}', style: const TextStyle(fontSize: 24)), //main text
                          Text('${respon.length} :', style: const TextStyle(fontSize: 24, color: Colors.transparent)), //size text
                          const Positioned(right: 0, child: Text(':', style: TextStyle(fontSize: 24))) // :
                        ],
                      ),
                      title: status
                          ? Text(
                              callbackText(respon, index),
                              style: const TextStyle(fontSize: 24),
                            )
                          : editWidget?.call(callbackUpdate, res) ?? const SizedBox.shrink(),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (!status) editWidget?.call(callbackUpdate, res);
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
