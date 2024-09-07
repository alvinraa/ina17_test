import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final void Function()? onPressed;
  final String label;
  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showLoading;
  final Widget? withIcon;
  final double? fontSize;
  final double? letterSpacing;
  final bool? isDownload;
  final Widget? progressDownload;
  final bool disabled;
  final BorderSide? side;
  final FontWeight? fontWeight;

  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 40,
    this.width,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.foregroundColor,
    this.showLoading = false,
    this.withIcon,
    this.fontSize = 14,
    this.letterSpacing,
    this.isDownload = false,
    this.progressDownload,
    this.disabled = false,
    this.side,
    this.fontWeight,
  });

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.height,
      width: widget.width ?? double.infinity,
      padding: widget.padding,
      margin: widget.margin,
      child: ElevatedButton(
          onPressed: widget.disabled
              ? null
              : widget.showLoading
                  ? null
                  : widget.onPressed,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                widget.backgroundColor ?? theme.colorScheme.secondary,
            disabledForegroundColor: widget.foregroundColor ?? Colors.white,
            backgroundColor:
                widget.backgroundColor ?? theme.colorScheme.secondary,
            foregroundColor: widget.foregroundColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
            side: widget.side,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.showLoading,
                child: widget.isDownload == true
                    ? widget.progressDownload ??
                        Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                    : Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
              ),
              Visibility(
                child: widget.withIcon ?? Container(),
              ),
              Container(
                padding: widget.padding,
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    letterSpacing: widget.letterSpacing,
                    fontWeight: widget.fontWeight,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
