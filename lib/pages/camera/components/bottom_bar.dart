import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_tips/pages/camera/components/setting_slider.dart';
import 'package:photo_tips/pages/galery/galery_page.dart';
import 'package:photo_tips/pages/main/main_page.dart';

enum SliderDisplay { None, Exp, Sec, ISO, WB, Focus }

class BottomBar extends StatefulWidget {
  final Animation<double> animation;
  final bool isHorizonVisible;
  final bool isGridVisible;
  final List<dynamic> expValues;
  final List<dynamic> secValues;
  final List<dynamic> isoValues;
  final List<dynamic> wbValues;
  final List<dynamic> focusValues;
  final Function toggleHorizon;
  final Function toggleGrid;
  final Function takePhoto;
  final Function setExposure;
  final Function setExposureTime;
  final Function setIso;
  final Function setWhiteBalance;
  final Function setFocus;

  const BottomBar(
      {Key key,
      this.animation,
      this.isHorizonVisible,
      this.isGridVisible,
      this.toggleHorizon,
      this.toggleGrid,
      this.takePhoto,
      this.setExposure,
      this.setIso,
      this.setWhiteBalance,
      this.setFocus,
      this.expValues,
      this.isoValues,
      this.wbValues,
      this.focusValues,
      this.secValues,
      this.setExposureTime})
      : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Animation<double> _animation;
  bool _isHorizonVisible;
  bool _isSettingsShown;
  bool _isGridVisible;
  Function _toggleHorizon;
  Function _toggleGrid;
  Function _takePhoto;
  Function _setExposure;
  Function _setExposureTime;
  Function _setIso;
  Function _setWhiteBalance;
  Function _setFocus;
  SliderDisplay _sliderDisplay;
  dynamic _defaultExpValue;
  dynamic _defaultSecValue;
  dynamic _defaultIsoValue;
  dynamic _defaultWbValue;
  dynamic _defaultFocusValue;
  dynamic _expValue;
  dynamic _secValue;
  dynamic _isoValue;
  dynamic _wbValue;
  dynamic _focusValue;

  List<dynamic> expValues;
  List<dynamic> secValues;
  List<dynamic> isoValues;
  List<dynamic> wbValues;
  List<dynamic> focusValues;
  Map<SliderDisplay, Function> onChanged;
  Map<SliderDisplay, List<dynamic>> values;
  Map<SliderDisplay, SettingSlider> sliders;
  /*List<dynamic> get isoValues =>
      ['AUTO', ...List.generate(4, (index) => pow(2, index) * 100)];
  List<dynamic> get wbValues =>
      ['AUTO', ...List.generate(77, (index) => 2300 + 100 * index)];
  List<dynamic> get focusValues => ['AUTO', 'TAP'];*/

