import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class SettingSlider extends StatefulWidget {
  List<dynamic> values;
  double min;
  double max;
  int divisions;
  double currentValue;
  Function onChanged;

  SettingSlider({
    Key key,
    this.values,
    this.min,
    this.max,
    this.divisions,
    this.currentValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _SettingSliderState createState() => _SettingSliderState();
}

class _SettingSliderState extends State<SettingSlider> {
  List<dynamic> _values;
  double _currentSliderValue;
  double _min;
  double _max;
  int _divisions;
  Function _onChanged;

  @override
  void initState() {
    _values = widget.values;
    _currentSliderValue = widget.currentValue ?? 0;
    _min = _values == null ? widget.min ?? 0 : 0;
    _max =
        _values == null ? widget.max ?? 100 : (_values.length - 1).toDouble();
    _divisions = _values == null ? widget.divisions ?? 5 : _values.length - 1;
    _onChanged = widget.onChanged ?? (value) {};
    super.initState();
  }

  void onChanged(double value) {
    setState(() {
      _currentSliderValue = value;
    });
    _onChanged(_values[_currentSliderValue.round()]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_values.first}', style: TextStyle(fontSize: 8),),
                Text('${_values[(_values.length / 4).round()]}', style: TextStyle(fontSize: 8),),
                Text('${_values[((_values.length / 4) * 2).round()]}', style: TextStyle(fontSize: 8),),
                Text('${_values.last}', style: TextStyle(fontSize: 8),)
              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 12,
              width: MediaQuery.of(context).size.width - 40,
              child: SliderTheme(
                data: SliderThemeData(trackShape: CustomTrackShape()),
                child: Slider(
                  activeColor: Color(0xFFF5F5F5),
                  inactiveColor: Color(0xFFF5F5F5),
                  value: _currentSliderValue,
                  min: _min,
                  max: _max,
                  divisions: _divisions,
                  label: _values == null
                      ? _currentSliderValue.round().toString()
                      : _values[_currentSliderValue.round()].toString(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
