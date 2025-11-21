import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

import '../../Api/Api_Manager.dart';
import '../../Ui/login/ShowDialog.dart';
import '../../Utils/UserToken.dart';

class ResetField extends StatefulWidget {
  const ResetField({super.key});

  @override
  State<ResetField> createState() => _ResetFieldState();
}

class _ResetFieldState extends State<ResetField> {
  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool obscureOld = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    oldController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField("Old password", oldController, obscureOld, () {
          setState(() { obscureOld = !obscureOld; });
        }),
        const SizedBox(height: 15),
        _buildField("New password", newController, obscureNew, () {
          setState(() { obscureNew = !obscureNew; });
        }),
        const SizedBox(height: 15),
        _buildField("Confirm password", confirmController, obscureConfirm, () {
          setState(() { obscureConfirm = !obscureConfirm; });
        }),
        const SizedBox(height: 25),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildField(String hint, TextEditingController controller, bool obscure, VoidCallback toggleVisibility) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Appcolors.card,
        hintText: hint,
        hintStyle: TextStyle(color: Appcolors.whitekColor),
        prefixIcon: Icon(Icons.lock, color: Appcolors.whitekColor),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Appcolors.whitekColor),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Appcolors.whitekColor),
    );
  }


  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.yellowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          final oldPass = oldController.text.trim();
          final newPass = newController.text.trim();
          final confirmPass = confirmController.text.trim();

          if(oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty){
            MyDialog.show(context: context, title: "Error ", message: "Please fill all fields", onPressed: () {
              Navigator.of(context).pop();

            });
            return;
          }
          if(newPass != confirmPass){
            MyDialog.show(context: context, title: "Error ", message:"Passwords do not match", onPressed: () {
              Navigator.of(context).pop();

            });
            return;
          }

          final token = await Usertoken.getToken();
          if(token == null){
            MyDialog.show(context: context, title: "Error ", message:"User not logged in", onPressed: () {
              Navigator.of(context).pop();

            });
            return;
          }

          try {
            final response = await ApiManager().ChangePassword(
              oldPassword: oldPass,
              newPassword: newPass,
              confirmPassword: confirmPass,
              token: token,
            );

            if(response.statusCode == 200 || response.statusCode == 201){
              MyDialog.show(context: context, title: "Done ", message:"Password changed successfully", onPressed: () {
                Navigator.of(context).pop(); // ممكن ساعتها ي نافيجين ع الهوم

              });            } else {
              MyDialog.show(context: context, title: "Failed ", message: "${response.data['message']}", onPressed: () {
                print("${response.data['message']}");
                Navigator.of(context).pop();

              });
            }

          } catch(e) {
            print("Exception: $e");
          }

        },
        child: Text(
          "Reset",
          style: TextStyle(
            color: Appcolors.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

}