  @override
  void initState() {
    expValues = widget.expValues;
    secValues = widget.secValues;
    isoValues = widget.isoValues;
    wbValues = widget.wbValues;
    focusValues = widget.focusValues;
    _defaultExpValue = expValues[(expValues.length / 2).round()];
    _defaultSecValue = secValues[0];
    _defaultIsoValue = isoValues[0];
    _defaultWbValue = wbValues[0];
    _defaultFocusValue = focusValues[0];

    _expValue = _defaultExpValue;
    _secValue = _defaultSecValue;
    _isoValue = _defaultIsoValue;
    _wbValue = _defaultWbValue;
    _focusValue = _defaultFocusValue;

    _sliderDisplay = SliderDisplay.None;

    _animation = widget.animation;
    _isHorizonVisible = widget.isHorizonVisible ?? false;
    _isGridVisible = widget.isGridVisible ?? false;
    _isSettingsShown = false;
    _toggleHorizon = widget.toggleHorizon;
    _toggleGrid = widget.toggleGrid;
    _takePhoto = widget.takePhoto ?? () {};
    _setExposure = widget.setExposure;
    _setExposureTime = widget.setExposureTime;
    _setIso = widget.setIso;
    _setWhiteBalance = widget.setWhiteBalance;
    _setFocus = widget.setFocus;

    onChanged = {
      SliderDisplay.Exp: onExpChanged,
      SliderDisplay.Sec: onSecChanged,
      SliderDisplay.ISO: onIsoChanged,
      SliderDisplay.WB: onWbChanged,
      SliderDisplay.Focus: onFocusChanged,
      SliderDisplay.None: () {},
    };

    values = {
      SliderDisplay.Exp: expValues,
      SliderDisplay.Sec: secValues,
      SliderDisplay.ISO: isoValues,
      SliderDisplay.WB: wbValues,
      SliderDisplay.Focus: focusValues,
    };

    sliders = {
      SliderDisplay.Exp: SettingSlider(
        values: expValues,
        onChanged: onExpChanged,
      ),
      SliderDisplay.Sec: SettingSlider(
        values: secValues,
        onChanged: onSecChanged,
      ),
      SliderDisplay.ISO: SettingSlider(
        values: isoValues,
        onChanged: onIsoChanged,
      ),
      SliderDisplay.WB: SettingSlider(
        values: wbValues,
        onChanged: onWbChanged,
      ),
      SliderDisplay.Focus: SettingSlider(
        values: focusValues,
        onChanged: onFocusChanged,
      ),
    };

    super.initState();
  }

  void toggleSettings() {
    setState(() {
      _sliderDisplay = SliderDisplay.None;
      _isSettingsShown = !_isSettingsShown;
    });
  }

  void resetSettings() {
    setState(() {
      _expValue = _defaultExpValue;
      _isoValue = _defaultIsoValue;
      _wbValue = _defaultWbValue;
      _focusValue = _defaultFocusValue;
    });
    _setExposure(_expValue);
    _setIso(_isoValue);
    _setWhiteBalance(_wbValue);
  }

  void onExpChanged(dynamic value) {
    setState(() {
      _expValue = value;
      _setExposure(value);
    });
  }

  void onSecChanged(dynamic value) {
    setState(() {
      _secValue = value;
      _setExposureTime(value);
    });
  }

  void onIsoChanged(dynamic value) {
    setState(() {
      _isoValue = value;
      _setIso(value);
    });
  }

  void onWbChanged(dynamic value) {
    setState(() {
      _wbValue = value;
      _setWhiteBalance(value);
    });
  }

  void onFocusChanged(dynamic value) {
    setState(() {
      _focusValue = value;
    });
  }

  void changeSliderDisplay(SliderDisplay display) {
    setState(() {
      _sliderDisplay = display;
    });
  }

  List<dynamic> getValues(SliderDisplay display) {
    switch (display) {
      case SliderDisplay.Exp:
        return expValues;
      case SliderDisplay.ISO:
        return isoValues;
      case SliderDisplay.WB:
        return wbValues;
      case SliderDisplay.Focus:
        return focusValues;
      case SliderDisplay.None:
        return null;
      default:
        return null;
    }
  }

  void toggleGrid() {
    setState(() {
      _isGridVisible = !_isGridVisible;
    });
  }

  void toggleHorizon() {
    setState(() {
      _isHorizonVisible = !_isHorizonVisible;
    });
  }

