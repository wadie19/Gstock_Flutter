import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/famille.dart';
import 'package:frontend/models/materiel.dart';
import 'package:frontend/services/family/familyservice.dart';
import 'package:frontend/services/materiell/materilservice.dart';
import 'package:frontend/services/utility/dialog.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class ListMaterial extends StatefulWidget {
  const ListMaterial({Key? key}) : super(key: key);

  @override
  State<ListMaterial> createState() => ListMaterialState();
}

class ListMaterialState extends State<ListMaterial> {
  TextEditingController searchController = TextEditingController();
  String? nomF;
  String? search;
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        nomF = null;
        search = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          AnimSearchBar(
            width: MediaQuery.of(context).size.width * 0.4,
            textController: searchController,
            color: Colors.grey[300],
            helpText: "search ...",
            onSuffixTap: () {
              setState(() {
                searchController.clear();
              });
            },
          ),
          FutureBuilder(
              future: Familyservice.getAllFamily(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Famille>> snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton<String>(
                    value: nomF,
                    iconSize: 24,
                    hint: const Text("Find By family"),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    items: snapshot.data!.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        alignment: AlignmentDirectional.center,
                        value: e.familyname,
                        child: Text(e.familyname!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        search = null;
                        searchController.clear();
                        nomF = value;
                      });
                    },
                  );
                } else {
                  return const Text("No Family");
                }
              }),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    nomF = null;
                    search = null;
                    searchController.clear();
                  });
                },
                child: const Text("RESET"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.blue))))),
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: handleSearch(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Materiel>> projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none ||
                    !projectSnap.hasData) {
                  return const Text("NO DATA");
                }
                return ListView.builder(
                    itemCount: projectSnap.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            elevation: 8,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.shop_two, size: 48),
                                  title: Text(
                                      projectSnap.data![index].nomMateriel!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(projectSnap.data![index].nomF!,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('More detail'),
                                      onPressed: () async {
                                        await MyDialog.detailMaterial(
                                            context, projectSnap.data![index]);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      child: const Text('Borrow'),
                                      onPressed: () async {
                                        MyDialog.borrowMaterialForm(
                                            context, projectSnap.data![index]);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              }),
        )
      ],
    ));
  }

  Future<List<Materiel>> handleSearch() {
    if (nomF != null && nomF!.isNotEmpty) {
      return Materielservice.getMaterialByNomF(nomF!);
    }
    if (search != null && search!.isNotEmpty) {
      return Materielservice.searchMaterial(search!);
    }
    return Materielservice.getAllMaterial();
  }
}
