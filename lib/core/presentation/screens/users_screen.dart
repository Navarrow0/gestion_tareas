import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/config/app_colors.dart';
import 'package:gestion_tareas/core/presentation/screens/providers/users/user_provider.dart';
import 'package:gestion_tareas/core/presentation/screens/users_tasks_screen.dart';
import 'package:gestion_tareas/core/presentation/widgets/generic_container.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userState = ref.watch(usersProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: const Text('Usuarios'),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (userState.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (userState.errorMessage != null)
                Text(userState.errorMessage!)
              else if (userState.users != null)
                ListView.separated(
                  itemCount: userState.users!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shrinkWrap: true,
                  separatorBuilder: (_, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (ctx, index) {
                    var user = userState.users![index];
                    return GenericContainer(
                      title: user.name,
                      subTitle: user.email,
                      leadingIcon: FluentIcons.person_12_filled,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => UsersTasksScreen(user: user)));
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
