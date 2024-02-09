import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter2grow_qoute_app/cubits/cubit/favourite_cubit.dart';
import 'package:inter2grow_qoute_app/models/qoute_model.dart';
import 'package:inter2grow_qoute_app/ui/pages/search_page.dart';



class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff5D13E7),
              Color(0xff8249B5),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(child: backtohome()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(child: searchwidget()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              FavouriteListView(),
            ],
          ),
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class FavouriteListView extends StatelessWidget {
  List<QuoteModel> favLst = [];

  FavouriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouriteCubit>(context).getFavouriteList();
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteScuessFvList) {
          favLst = BlocProvider.of<FavouriteCubit>(context).listFav;
        }
      },
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(childCount: favLst.length,
              (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        "${favLst[index].q} ",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff323232)),
                        textAlign: TextAlign.justify,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "${favLst[index].a} ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 340,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 2.0,
                            color: Color(0xff8249B5),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<FavouriteCubit>(context)
                                .removefavQoute(favLst[index].h ?? 'd');
                            BlocProvider.of<FavouriteCubit>(context)
                                .getFavouriteList();
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  weight: 2,
                                  color: Color(0xff5D13E7),
                                ),
                                Text(
                                  'Remove From Favorite',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5D13E7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class searchwidget extends StatelessWidget {
  const searchwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return SearchPage();
          }),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Type Something Here To Search..',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xff323232)),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}

class backtohome extends StatelessWidget {
  const backtohome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(186, 233, 233, 216),
            borderRadius: BorderRadius.circular(6)),
        child: const Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.arrow_back_ios),
              Text(
                'Back To Home Screen',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff323232)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
