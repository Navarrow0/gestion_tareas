import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/config/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum FieldType { email, password, normal, date, phone, underLine, number }

// ignore: must_be_immutable
class TextFormFieldBuilder extends StatefulWidget {
  TextFormFieldBuilder(
      {super.key,
        this.controller,
        this.label,
        this.suffixIcon,
        this.onChanged,
        this.keyboardType,
        this.textCapitalization = TextCapitalization.none,
        this.inputFormatters,
        this.prefixText,
        this.hintText,
        this.obscureText = false,
        this.enabled = true,
        this.readOnly = false,
        this.maxLength,
        this.minLines,
        this.validator,
        this.onTap,
        this.autovalidateMode,
        this.maxLines = 1,
        this.focusNode,
        required this.fieldType,
        this.prefixIcon,
        this.textInputAction,
        this.labelColor = AppColors.grey,
        this.labelFontWeight = FontWeight.w300,
        this.inputBorderColor,
        this.contentPadding,
        this.inputBackgroundColor = AppColors.lightGrey,
        this.radius = 16
      });

  final TextEditingController? controller;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final int? minLines;

  String? Function(String?)? validator;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;

  final int? maxLines;
  final FocusNode? focusNode;
  final FieldType fieldType;

  final TextInputAction? textInputAction;

  final Color labelColor;

  final FontWeight labelFontWeight;

  final Color? inputBorderColor;

  EdgeInsetsGeometry? contentPadding;

  final Color? inputBackgroundColor;

  final double radius;

  @override
  State<TextFormFieldBuilder> createState() => TextFormFieldBuilderState();
}

class TextFormFieldBuilderState extends State<TextFormFieldBuilder> {
  bool isError = false;
  String? errorString = "";
  Color colorError = AppColors.white;

  @override
  Widget build(BuildContext context) {
    createStyle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: widget.controller,
          //onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          autovalidateMode: widget.autovalidateMode,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength, //
          minLines: widget.minLines,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: widget.enabled ? Colors.black : Colors.grey,
              fontSize: 14.sp),
          validator: (String? value) {
            if (widget.validator!(widget.controller!.text)
                .toString()
                .isNotEmpty) {
              setState(() {
                isError = true;
                errorString = widget.validator!(widget.controller!.text);
              });
              return "";
            } else {
              setState(() {
                isError = false;
                errorString = widget.validator!(widget.controller!.text);
              });
            }

            return null;
          },
          decoration: InputDecoration(
            counterText: '',
            suffixIcon: widget.suffixIcon != null
                ? Padding(
              padding: REdgeInsets.only(right: 15, left: 10),
              child: widget.suffixIcon,
            )
                : null,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
              padding: REdgeInsets.only(left: 15, right: 10),
              child: widget.prefixIcon,
            )
                : null,
            prefixText: widget.prefixText,
            hintText: widget.hintText,
            labelText: widget.label,
            contentPadding: widget.contentPadding,
            //floatingLabelStyle: const TextStyle(color:  fontWeight: FontWeight.w500),
            floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.focused)
                  ? AppColors.activeLabelColor
                  : AppColors.labelColor;
              return TextStyle(height: 0.8, fontWeight: FontWeight.w600, fontSize: 14.sp, color: color);
            }),
            labelStyle: TextStyle(height: 0.8, fontWeight: FontWeight.normal, fontSize: 12.sp, ),
            errorStyle: TextStyle(
              height: 0,
              color: isError ? colorError : const Color(0xff778FAA),
            ),
            hintStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    color: AppColors.grey
                )
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    color: AppColors.grey
                )
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    color: AppColors.grey
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    color: AppColors.activeLabelColor
                )
            ),
          ),
        ),
        Visibility(
          replacement: const SizedBox(),
          visible: isError ? true : false,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              margin: const EdgeInsets.only(top: 14),
              decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                errorString!,
                style: TextStyle(color: colorError, fontSize: 13.sp),
              ),
            ),
          ),
        )
      ],
    );
  }

  void createStyle() {
    widget.contentPadding =
        widget.contentPadding ?? REdgeInsets.fromLTRB(12, 18, 12, 18);
    switch (widget.fieldType) {
      case FieldType.email:
        widget.inputFormatters = [
          LengthLimitingTextInputFormatter(60),
        ];
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio para continuar';
          }
          if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return '* Debes de ingresa un correo válido';
          }
          return '';
        };
        break;
      case FieldType.password:
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
      case FieldType.normal:
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return '* Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
      case FieldType.date:
        widget.inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,

          ///MaskedInputFormatter('##/##/####'),
          MaskTextInputFormatter(
              mask: '##/##/####', type: MaskAutoCompletionType.lazy)
        ];
        break;
      case FieldType.phone:
        widget.keyboardType =
        const TextInputType.numberWithOptions(signed: true);
        widget.inputFormatters = [
          MaskTextInputFormatter(
              mask: '## #### ####',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];
        break;
      case FieldType.underLine:
        break;
      case FieldType.number:
        widget.keyboardType = const TextInputType.numberWithOptions(signed: true);
        widget.inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
    }
  }
}
