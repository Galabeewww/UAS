import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart'
    as http; // Package http untuk melakukan HTTP request
import 'package:logger/logger.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:convert';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<List<dynamic>> fetchData() async {
  String request =
      'https://gateway.marvel.com:443/v1/public/events?ts=1&apikey=04a2ff9a844f1270e7de4e88cb739065&hash=d57e55cc7d02e7ac08196eacf07cfaa5'; // URL endpoint untuk mengambil data dari API

  logger.t(
      "Start fetch data"); // Log untuk menandai awal pengambilan data dari API
  final response =
      await http.get(Uri.parse(request)); // Lakukan HTTP GET request ke API

  if (response.statusCode == 200) {
    // Jika response status code adalah 200 (berhasil)
    logger.i(
        'Berhasil fetch data'); // Log untuk menandai berhasilnya pengambilan data dari API
    final res = json.decode(response.body); // Decode data JSON dari response
    final data = res['data']['results']; // Ambil data dari hasil decode

    return data; // Kembalikan data
  } else {
    // Jika response status code tidak 200 (gagal)
    logger.e(
      'Error!',
      error:
          'Terjadi kesalahan saat fetch data', // Log error untuk menandai kesalahan saat pengambilan data dari API
    );

    throw Exception(
        'Failed to fetch data'); // Jika fetch data gagal, throw exception dengan pesan "Failed to fetch data"
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Bar atas
      appBar: AppBar(
        title: Text('Marvel Event'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 112, 0, 0),
      ),

      //Body content
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 800,
                child: FutureBuilder<List<dynamic>>(
                  future: fetchData(),
                  // Panggil fungsi fetchData() untuk mengambil data dari API
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Jika masih dalam proses fetch data dari API
                      // Menampilkan loading animation ketika fetch data dari API
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: Colors.black,
                          // Warna loading animation (sesuai dengan nilai konstanta redColor)
                          size: 25, // Ukuran loading animation
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Jika terjadi error saat fetch API
                      // Return pesan error jika fetch API gagal
                      return Text(
                        'Error : ${snapshot.error}', // Tampilkan pesan error
                      );
                    } else {
                      final data =
                          snapshot.data!; // Ambil data peta dari snapshot

                      return GridView.builder(
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          final gambar = data[index];
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 11.0, vertical: 8.0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                // padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      child: Image.network(
                                        "${gambar['thumbnail']['path']}.${gambar['thumbnail']['extension']}",
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            15), // Jarak antara gambar dan teks
                                    Text(
                                      gambar[
                                          'title'], // Teks yang ingin ditampilkan
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        "${(gambar['urls'] as List<dynamic>).first['url']}";
                                      },
                                      child: Text(
                                        "Visit Site",
                                        style: TextStyle(
                                          height: 5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
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

                      // return ListView.builder(
                      //   itemCount:
                      //       data.length, // Tampilkan hanya 5 peta (misalnya)
                      //   itemBuilder: (context, index) {
                      //     final map =
                      //         data[index]; // Ambil data peta berdasarkan indeks

                      //     return Container(
                      //       width: double.infinity,
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 11.0, vertical: 15.0),
                      //       child: Card(
                      //         elevation: 4, // Tidak ada bayangan pada Card
                      //         child: Padding(
                      //           padding: EdgeInsets.all(8.0),
                      //           child: Row(
                      //             children: [
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Image.network(
                      //                   "${map['thumbnail']['path']}.${map['thumbnail']['extension']}",
                      //                   // Tampilkan gambar peta dari URL API
                      //                   width: 150,
                      //                   height: 150,
                      //                   fit: BoxFit.fill,
                      //                 ),
                      //               ),
                      //               Container(
                      //                 margin: EdgeInsets.symmetric(
                      //                     horizontal: 10.0),
                      //                 child: Column(
                      //                   children: [
                      //                     // Text(map['namatim']),
                      //                     // Text(map['namapemain'])
                      //                   ],
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.redAccent,
//     );
//   }
// }
