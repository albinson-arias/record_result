import 'package:example/cubit/home_cubit.dart';
import 'package:example/repos/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => HomeCubit(homeRepo: HomeRepo()),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is HomeInitial)
                      const Text('Click the button below to get a number'),
                    if (state is HomeLoaded)
                      Text(
                        'The call was succesful!!! The number '
                        'i got was: ${state.loadedNumber}',
                      ),
                    if (state is HomeError)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'The call was unsuccesful 😔 The error '
                          'i got was:\n${state.errorMessage}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (state is HomeLoading)
                      const CircularProgressIndicator.adaptive(),
                    if (state is! HomeLoading)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CupertinoButton.filled(
                          child: const Text('Get number'),
                          onPressed: () =>
                              context.read<HomeCubit>().getNumber(),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
