import 'package:atlas_coins/src/models/transaction_model.dart';
import 'package:atlas_coins/src/repositories/transaction_repository.dart';
import 'package:atlas_coins/src/results/transaction_result.dart';
import 'package:atlas_coins/src/router/app_routes.dart';
import 'package:atlas_coins/src/services/utils/static_values.dart';
import 'package:atlas_coins/src/services/utils/utils_services.dart';
import 'package:atlas_coins/src/views/home/home_screen.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController{

  @override
  void onInit() {
    super.onInit(); 
    getAllTransactions();
  }

  String tokenKey = dotenv.get("TOKEN_KEY", fallback: "");

  List<TransactionModel> allTransactions = [];

  TransactionModel transaciton = TransactionModel();

  RxString dateNow = "".obs; 
  RxString newValue = "".obs;
  RxInt transactionType = 1.obs;

  TransactionRepository transactionRepository = TransactionRepository();
  UtilsServices utilsServices = UtilsServices();
  
  RxBool loading = false.obs;

  Future createNewTransaction({
    required String title, 
    required String date,
    required String value,
    required String description
  }) async {

    loading.value = true; 

    String? token = await utilsServices.getLocalData(key: tokenKey);

    var newValue = utilsServices.valueFormater(value);

    if(transactionType.value == 0) {
      newValue = "-$newValue";   
    }

    TransactionResult result = await 
      transactionRepository.createNewTransaction(
        token!,
        title, transactionType.value, date, newValue, description
    );

    loading.value = false;
    
    result.when(
      success: (transactions) {
        refresh(); 
        getAllTransactions();
        Get.toNamed(AppRoutes.homeRoute);
      }, 
      error: (message) {
        
      }
    );
  }

  Future<void> getAllTransactions() async {

    loading.value = true;

    String? token = await utilsServices.getLocalData(key: tokenKey);

    TransactionResult<List<TransactionModel>> result = await transactionRepository.getAllTransactions(token!);

    loading.value = false;

    result.when(
      success: (transactions) {
        allTransactions = transactions;
        update(); 
        totalPrice(); 
        if(allTransactions.isNotEmpty) {
          lastTransaction();
        } 
      }, 
      error: (message) {

      }
    );
  }

  double totalPrice() {
    double total = 0;

    for(var transaction in allTransactions) {
      total += transaction.transactionValue();
    }
 
    return total;
  }

  TransactionModel lastTransaction() {
    return allTransactions.first;
  }

  void setDateNow() async {
    DateTime a = DateTime.now();

    dateNow.value = UtilData.obterDataDDMMAAAA(a);
    refresh();
  }

  void setTransactionType(String value) {
    if(value == TransactionType.expense) {
      transactionType.value = 0; 
    } else {
      transactionType.value = 1; 
    }

    update();
  }

}