import 'package:atlas_coins/src/features/transaction/controller/transaction_controller.dart';
import 'package:atlas_coins/src/features/transaction/views/home/components/card_widget.dart';
import 'package:atlas_coins/src/features/transaction/views/home/components/head_widget.dart';
import 'package:atlas_coins/src/features/transaction/views/home/components/transaction.dart';
import 'package:atlas_coins/src/features/user/controller/auth_controller.dart';
import 'package:atlas_coins/src/theme/app_theme.dart';
import 'package:atlas_coins/src/utils/utils_services.dart';
import 'package:atlas_coins/src/theme/constants.dart';
import 'package:atlas_coins/src/features/transaction/views/transaction/transaction_screen.dart';
import 'package:atlas_coins/src/features/user/views/user/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  toggleMenu() {
    menuIsOpen.value ? animation.reverse() : animation.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  final authController = Get.find<AuthController>();
  final TransactionController transactionController = TransactionController();
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        child: GetBuilder<TransactionController>(
          builder: (controller) {
            if (controller.allTransactions.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeadWidget(),
                  CardWidget(
                    controller: controller,
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HeadWidget(),
                CardWidget(
                  controller: controller,
                ),
                Container(
                  margin: const EdgeInsets.only(top: size15, bottom: size15),
                  padding: const EdgeInsets.symmetric(horizontal: size20),
                  child: Text(
                    'Meu extrato:',
                    style: AppTheme.lightText.labelMedium!.apply(
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child:
                      GetBuilder<TransactionController>(builder: (controller) {
                    if (controller.loading.value == true) {
                      return Container(
                        padding: const EdgeInsets.only(left: size15),
                        child: const Text("Carregando..."),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.all(size00),
                      padding: const EdgeInsets.fromLTRB(
                          size20, size00, size20, size00),
                      child: RefreshIndicator(
                        onRefresh: () => controller.getAllTransactions(),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(size00),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (_, index) => Transaction(
                              transactionList:
                                  controller.allTransactions[index]),
                          itemCount: controller.allTransactions.length,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Flow(
        clipBehavior: Clip.none,
        delegate: FabVerticalDelegate(animation: animation),
        children: [
          FloatingActionButton(
            onPressed: () => toggleMenu(),
            backgroundColor: primaryColor,
            child: const Icon(
              Icons.currency_exchange_rounded,
              color: ligthColor,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              authController.signOut();
            },
            backgroundColor: primaryColor,
            child: const Icon(
              Icons.arrow_back,
              color: ligthColor,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Get.to(TransactionScreen());
            },
            backgroundColor: primaryColor,
            child: const Icon(
              Icons.attach_money_sharp,
              color: ligthColor,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Get.to(const UserProfileScreen());
            },
            backgroundColor: primaryColor,
            child: const Icon(
              Icons.person_2_outlined,
              color: ligthColor,
            ),
          ),
        ],
      ),
    );
  }
}

class FabVerticalDelegate extends FlowDelegate {
  final AnimationController animation;

  FabVerticalDelegate({required this.animation}) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    const buttonSize = 56;
    const buttonRadius = buttonSize / 2;
    const buttonMargin = 10;

    final positionX = context.size.width - buttonSize;
    final positionY = context.size.height - buttonSize;
    final lastFabIndex = context.childCount - 1;

    for (int i = lastFabIndex; i >= 0; i--) {
      final y = positionY - ((buttonSize + buttonMargin) * i * animation.value);
      final size = (i != 0) ? animation.value : 1.0;

      context.paintChild(i,
          transform: Matrix4.translationValues(positionX, y, 0)
            ..translate(buttonRadius, buttonRadius)
            ..scale(size)
            ..translate(-buttonRadius, -buttonRadius));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}