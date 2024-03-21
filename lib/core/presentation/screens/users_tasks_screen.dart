import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/config/app_colors.dart';
import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:gestion_tareas/core/presentation/screens/providers/users/user_tasks_provider.dart';
import 'package:gestion_tareas/core/presentation/screens/widgets/dialog_add_task.dart';
import 'package:gestion_tareas/core/presentation/screens/widgets/dialog_edit_task.dart';
import 'package:gestion_tareas/core/presentation/widgets/generic_container.dart';

class UsersTasksScreen extends ConsumerStatefulWidget {
  const UsersTasksScreen({super.key, required this.user});

  final UserEntity user;

  @override
  ConsumerState<UsersTasksScreen> createState() => _UsersTasksScreenState();
}

class _UsersTasksScreenState extends ConsumerState<UsersTasksScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = widget.user.id!;
      ref.read(userTaskProvider.notifier).getTasks(userId: userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(userTaskProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogAddTask(userId: widget.user.id!,);
              },
          );
        },
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.iconTaskColor,
        child: const Icon(Icons.add_rounded),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            const Text('Tareas'),
            Text(
              widget.user.name ?? '',
              style: TextStyle(fontSize: 16.sp),
            )
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (taskState.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (taskState.errorMessage != null)
                Text(taskState.errorMessage!)
              else if (taskState.tasks != null)
                ListView.separated(
                  itemCount: taskState.tasks!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shrinkWrap: true,
                  separatorBuilder: (_, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (ctx, index) {
                    var task = taskState.tasks![index];
                    return GenericContainer(
                      title: task.title,
                      leadingIcon: FluentIcons.task_list_square_ltr_16_filled,
                      isUser: false,
                      isCompleted: task.completed!,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DialogEditTask(userId: widget.user.id!, taskEntity: task,);
                          },
                        );
                      },
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
