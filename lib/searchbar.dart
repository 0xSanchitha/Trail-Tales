import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trail_tales/constants.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double searchBarHeight = 48;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: searchBarHeight,
        child: Row(
          children: [
            Expanded(child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            ),

            const SizedBox(width: 10,),
            
            SizedBox(
              width: searchBarHeight,
              height: searchBarHeight,
              child: ElevatedButton(onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.black)
                ),
                padding: EdgeInsets.zero,
              ), child: Icon(FontAwesomeIcons.magnifyingGlass,color: Colors.black,
              size: 20,)
              ),
            )
          ],
        ),
      ),
    );
  }
}