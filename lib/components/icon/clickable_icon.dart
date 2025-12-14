import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClickableIcon extends StatelessWidget {
  final double? padding;
  final GestureTapCallback? onTap;
  final String? svgIcon;
  final String? image;

  const ClickableIcon(
      {Key? key, this.padding, this.onTap, this.svgIcon, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: InkWell(
          onTap: onTap,
          child: svgIcon == null
              ? Image.asset(image!)
              : SvgPicture.asset(
                  svgIcon!,
                ),
        ),
      ),
    );
  }
}

class ClickableWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;

  const ClickableWidget({Key? key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class ContainerCurved extends StatelessWidget {
  final Color color;
  final double radius;
  final Widget? child;
  final double? height;
  final double? width;

  const ContainerCurved(
      {Key? key,
      this.color = Colors.white,
      this.radius = 8,
      this.child,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius)),
        child: child);
  }
}

class CardCurved extends StatelessWidget {
  final Color color;
  final double radius;
  final Widget? child;

  const CardCurved(
      {Key? key, this.color = Colors.white, this.radius = 8, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: child,
      ),
    );
  }
}
