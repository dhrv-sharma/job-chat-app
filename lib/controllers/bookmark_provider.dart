import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:jobchat/constants/app_constants.dart';


import 'package:jobchat/models/bookmark.dart/all_bookmarks.dart';


import 'package:jobchat/services/bookmarkHelper.dart';


class BookMarkNotifier extends ChangeNotifier {

// variable for bookmark


  late Future<List<AllBookMarks>?> userBookMarks;


  bool _bookmark = false;


  bool get bookmarkget => _bookmark;


  set bookmarkset(bool newstate) {

    if (_bookmark != newstate) {

      _bookmark = newstate;


      notifyListeners();

    }

  }


// variable for bookmarkId


  String _bookmarkId = "";


  String get bookmarkIdGet => _bookmarkId;


  set bookMarkIdSet(String newstate) {

    if (_bookmarkId != newstate) {

      _bookmarkId = newstate;


      notifyListeners();

    }

  }


// add bookmark


  addBookMark(String model) {

    bookMarkHelper.addBookMark(model).then((bookmark) {

      if (bookmark != null) {

        Get.snackbar(

          "Book Mark Successfully",

          "View More on BookMarks ",

          colorText: Color(kLight.value),

          backgroundColor: Colors.green,

          icon: const Icon(

            Icons.bookmark_add_outlined,

            color: Colors.white,

          ),

        );


        bookmarkset = true;


        bookMarkIdSet = bookmark.bookmarkId;

      }

    });

  }


// get single bookmark


// check wheather it is bookmarked or not


  getBookMark(String jobid) {

// this function return BookMark


    bookMarkHelper.getSingleBookMark(jobid).then((bookmark) {

      // null means job is not bookmarked


      if (!bookmark!.status) {

        bookmarkset = false;


        bookMarkIdSet = "";

      } else {

        bookmarkset = bookmark.status;


        bookMarkIdSet = bookmark.bookmarkId;

      }

    });

  }


// delete book mark


  deleteBookMark(String bookMarkId) {

    bookMarkHelper.deleteBookMark(bookMarkId).then((value) {

      if (value!) {

        Get.snackbar("Book mark Successfully Deleted",

            "Visit The bookmarks page to see the changes",

            colorText: Color(kLight.value),

            backgroundColor: Color(kOrange.value),

            icon: const Icon(

              Icons.bookmark_remove_outlined,

              color: Colors.white,

            ),

            borderRadius: 5);


        bookmarkset = false;


        bookMarkIdSet = "";

      }

    });

  }


// get all the book marks of the user


  Future<List<AllBookMarks>?> getBookMarks() {

    userBookMarks = bookMarkHelper.getAllBookMarks();


    return userBookMarks;

  }

}

