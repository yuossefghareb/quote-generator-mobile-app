import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:inter2grow_qoute_app/db/db_helper.dart';
import 'package:inter2grow_qoute_app/db/local.dart';
import 'package:inter2grow_qoute_app/models/qoute_model.dart';


part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  List<QuoteModel> listFav = [];

  void getFavouriteList() async {
    emit(FavouriteLoading());
    try {
      listFav = await LocalDB.query();
      emit(FavouriteScuessFvList());
    } on Exception  {
     
      emit(FavouriteFialureFvList());
    }
  }

  Future removefavQoute(String h) async{
    emit(FavouriteLoading());
    try {
     await LocalDB.delete(h);
      emit(FavouriteScuessRemove());
    } on Exception  {
    
      emit(FavouriteFialureFvList());
    }

  }

  Future addFavQouteDB({required quoteModel}) async {
    await LocalDB.insert(quoteModel);
    emit(FavouriteScuessInsert());
  }

  QuoteModel? quoteModel;

  Future getRandomQoute() async {
    emit(FavouriteLoading());
    try {
      quoteModel = await DBHelper.generateQoute();
      emit(FavouriteScuess());
    } on Exception  {
   
      emit(FavouriteFialure());
    }
  }

  bool abs = false;
  IconData icon = Icons.favorite_border;
  chnageIconFav() {
    abs = !abs;
    if (abs)
      icon = Icons.favorite_border;
    else
      icon = Icons.favorite;
    emit(FavouriteCahngeIcon());
  }
}
