import 'package:flutter/material.dart';
import 'package:photos/model/photo.model.dart';
import 'package:photos/repository/photo.data.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  TextEditingController ctr = TextEditingController();
  late Future<List<Photo>> photos;
  int currentPage = 1; // Track the current page

  @override
  void initState() {
    super.initState();
    photos = getPhotos('flower', currentPage);
  }

  void _loadMorePhotos() {
    setState(() {
      currentPage++;
      photos = getPhotos(ctr.text, currentPage);
    });
  }

  void _loadPreviousPhotos() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        photos = getPhotos(ctr.text, currentPage);
      });
    }
  }

  void _searchPhotos() {
    setState(() {
      currentPage = 1;
      photos = getPhotos(ctr.text, currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: ctr,
              style: TextStyle(fontSize: 18, color: Colors.purple),
              decoration: InputDecoration(labelText: 'Mot cle'),
            ),
            ElevatedButton(
              onPressed: () {
                _searchPhotos();
              },
              child: Icon(Icons.search, size: 30),
            ),
            Expanded(
              child: FutureBuilder<List<Photo>>(
                future: photos,
                builder: (context, snp) {
                  if (snp.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: snp.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 8,
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(-1, 0),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(snp.data![index].url),
                                          radius: 100,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0.8, -0.5),
                                        child: Text(
                                          snp.data![index].name,
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.purple),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        _buildPaginationButtons(),
                      ],
                    );
                  } else {
                    return Text('No data', style: TextStyle(color: Colors.red));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _loadPreviousPhotos();
          },
          child: Text('Previous'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _loadMorePhotos();
          },
          child: Text('$currentPage'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _loadMorePhotos();
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}
