// ignore_for_file: use_build_context_synchronously

part of '../home.dart';

class _DrawerHome extends StatelessWidget {
  const _DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.them.buttonColor,
                Colors.pink.shade200,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 5.h,
                backgroundImage:
                    context.read<AppData>().currentUser?.imagePerson != null
                        ? NetworkImage(
                            context.read<AppData>().currentUser!.imagePerson!)
                        : null,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 6.h,
                ),
              ),
              AppText(
                text: context.read<AppData>().currentUser!.name,
                fontSize: 16.sp,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.profile,
                        arguments: [context.read<AppData>().currentUser!]);
                  },
                  child: AppText(
                    text: context.lang.viewProfile,
                  ),
                ),
              )
            ],
          ),
        ),
        ListTile(
          title: AppText(text: context.lang.lang),
          trailing:
              BlocSelector<AppControllerCubit, AppControllerState, Locale>(
            selector: (state) => state.appLang,
            builder: (context, appLang) {
              return SlideSwitcher(
                onSelect: (index) => context
                    .read<AppControllerCubit>()
                    .changeLang(Locale(index == 0 ? 'en' : 'ar')),
                containerHeight: 40,
                initialIndex: appLang.languageCode == 'en' ? 0 : 1,
                containerWight: 30.w,
                children: const [
                  AppText(text: 'EN'),
                  AppText(text: 'AR'),
                ],
              );
            },
          ),
        ),
        ListTile(
          title: AppText(text: context.lang.theme),
          trailing:
              BlocSelector<AppControllerCubit, AppControllerState, Brightness>(
            selector: (state) => state.appTheme,
            builder: (context, appTheme) {
              return DayNightSwitcher(
                isDarkModeEnabled: appTheme == Brightness.dark,
                onStateChanged: (isDarkModeEnabled) => context
                    .read<AppControllerCubit>()
                    .changeTheme(
                        isDarkModeEnabled ? Brightness.dark : Brightness.light),
              );
            },
          ),
        ),
        ListTile(
          title: AppText(text: context.lang.signOut),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.registration, (route) => false);
          },
        )
      ],
    );
  }
}
