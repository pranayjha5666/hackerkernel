import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hackerkernel/Pages/Auth/Screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/product_model.dart';
import '../Services/home_services.dart';
import 'addProduct_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = [];
  List<Product> filteredList = [];
  final TextEditingController searchController = TextEditingController();
  final HomeServices _homeServices = HomeServices();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    productList = await _homeServices.loadProducts();
    setState(() {
      filteredList = List.from(productList);
      isLoading = false;
    });
  }

  void saveProducts() {
    _homeServices.saveProducts(productList);
  }

  void deleteProduct(int index) {
    setState(() {
      productList = _homeServices.deleteProduct(index, productList);
      filteredList = List.from(productList);
    });
    saveProducts();
  }

  void searchProducts(String query) {
    setState(() {
      filteredList = _homeServices.searchProducts(query, productList);
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchProducts,
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text('No Product Found'))
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8.0),
                              ),
                              child: filteredList[index].imagePath != null
                                  ? Image.file(
                                File(filteredList[index].imagePath!),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                                  : const Icon(
                                Icons.image_not_supported,
                                size: 50,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredList[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '\$${filteredList[index].price}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 16,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () => deleteProduct(index),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(productList),
            ),
          );
          if (result == true) {
            loadProducts();
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/
