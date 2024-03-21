

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/config/app_colors.dart';
import 'package:gestion_tareas/core/presentation/screens/providers/users/user_tasks_provider.dart';
import 'package:gestion_tareas/core/presentation/widgets/button/button_builder.dart';
import 'package:gestion_tareas/core/presentation/widgets/textfield/textfield_builder.dart';
import 'package:gestion_tareas/core/config/notification_helper.dart';


class DialogAddTask extends ConsumerStatefulWidget {
  const DialogAddTask({super.key, required this.userId});

  final int userId;


  @override
  ConsumerState<DialogAddTask> createState() => _DialogAddTaskState();
}

class _DialogAddTaskState extends ConsumerState<DialogAddTask> {


  final TextEditingController titleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Nueva tarea"),
      insetPadding: REdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.white,
      content: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldBuilder(
              fieldType: FieldType.normal,
              controller: titleCtrl,
              keyboardType: TextInputType.multiline,
              label: 'Titulo',
              maxLines: 5,
              minLines: 1,
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              width: double.infinity,
              child: ButtonBuilder(
                onPressed: () {
                  if (titleCtrl.text.isNotEmpty) {
                    ref.read(userTaskProvider.notifier).addTask(
                      userId: widget.userId,
                      title: titleCtrl.text,
                      onResult: ({successMessage, errorMessage}) {
                        Navigator.pop(context);
                        if (successMessage != null) {
                          NotificationHelper.showNotification(context, "Agregado correctamente", NotificationType.success);
                        } else if (errorMessage != null) {

                          NotificationHelper.showNotification(context, errorMessage, NotificationType.error);
                        }
                      },
                    );
                  }
                },
                label: 'Agregar',
                buttonType: ButtonType.flat,
              ),
            )
          ],
        ),
      ),
    );
  }
}
