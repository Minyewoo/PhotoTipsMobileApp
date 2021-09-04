import 'package:flutter/widgets.dart';

class CustomButton extends StatefulWidget {
  final double width;
  final double height;
  final String title;
  final EdgeInsets textPadding;
  final Color backgroundColor;
  final Color tapColor;
  final Color textColor;
  final Function onPressed;
  final Widget icon;
  final EdgeInsets iconPadding;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadow;
  final bool columnLayouted;
  final bool reverseOrder;
  final Border border;
  final double fontSize;

  CustomButton({
    this.onPressed,
    this.backgroundColor = const Color(0xffffffff),
    this.tapColor = const Color(0xff9e9e9e),
    this.textColor = const Color(0xff9e9e9e),
    this.title = "",
    this.icon = null,
    this.borderRadius,
    this.columnLayouted = false,
    this.reverseOrder = false,
    this.width = 256,
    this.height = 44,
    this.border,
    this.shadow,
    this.fontSize,
    this.textPadding = EdgeInsets.zero,
    this.iconPadding = EdgeInsets.zero,
  });

  @override
  _CustomButtonState createState() {
    var alignment = MainAxisAlignment.center;
    var content = [
      Padding(
        child: icon,
        padding: iconPadding,
      ),
      Padding(
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: 'PT Root UI'),
        ),
        padding: textPadding,
      )
    ];
    if (reverseOrder) content = content.reversed;

    var positionedContent = columnLayouted
        ? Column(
            children: content,
            mainAxisAlignment: alignment,
          )
        : Row(
            children: content,
            mainAxisAlignment: alignment,
          );

    return _CustomButtonState(
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      shadow: shadow,
      borderRadius: borderRadius,
      content: positionedContent,
      width: width,
      height: height,
      tapColor: tapColor,
      border: border,
    );
  }
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _animation;

  final Widget content;
  final Color backgroundColor;
  final Color tapColor;
  final Function onPressed;
  final BorderRadius borderRadius;
  final double width;
  final double height;
  final Border border;
  final List<BoxShadow> shadow;

  _CustomButtonState({
    this.backgroundColor,
    this.onPressed,
    this.shadow,
    this.borderRadius,
    this.content,
    this.width,
    this.height,
    this.tapColor,
    this.border,
  });

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _animation = ColorTween(begin: backgroundColor, end: tapColor)
        .animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    border: border,
                    borderRadius: borderRadius,
                    boxShadow: shadow,
                    color: _animation.value),
                child: content,
              )),
      onTapDown: (details) => _animationController.forward(),
      onTapUp: (details) {
        _animationController.reverse();
        onPressed?.call();
      },
      onTapCancel: () => _animationController.reverse(),
    );
  }
}