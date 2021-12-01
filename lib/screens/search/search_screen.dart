import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/search_model.dart';
import '/screens/shop/cubit/cubit.dart';
import '/shared/components/text_form_field.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static final _searchController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    myTextFromField(
                      controller: _searchController,
                      type: TextInputType.text,
                      hint: 'search',
                      suffixIcon: Icons.search,
                      suffixPressed: () {
                        SearchCubit.get(context)
                            .getSearch(_searchController.text);
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).getSearch(text);
                      },
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(
                        color: Colors.purple,
                        backgroundColor: Colors.purpleAccent,
                      ),
                    const SizedBox(height: 20.0),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.builder(
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data
                              .data
                              .length,
                          itemBuilder: (context, index) => searchBuilder(
                              SearchCubit.get(context).searchModel,
                              index,
                              context),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchBuilder(SearchModel model, index, context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FadeInImage(
                      width: 100.0,
                      height: 100.0,
                      image: NetworkImage(model.data.data[index].image),
                      placeholder:
                          const AssetImage('assets/default/default.jpg'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  model.data.data[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${model.data.data[index].price.round()}',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  IconButton(
                    icon: Icon(
                      ShopCubit.get(context)
                              .favorites[model.data.data[index].id]!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      ShopCubit.get(context)
                          .changeFavorites(model.data.data[index].id);
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      );
}
