import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/search_model.dart';
import '/screens/search/cubit/states.dart';
import '/shared/components/token.dart';
import '/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel searchModel;

  void getSearch(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: 'products/search',
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
