import 'package:beta_shop/screens/shop/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/screens.dart';
import '/screens/shop/cubit/cubit.dart';
import '/shared/components/token.dart';
import '/shared/network/local/cache_helper.dart';
import '/shared/network/remote/dio_helper.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');

  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          home: const ShopScreen(),
          theme: ShopTheme.light(),
        ),
      ),
    );
  }
}
