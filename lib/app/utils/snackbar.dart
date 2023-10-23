import 'package:get/get.dart';

void showRemoveSnackbar() {
  Get.snackbar(
    'Person Removed',
    'The person has been removed from the team.',
    duration: const Duration(seconds: 2), 
    snackPosition: SnackPosition.TOP, 

  );
}
void showAddSnackbar() {
  Get.snackbar(
    'Person added',
    'The person has been added to the team.',
    duration: const Duration(seconds: 2), 
    snackPosition: SnackPosition.TOP, 

  );
}
