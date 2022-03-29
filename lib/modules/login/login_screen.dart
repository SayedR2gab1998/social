import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/component/component.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/cubit/login_cubit.dart';
import 'package:social/modules/login/cubit/login_states.dart';
import 'package:social/modules/register/register_screen.dart';
import 'package:social/shared/local/cache_helper.dart';
import 'package:social/shared/style/icon_broken.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState)
            {
              showToast(
                message: state.error,
                state: ToastStates.ERROR
              );
            }
          if(state is LoginSuccessState)
            {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uid
              ).then((value){
                navigateAndFinish(context, const SocialLayout());
              });
            }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('login'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                            fontSize: 18
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            else{return null;}
                          },
                          inputType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: IconBroken.Message,
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
                              else{return null;}
                            },
                            inputType: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: IconBroken.Lock,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffix: LoginCubit.get(context).suffixIcon,
                            onSuffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                            text: 'login',
                            onPressed: () {
                              if(formKey.currentState!.validate())
                              {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
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
                          children:
                          [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            defaultTextButton(
                              function: (){
                                navigateAndFinish(context, RegisterScreen());
                              },
                              text: 'register'
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