  Function getOnChanged(SliderDisplay display) {
    switch (display) {
      case SliderDisplay.Exp:
        return onExpChanged;
      case SliderDisplay.ISO:
        return onIsoChanged;
      case SliderDisplay.WB:
        return onWbChanged;
      case SliderDisplay.Focus:
        return onFocusChanged;
      case SliderDisplay.None:
        return () {};
      default:
        return () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    //var values = getValues(_sliderDisplay);
    //var onChanged = getOnChanged(_sliderDisplay);
    return Container(
      height: _isSettingsShown ? 160 : 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _isSettingsShown
              ? Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF282828).withOpacity(0.45),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 36,
                        child: _sliderDisplay != SliderDisplay.None
                            ? sliders[_sliderDisplay]
                            : Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => changeSliderDisplay(SliderDisplay.Exp),
                            child: Container(
                              width: 48,
                              height: 44,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Exp',
                                    style: TextStyle(
                                        fontFamily: 'PT Root UI',
                                        fontSize: 12,
                                        color: _sliderDisplay ==
                                                SliderDisplay.Exp
                                            ? Colors.yellow
                                            : Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                  Text(
                                    '${_expValue == "AUTO" ? _expValue : double.parse(_expValue) >= 0 ? "+" + double.parse(_expValue).abs().toString() : _expValue}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => changeSliderDisplay(SliderDisplay.Sec),
                            child: Container(
                              width: 48,
                              height: 44,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Sec',
                                    style: TextStyle(
                                        fontFamily: 'PT Root UI',
                                        fontSize: 12,
                                        color: _sliderDisplay ==
                                                SliderDisplay.Sec
                                            ? Colors.yellow
                                            : Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                  Text(
                                    '${_secValue == "AUTO" ? _secValue : double.parse(_secValue).toStringAsExponential(1)}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => changeSliderDisplay(SliderDisplay.ISO),
                            child: Container(
                              width: 48,
                              height: 44,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'ISO',
                                    style: TextStyle(
                                        fontFamily: 'PT Root UI',
                                        fontSize: 12,
                                        color: _sliderDisplay ==
                                                SliderDisplay.ISO
                                            ? Colors.yellow
                                            : Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                  Text(
                                    '${_isoValue}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => changeSliderDisplay(SliderDisplay.WB),
                            child: Container(
                              width: 48,
                              height: 44,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'WB',
                                    style: TextStyle(
                                        fontFamily: 'PT Root UI',
                                        fontSize: 12,
                                        color: _sliderDisplay ==
                                                SliderDisplay.WB
                                            ? Colors.yellow
                                            : Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                  Text(
                                    '${_wbValue}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeSliderDisplay(SliderDisplay.Focus);
                            },
                            child: Container(
                              width: 48,
                              height: 44,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/focus.svg',
                                    color: _sliderDisplay == SliderDisplay.Focus
                                        ? Colors.yellow
                                        : Color(0xF5F5F5).withOpacity(1),
                                  ),
                                  Text(
                                    '${_focusValue}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: resetSettings,
                            child: Container(
                              width: 48,
                              height: 44,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/reset.svg',
                                    width: 11.5,
                                    height: 11,
                                  ),
                                  Text(
                                    'RESET',
                                    style: TextStyle(
                                        color: Color(0xF5F5F5).withOpacity(1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
          buildBottomBar(context, 'collapse'),
        ],
      ),
    );
  }

  Container buildBottomBar(BuildContext context, String arrowType) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF282828),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              InkWell(
                onTap: toggleSettings,
                child: Container(
                  width: 48,
                  height: 48,
                  child: SvgPicture.asset(
                    'assets/icons/${_isSettingsShown ? "expand" : "collapse"}_arrow.svg',
                    fit: BoxFit.none,
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                child: InkWell(
                  onTap: () {
                    _toggleHorizon();
                    toggleHorizon();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: SvgPicture.asset(
                      'assets/icons/horizon.svg',
                      fit: BoxFit.none,
                      color: _isHorizonVisible
                          ? Color(0xFFFFD600)
                          : Color(0xFFF5F5F5),
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: child,
                  );
                },
              ),
            ],
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                onPressed: _takePhoto,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF282828), width: 1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              AnimatedBuilder(
                animation: _animation,
                child: InkWell(
                  onTap: () {
                    _toggleGrid();
                    toggleGrid();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: SvgPicture.asset(
                      'assets/icons/grid.svg',
                      fit: BoxFit.none,
                      color: _isGridVisible
                          ? Color(0xFFFFD600)
                          : Color(0xFFF5F5F5),
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: child,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(selectedIndex: 2)));
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.photo_library,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: child,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
