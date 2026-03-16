import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// SEARCH FIELD
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: controller.searchProduct,
                    decoration: InputDecoration(
                      hintText: "Search product...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => DropdownButton<Category?>(
                    value: controller.selectedCategory.value,
                    hint: const Text("Category"),
                    underline: const SizedBox(),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text("All"),
                      ),
                      ...Category.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                            (categoryValues.reverse[category] ?? '')
                                    .capitalizeFirst ??
                                '',
                          ),
                        );
                      }),
                    ],
                    onChanged: (val) {
                      controller.selectedCategory.value = val;
                      controller.applyFilter();
                    },
                  )),
              const SizedBox(width: 8),
              Obx(() => DropdownButton<String?>(
                    value: controller.sortOrder.value,
                    hint: const Icon(Icons.sort),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'asc',
                        child: Icon(Icons.arrow_upward, size: 15),
                      ),
                      DropdownMenuItem(
                        value: 'desc',
                        child: Icon(Icons.arrow_downward, size: 15),
                      ),
                    ],
                    onChanged: (val) {
                      controller.sortOrder.value = val;
                      controller.applyFilter();
                    },
                  )),
              const SizedBox(width: 12),
            ],
          ),

          /// PRODUCT LIST
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Image.network(
                        product.image ?? '',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        product.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.category?.name ?? ''),
                          Text("${product.price}")
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
