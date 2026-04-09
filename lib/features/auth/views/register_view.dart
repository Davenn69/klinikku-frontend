import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/icons.dart';
import 'package:klinikku/cores/constants/images.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/widgets/custom_button.dart';
import 'package:klinikku/cores/widgets/custom_text_field.dart';
import 'package:klinikku/features/auth/viewmodels/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  final AutoDisposeChangeNotifierProvider<RegisterVM> registerVM;

  RegisterView({super.key})
    : registerVM = ChangeNotifierProvider.autoDispose<RegisterVM>(
        RegisterVM.new,
      );

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: registerVM, builder: _buildScreen);

  Widget _buildScreen(BuildContext context, RegisterVM vm) => SafeArea(
    child: SingleChildScrollView(
      child: Form(
        key: vm.formKey,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(images.loginBackground),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(32.h),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.white.withValues(alpha: 0.2),
                            ),
                            padding: EdgeInsets.all(8.w),
                            child: SvgPicture.asset(icons.profile),
                          ),
                          Gap(10.w),
                          Text(
                            'KlinikKu',
                            style: textTheme.body1.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),

                      Gap(16.h),
                      Text('Selamat Datang', style: textTheme.headline1),
                      Text('Mari Bergabung 👋', style: textTheme.headline1),
                      Gap(4.h),
                      Text(
                        'Mulai dengan registrasi data anda',
                        style: textTheme.caption2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Nama',
                    hint: 'Masukkan nama anda',
                    inputModel: vm.form.name,
                    onSubmit: (data) {},
                  ),
                  Gap(16.h),
                  CustomTextField(
                    label: 'Email',
                    hint: 'Masukkan email anda',
                    inputModel: vm.form.email,
                    onSubmit: (data) {},
                  ),
                  Gap(16.h),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Masukkan password anda',
                    inputModel: vm.form.password,
                    isPassword: true,
                    onSubmit: (data) {},
                  ),
                  Gap(48.h),
                  Button(text: 'Daftar', onPressed: vm.register),
                  Gap(16.h),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        style: textTheme.caption2.copyWith(
                          color: AppColors.gray1,
                        ),
                        children: [
                          const TextSpan(text: 'Sudah punya akun? '),
                          TextSpan(
                            text: 'Login',
                            style: textTheme.caption2.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    ctx.pushReplacementNamed(
                                      RouterRoutes.login.name,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
