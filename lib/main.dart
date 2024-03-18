import 'edit.dart';
import 'styles.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import 'strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      theme: Styles.appTheme,
      home: const ConfigList(),
    );
  }
}

class ConfigList extends StatefulWidget {
  const ConfigList({super.key});

  @override
  State<ConfigList> createState() => _ConfigListState();
}

class _ConfigListState extends State<ConfigList> {
  LockConfig? config;
  String search = "";
  List<bool> expanded = [false, false];
  late List<LockStore> locks = [LockStore(), LockStore()];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const storeConfig = "storeConfig";

  Future<List<Widget>> _getConfigs() async {
    final SharedPreferences prefs = await _prefs;
    String? raw = prefs.getString(storeConfig);
    if (raw != null) {
      config = LockConfig.fromJson(json.decode(raw));
    }

    if (config == null) {
      final repo = Repo();
      config = await repo.getLockConfigs();
      prefs.setString(storeConfig, json.encode(config));
    }

    if (locks[0].lockVoltage == null) {
      for (int i = 0; i < 2; i++) {
        locks[i].lockVoltage = config!.lockVoltage!.defaultValue;
        locks[i].lockType = config!.lockType!.defaultValue;
        locks[i].lockKick = config!.lockKick!.defaultValue;
        locks[i].lockRelease = config!.lockRelease!.defaultValue;
        locks[i].lockReleaseTime = config!.lockReleaseTime!.defaultValue;
        locks[i].lockAngle = config!.lockAngle!.defaultValue;
      }
    }

    List<Widget> listItems = [];
    if (_searchMatch(Strings.lockVoltage)) {
      listItems.add(_setListItem(Strings.lockVoltage, config!.lockVoltage!,
          locks[0].lockVoltage.toString(), locks[1].lockVoltage.toString()));
    }
    if (_searchMatch(Strings.lockType)) {
      listItems.add(_setListItem(Strings.lockType, config!.lockType!,
          locks[0].lockType.toString(), locks[1].lockType.toString()));
    }
    if (_searchMatch(Strings.lockKick)) {
      listItems.add(_setListItem(Strings.lockKick, config!.lockKick!,
          locks[0].lockKick.toString(), locks[1].lockKick.toString()));
    }
    if (_searchMatch(Strings.lockRelease)) {
      listItems.add(_setListItem(Strings.lockRelease, config!.lockRelease!,
          locks[0].lockRelease.toString(), locks[1].lockRelease.toString()));
    }
    if (_searchMatch(Strings.lockReleaseTime)) {
      listItems.add(_setListItem(
          Strings.lockReleaseTime,
          config!.lockReleaseTime!,
          locks[0].lockReleaseTime.toString(),
          locks[1].lockReleaseTime.toString(),
          config!.lockReleaseTime!.unit.toString()));
    }
    if (_searchMatch(Strings.lockAngle)) {
      listItems.add(_setListItem(
          Strings.lockAngle,
          config!.lockAngle!,
          locks[0].lockAngle.toString(),
          locks[1].lockAngle.toString(),
          config!.lockAngle!.unit.toString()));
    }
    return listItems;
  }

  bool _searchMatch(String label) =>
      search.isEmpty || label.toLowerCase().contains(search.toLowerCase());

  Widget _setListItem(String label, Config c, String value0, String value1,
      [String unit = ""]) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfigEdit(
                      configId: label,
                      config: c,
                      initValues: [value0, value1],
                    )),
          ).then((value) {
            if (value != null) {
              for (int i = 0; i < 2; i++) {
                switch (label) {
                  case Strings.lockVoltage:
                    locks[i].lockVoltage = value[i];
                    break;
                  case Strings.lockType:
                    locks[i].lockType = value[i];
                    break;
                  case Strings.lockKick:
                    locks[i].lockKick = value[i];
                    break;
                  case Strings.lockRelease:
                    locks[i].lockRelease = value[i];
                    break;
                  case Strings.lockReleaseTime:
                    locks[i].lockReleaseTime = value[i];
                    break;
                  case Strings.lockAngle:
                    locks[i].lockAngle = value[i];
                    break;
                }
              }
              setState(() {});
            }
          });
        },
        child: Container(
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.cyan))),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(label, style: Styles.lockHeader)]),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${_valueLabel(value0, c)} $unit".trim()),
                          Text("${_valueLabel(value1, c)} $unit".trim())
                        ])),
              ],
            )));
  }

  String _valueLabel(String value, Config c) {
    if (c.values == null && c.range != null) {
      return double.parse(value).toStringAsFixed(1);
    } else {
      return value;
    }
  }

  Future<void> _reset() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(storeConfig);
    setState(() {
      config = null;
      search = "";
      expanded = [false, false];
      locks = [LockStore(), LockStore()];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(Strings.mainTitle, style: Styles.appBarLabel),
          actions: [
            IconButton(onPressed: _reset, icon: const Icon(Icons.sync))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onChanged: (_) {
                    setState(() {
                      search = controller.text;
                    });
                  },
                  leading: const Icon(Icons.search),
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return [];
              }),
            ),
            Container(
                decoration: const BoxDecoration(color: Colors.cyan),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.primary, style: Styles.lockHeader),
                        Text(Strings.secondary, style: Styles.lockHeader),
                      ],
                    ))),
            FutureBuilder(
                future: _getConfigs(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return _setListError(snapshot.error.toString());
                      } else if (snapshot.hasData && snapshot.data.length > 0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index];
                            });
                      } else {
                        return const SizedBox(
                          width: 0.0,
                          height: 0.0,
                        );
                      }
                  }
                })
          ],
        ));
  }

  Widget _setListError(String error) {
    return Center(
        child: Text("${Strings.error_prompt} $error", style: Styles.errorText));
  }
}
