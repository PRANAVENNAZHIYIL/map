import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_places/Util/calling_apiI.dart';
import 'package:search_places/models/place_autocomplete.dart';
import 'package:search_places/wideget.dart/location_list.dart';

import 'constants.dart';
import 'models/auto_complete_prediction.dart';

class SearchSCreen extends StatefulWidget {
  const SearchSCreen({super.key});

  @override
  State<SearchSCreen> createState() => _SearchSCreenState();
}

class _SearchSCreenState extends State<SearchSCreen> {
  List<AutocompletePrediction> placePredictions = [];
  void placeAutocomplete(String query) async {
    Uri uri = Uri.http("maps.googleapis.com",
        'maps/api/place/autocomplete/json', {"input": query, "key": apiKey});
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  //https://maps.googleapis.com/maps/api/place/autocomplete/js
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor10LightTheme,
          leading: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: CircleAvatar(
              backgroundColor: secondaryColor10LightTheme,
              child: SvgPicture.asset(
                "assets/icons/location-sign-svgrepo-com.svg",
                height: 16,
                width: 16,
              ),
            ),
          ),
          title: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Location",
              style: TextStyle(color: textColorLightTheme),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                print("pressed on change");
              },
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "change location",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(children: [
          Form(
              child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                      onChanged: (value) {
                        print(value);
                        placeAutocomplete(value);
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "Search your location",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SvgPicture.asset(
                              "assets/icons/location-sign-svgrepo-com.svg",
                              height: 16,
                              width: 16,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: secondaryColor10LightTheme),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: secondaryColor10LightTheme)))))),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor10LightTheme,
          ),
          Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    placeAutocomplete("dubai");
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/location-pin-solid-svgrepo-com.svg",
                    height: 18,
                    width: 18,
                  ), // SvgPicture.asset
                  label: const Text("Use my Current Location"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor10LightTheme,
                    foregroundColor: textColorLightTheme,
                    elevation: 0,
                    fixedSize: const Size(double.infinity, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              )),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor10LightTheme,
          ),
          // LocationListTile(location: "Delhi ncr", press: () {}),
          // LocationListTile(location: "Delhi ncr", press: () {}),
          // LocationListTile(location: "Delhi ncr", press: () {}),
          LocationListTile(location: "Delhi ncr", press: () {}),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => LocationListTile(
                  location: placePredictions[index].description!, press: () {}),
              itemCount: placePredictions.length,
            ),
          )
        ]));

// Padding,);
    // Text
  }
}
