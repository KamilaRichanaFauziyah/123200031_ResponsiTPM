import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/api/datasource.dart';
import 'package:project_akhir_tpm/models/product.dart';
import 'login.dart';

class PageListProducts extends StatefulWidget {
  const PageListProducts({Key? key}) : super(key: key);

  @override
  State<PageListProducts> createState() => _PageListProductsState();
}

class _PageListProductsState extends State<PageListProducts> {
  late Future<List<ProductModel>> _futureProductsModel;

  String kategori_pilihan = "Semua";

  var kategori = [
    "Semua",
    "Avengers",
  ];

  @override
  void initState() {
    super.initState();
    _futureProductsModel = ApiDataSource.instance.loadProducts("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar List"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DropdownButton(
                value: kategori_pilihan,
                icon: Icon(Icons.keyboard_arrow_down),
                items: kategori.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    kategori_pilihan = newValue!;
                    var pilihan = (newValue == "semua") ? "" : newValue;
                    _futureProductsModel = ApiDataSource.instance.loadProducts(pilihan);
                  });
                },
              ),
            ),
          ),
          Expanded(child: _buildListProductsBody())
        ],
      ),
    );
  }

  Widget _buildListProductsBody() {
    return Container(
      child: FutureBuilder<List<ProductModel>>(
        future: _futureProductsModel,
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasError) {
            // If data has error, display the error message
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // If data is available and successful, display the data
            return _buildSuccessSection(snapshot.data!);
          }
          // If data is still loading, display a progress indicator
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: const Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<ProductModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemProduct(context, data[index]);
      },
    );
  }

  Widget _buildItemProduct(BuildContext context, ProductModel product) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PageDetail(product: product,)),
        // );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: CachedNetworkImage(
                imageUrl: product.Poster!,
                placeholder: (context, url) => Image.asset("image/placeholder.png"),
                errorWidget: (context, url, error) => Image.asset("image/placeholder.png"),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.Title!),
                  Text("${product.Year!.toString()}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

