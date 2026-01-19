import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shose_application_12/viewmodel/cardviewmodel.dart';
import 'package:shose_application_12/widgets/shoecard.dart';
import 'package:shose_application_12/widgets/DraggableBottomCard.dart';

class BestSellerPage extends StatelessWidget {
  const BestSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xffded4e6),
        body: SafeArea(
          child: Stack(
            children: [
              Consumer<CardViewModel>(
                builder: (context, vm, _) {
                  return Column(
                    children: [
                      _appBar(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: vm.allShoes.length,
                          itemBuilder: (context, index) {
                            final shoe = vm.allShoes[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ShoeCard(
                                shoe: shoe,
                                quantity: vm.getQuantity(shoe),
                                onAdd: () => vm.increaseQuantity(shoe),
                                onRemove: () => vm.decreaseQuantity(shoe),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Bottom Sheet
              const DraggableBottomCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 2,
            ),
            child: const Icon(Icons.arrow_back),
          ),
          const Text(
            'Cart',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 2,
            ),
            child: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
