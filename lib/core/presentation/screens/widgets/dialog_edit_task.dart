import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/config/app_colors.dart';
import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:gestion_tareas/core/presentation/screens/providers/users/user_tasks_provider.dart';
import 'package:gestion_tareas/core/presentation/widgets/button/button_builder.dart';
import 'package:gestion_tareas/core/presentation/widgets/textfield/textfield_builder.dart';
import 'package:gestion_tareas/core/config/notification_helper.dart';


class DialogEditTask extends ConsumerStatefulWidget {
  const DialogEditTask({super.key, required this.userId, required this.taskEntity, });

  final int userId;
  final TaskEntity taskEntity;

  @override
  ConsumerState<DialogEditTask> createState() => _DialogEditTaskState();
}

class _DialogEditTaskState extends ConsumerState<DialogEditTask> {


  final TextEditingController titleCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = widget.userId;
      final taskId = widget.taskEntity.id!;
      ref.read(userTaskProvider.notifier).getTaskById(userId: userId, taskId: taskId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(userTaskProvider);
    return AlertDialog(
      title: const Text("Editar tarea"),
      insetPadding: REdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.white,
      content: SizedBox(
        width: 1.sw,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldBuilder(
                fieldType: FieldType.normal,
                controller: titleCtrl..text = taskState.taskDetail?.title ?? '',
                keyboardType: TextInputType.multiline,
                label: 'Titulo',
                maxLines: 5,
                minLines: 1,
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonBuilder(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(userTaskProvider.notifier).deleteTaskById(
                            userId: widget.userId,
                            taskId: widget.taskEntity.id!,
                            onResult: ({successMessage, errorMessage}) {
                              Navigator.pop(context);
                              if (successMessage != null) {
                                NotificationHelper.showNotification(context, successMessage, NotificationType.success);
                              } else if (errorMessage != null) {

                                NotificationHelper.showNotification(context, errorMessage, NotificationType.error);
                              }
                            },
                          );
                        }
                      },
                      label: 'Eliminar',
                      buttonType: ButtonType.flat,
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: ButtonBuilder(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TaskEntity updatedTask = widget.taskEntity.copyWith(title: titleCtrl.text);
                          ref.read(userTaskProvider.notifier).updateTask(
                            userId: widget.userId,
                            updatedTask: updatedTask,
                            onResult: ({successMessage, errorMessage}) {
                              Navigator.pop(context);
                              if (successMessage != null) {
                                NotificationHelper.showNotification(context, successMessage, NotificationType.success);
                              } else if (errorMessage != null) {

                                NotificationHelper.showNotification(context, errorMessage, NotificationType.error);
                              }
                            },
                          );
                        }
                      },
                      label: 'Actualizar',
                      buttonType: ButtonType.flat,
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonBuilder(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      TaskEntity updatedTask = widget.taskEntity.copyWith(completed: true);
                      ref.read(userTaskProvider.notifier).updateTask(
                        userId: widget.userId,
                        updatedTask: updatedTask,
                        onResult: ({successMessage, errorMessage}) {
                          Navigator.pop(context);
                          if (successMessage != null) {
                            NotificationHelper.showNotification(context, successMessage, NotificationType.success);
                          } else if (errorMessage != null) {

                            NotificationHelper.showNotification(context, errorMessage, NotificationType.error);
                          }
                        },
                      );
                    }
                  },
                  label: 'Finalizar tarea',
                  buttonType: ButtonType.flat,
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
