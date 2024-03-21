import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/config/app_colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class GenericContainer extends StatelessWidget {
  const GenericContainer(
      {super.key,
      this.onTap,
      this.title,
      this.subTitle,
      required this.leadingIcon,
      this.isCompleted = false,
      this.isUser = true});
  final void Function()? onTap;
  final String? title;
  final String? subTitle;
  final IconData leadingIcon;
  final bool isCompleted;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        width: double.infinity,
        padding: REdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 8,
                color: AppColors.shadowColor,
                offset: Offset(0, 5))
          ],
        ),
        child: Center(
          child: Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.lightUserColor
                        : AppColors.lightTaskColor,
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(
                  leadingIcon,
                  color: isUser
                      ? AppColors.iconUserColor
                      : AppColors.iconTaskColor,
                  size: 24.sp,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      subTitle != null ? Text(subTitle ?? '') : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: isUser
                    ? AppColors.lightUserColor
                    : isCompleted
                        ? AppColors.lightGreenColor
                        : AppColors.lightRedColor,
                child: Icon(
                  isUser
                      ? FluentIcons.chevron_right_12_filled
                      : isCompleted
                          ? Icons.check_rounded
                          : Icons.close,
                  size: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
