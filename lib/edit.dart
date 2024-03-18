// ignore_for_file: must_be_immutable

import 'api_client.dart';
import 'package:flutter/material.dart';
import 'strings.dart';
import 'styles.dart';

class ConfigEdit extends StatefulWidget {
  final String configId;
  final Config config;
  final List<dynamic> initValues;

  const ConfigEdit(
      {super.key,
      required this.configId,
      required this.config,
      required this.initValues});

  @override
  State<ConfigEdit> createState() => _ConfigEditState();
}

class _ConfigEditState extends State<ConfigEdit> {
  List<dynamic> _currentValues = [null, null];

  @override
  void initState() {
    _currentValues = widget.initValues;
    super.initState();
  }

  Widget _setEditPanel(int lockId) {
    Widget editPanel;
    if (widget.config.values == null && widget.config.range != null) {
      editPanel = SliderTheme(
        data: SliderTheme.of(context).copyWith(
          showValueIndicator: ShowValueIndicator.always,
        ),
        child: Slider(
            value: double.parse(_currentValues[lockId].toString()),
            max: widget.config.range!.max.toDouble(),
            min: widget.config.range!.min.toDouble(),
            label: double.parse(_currentValues[lockId].toString())
                .toStringAsFixed(1),
            onChanged: (double value) {
              setState(() {
                _currentValues[lockId] = value;
              });
            }),
      );
    } else {
      List<ListTile> panelData = [];
      for (dynamic value in widget.config.values!) {
        panelData.add(ListTile(
            title: Text(value.toString(), style: Styles.baseText()),
            leading: Radio<String>(
              value: value,
              groupValue: _currentValues[lockId],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _currentValues[lockId] = value;
                  });
                }
              },
            )));
      }
      editPanel = Column(children: panelData);
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 8.0, 8.0, 15.0),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.cyan),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lockId == 0 ? Strings.primary : Strings.secondary,
                      style: Styles.itemLabel),
                  Text(
                      "${Strings.default_label} ${widget.config.defaultValue}"),
                  editPanel
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(Strings.editTitle, style: Styles.appBarLabel),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(widget.configId, style: Styles.itemLabel)),
                  const Text(Strings.config_description),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [_setEditPanel(0), _setEditPanel(1)],
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(Strings.cancel)),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context, _currentValues),
                        child: const Text(Strings.save)),
                  ],
                ))
          ],
        ));
  }
}
