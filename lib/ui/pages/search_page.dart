import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter2grow_qoute_app/cubits/cubit/favourite_cubit.dart';
import 'package:inter2grow_qoute_app/models/qoute_model.dart';
import 'package:inter2grow_qoute_app/ui/pages/home_page.dart';


List<QuoteModel> _searchResult = [];

List<QuoteModel> _userDetails = [];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controllersear = TextEditingController();

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.q!.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomePage();
                    }), (route) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(186, 233, 233, 216),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 40, right: 40, top: 12, bottom: 12),
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
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: ListTile(
                    title: TextField(
                      controller: controllersear,
                      decoration: InputDecoration(
                        hintText: 'Type Something Here To Search..',
                        hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      ),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: IconButton(
                      icon: new Icon(Icons.cancel_outlined),
                      onPressed: () {
                        controllersear.clear();
                        onSearchTextChanged('');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: _searchResult.length != 0 ||
                          controllersear.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(children: [
                                      Text(
                                        "${_searchResult[i].q} ",
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff323232)),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "${_searchResult[i].a} ",
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
                                    ]),
                                  )),
                            );
                          },
                        )
                      : Center(
                          child: Container(),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _userDetails = BlocProvider.of<FavouriteCubit>(context).listFav;
    super.initState();
  }
}
