import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latif_it_mobile_developer/app/routes/app_pages.dart';
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
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio:
                      0.7, // Adjust based on your cell height needs
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: product.id.toString(),
                              child: Image.network(
                                product.image ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  (categoryValues.reverse[product.category] ??
                                              '')
                                          .capitalizeFirst ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
