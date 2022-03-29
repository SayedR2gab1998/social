import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/component/component.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/modules/register/cubit/register_cubit.dart';
import 'package:social/modules/register/cubit/register_states.dart';
import 'package:social/shared/style/icon_broken.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is CreateUserSuccessState)
            {
              navigateAndFinish(context, const SocialLayout());
            }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Register'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                         const SizedBox(
                          height: 10,
                        ),
                        Text('Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                            fontSize: 18
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          inputType: TextInputType.text,
                          label: 'User Name',
                          prefix: IconBroken.User,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          inputType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: IconBroken.Message,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          inputType: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: IconBroken.Call,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: IconBroken.Lock,
                          isPassword: cubit.isPassword,
                          suffix: cubit.suffixIcon,
                          onSuffixPressed: () {
                            cubit.changePasswordVisibility();
                          }
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please confirm your password';
                            } else if (value != passwordController.text) {
                              return 'Password not match';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate())
                            {

                            }
                          },
                          inputType: TextInputType.visiblePassword,
                          label: 'Confirm Password',
                          prefix: IconBroken.Lock,
                          isPassword: cubit.isPassword,
                          suffix: cubit.suffixIcon,
                          onSuffixPressed: () {
                            cubit.changePasswordVisibility();
                          }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                            text: 'register',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            }
                          ),
                          fallback: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?',
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            defaultTextButton(
                              text: 'Login',
                              function: () {
                                navigateAndFinish(context, LoginScreen());
                              }
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
