import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter2grow_qoute_app/cubits/cubit/favourite_cubit.dart';
import 'package:inter2grow_qoute_app/models/qoute_model.dart';
import 'package:inter2grow_qoute_app/ui/pages/favorite_page.dart';



// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  bool isProgress = false;
  QuoteModel? quoteModel;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouriteCubit>(context).getRandomQoute();
    BlocProvider.of<FavouriteCubit>(context).getFavouriteList();
    quoteModel = BlocProvider.of<FavouriteCubit>(context).quoteModel;
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteScuess) {
          quoteModel = BlocProvider.of<FavouriteCubit>(context).quoteModel;
          if (BlocProvider.of<FavouriteCubit>(context).abs == false) {
            BlocProvider.of<FavouriteCubit>(context).chnageIconFav();
          }
        } else if (state is FavouriteInitial)
          quoteModel = QuoteModel(q: 'intial', a: 's', h: 's');
        else if (state is FavouriteFialure) {
          quoteModel = QuoteModel(q: 'fail', a: 's', h: 's');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff5D13E7),
                Color(0xff8249B5),
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonToFav(
                    cnt:
                        BlocProvider.of<FavouriteCubit>(context).listFav.length,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16, left: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              quoteModel?.q ?? 'LODING...',
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
                                    quoteModel?.a ?? '....',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FavouriteCubit>(context)
                                        .getRandomQoute();
                                    BlocProvider.of<FavouriteCubit>(context)
                                        .getFavouriteList();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff5D13E7),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Generate Another Quote',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FavouriteCubit>(context)
                                        .chnageIconFav();

                                    if (BlocProvider.of<FavouriteCubit>(context)
                                            .abs ==
                                        false) {
                                      BlocProvider.of<FavouriteCubit>(context)
                                          .addFavQouteDB(
                                              quoteModel: quoteModel);
                                      BlocProvider.of<FavouriteCubit>(context)
                                          .getFavouriteList();
                                    } else {
                                      BlocProvider.of<FavouriteCubit>(context)
                                          .removefavQoute(quoteModel?.h ?? 'd');
                                      BlocProvider.of<FavouriteCubit>(context)
                                          .getFavouriteList();
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color: const Color(
                                          0xff5D13E7,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      BlocProvider.of<FavouriteCubit>(context)
                                          .icon,
                                      size: 30,
                                      color: Color(0xff5D13E7),
                                    ),
                                  ),
                                )
                              ],
                            )
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
      },
    );
  }
}

class ButtonToFav extends StatelessWidget {
  ButtonToFav({
    super.key,
    required this.cnt,
  });
  final int? cnt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FavoritePage();
            },
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            child: Center(
              child: Container(
                height: 60,
                width: 366,
                decoration: BoxDecoration(
                    color: Color.fromARGB(186, 233, 233, 216),
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Click Here To View Favorite Quotes',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff323232)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 6.0, bottom: 6.0, left: 10, right: 10),
                  child:
                      BlocProvider.of<FavouriteCubit>(context).listFav.length >
                              9
                          ? Center(
                              child: Text(
                                '+9',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          : Center(
                              child: Text(
                                '${BlocProvider.of<FavouriteCubit>(context).listFav.length}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
