import 'package:card_swiper/card_swiper.dart';
import 'package:final_project/config/route/app_route.dart';
import 'package:final_project/core/custom_widget/app_icon.dart';
import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:final_project/data/repositorty/fireabse_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/custom_widget/app_button.dart';
import '../../core/custom_widget/app_text_form_field.dart';
import '../../core/enum/dialog_types.dart';
import '../../data/api/firebase_auth_api.dart';
import '../../data/api/firebase_databse_api.dart';
import 'bloc/regstration_cubit.dart';
part 'widget/login.dart';
part 'widget/sign_up.dart';
part 'widget/components/password.dart';
part 'widget/components/email.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
      create: (context) => RegistrationCubit(
        firebaseAuthApp: FirebaseAuthApp(
          firebaseAuthApi: FirebaseAuthApi(),
          fireBaseDatabaseApp: FireBaseDatabaseApp(),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<RegistrationCubit, RegistrationState>(
          listener: (context, state) async {
            switch (state.dialogsType) {
              case DialogsType.loading:
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SizedBox(
                      width: 40.w,
                      height: 20.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: context.them.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ).whenComplete(
                    () => context.read<RegistrationCubit>().restDialog());

                break;
              case DialogsType.error:
                Navigator.pop(context);
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SizedBox(
                      width: 40.w,
                      height: 20.h,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(text: state.errorMassage),
                          AppButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: context.lang.ok,
                          )
                        ],
                      )),
                    ),
                  ),
                ).whenComplete(
                    () => context.read<RegistrationCubit>().restDialog());

                break;
              case DialogsType.successful:
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.home, (route) => false);
              case DialogsType.showDatePicker:
                await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                ).then((value) => context
                    .read<RegistrationCubit>()
                    .onSelectedDate(date: value));
              default:
            }
          },
          listenWhen: (previous, current) =>
              previous.dialogsType != current.dialogsType,
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return Swiper(
              itemCount: 2,
              autoplay: false,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: state.cardRegistrationController,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.w),
                          bottomRight: Radius.circular(7.w),
                        ),
                      ),
                      child: Container(
                          color: Colors.blueAccent.shade100,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.all(8),
                          child: index == 0 ? const _Login() : const _SignUp()),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
