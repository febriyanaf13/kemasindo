part of login;

class LoginController extends GetxController {
  final scafoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isObscure = true.obs;

  var token = storage.read('token');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  isObscureActive() {
    isObscure.value = !isObscure.value;
  }

  void onTapLogin() {
    if (formKey.currentState!.validate()) {
      LoginProvider()
          .postLogin(nameController.text, passwordController.text, token)
          .then((value) {
        if (value.statusCode == 200) {
          var jsonResponse = value.body;
          var success = jsonResponse['success'];
          var message = jsonResponse['message'];
          if (success == true) {
            if (success) {
              var jsonData = userFromJson(jsonResponse['data']);
              storage.write('userData', {
                "userid": jsonData[0].userid,
                "username": jsonData[0].username,
                "nama": jsonData[0].nama,
                "email": jsonData[0].email,
                "telepon": jsonData[0].telepon,
                "initial": jsonData[0].initial
              });
              storage.write('session', true);

              Get.offNamed(Routes.HOME);
            } else {
              dialogWarning('Opss... ', '$message');
            }
          } else {
            var status = jsonResponse['status'];

            dialogWarning('$status', '${value.statusText}');
          }
        } else {
          dialogError('Error ${value.statusCode}', '${value.statusText}');
        }
        return;
      });
    }
  }
}
