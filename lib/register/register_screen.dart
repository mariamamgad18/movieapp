import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/Utils/AppRouteNames.dart';

import '../../Api/Api_Manager.dart';
import '../Ui/login/ShowDialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  InputDecoration inputDecoration(IconData icon, String hintText,
      {bool isPassword = false, VoidCallback? toggleVisibility}) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Appcolors.whitekColor),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white60),
      filled: true,
      fillColor: Appcolors.grayColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(
          hintText == 'Password'
              ? (obscurePassword ? Icons.visibility_off : Icons.visibility)
              : (obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
          color: Appcolors.whitekColor,
        ),
        onPressed: toggleVisibility,
      )
          : null,
    );
  }





  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int avatarId = 1;



  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.blackColor,
      appBar: AppBar(
        backgroundColor: Appcolors.grayColor,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Appcolors.yellowColor),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text('Register', style: TextStyle(color: Appcolors.yellowColor)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  int id = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        avatarId = id;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: avatarId == id ? EdgeInsets.all(4) : EdgeInsets.all(0),
                      decoration: avatarId == id
                          ? BoxDecoration(
                        border: Border.all(color: Appcolors.yellowColor, width: 3),
                        shape: BoxShape.circle,
                      )
                          : null,
                      child: CircleAvatar(
                        radius: id == 2 ? 50 : 30,
                        backgroundImage: AssetImage('assets/images/gamer ($id).png'),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text('Avatar', style: TextStyle(color:Appcolors.whitekColor, fontSize: 16)),
              const SizedBox(height: 30),

              // Name
              TextField(
                controller: nameController,

                style: TextStyle(color: Appcolors.whitekColor),
                decoration: inputDecoration(Icons.person_outline, 'Name'),
              ),
              const SizedBox(height: 15),

              // Email
              TextField(
                controller: emailController,

                style: TextStyle(color:Appcolors.whitekColor),
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration(Icons.email_outlined, 'Email'),
              ),
              const SizedBox(height: 15),

              // Password
              TextField(
                controller: passwordController,
                style: TextStyle(color: Appcolors.whitekColor),
                obscureText: obscurePassword,
                decoration: inputDecoration(
                  Icons.lock_outline,
                  'Password',
                  isPassword: true,
                  toggleVisibility: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password
              TextField(
                controller: confirmPasswordController,
                style: TextStyle(color: Appcolors.whitekColor),
                obscureText: obscureConfirmPassword,
                decoration: inputDecoration(
                  Icons.lock_outline,
                  'Confirm Password',
                  isPassword: true,
                  toggleVisibility: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),

              // Phone Number
              TextField(
                controller: phoneController,

                style: TextStyle(color: Appcolors.whitekColor),
                keyboardType: TextInputType.phone,
                decoration: inputDecoration(Icons.phone_outlined, 'Phone Number'),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.yellowColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),




                  onPressed: () async{
                    final name = nameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text.trim();
                    final phone = phoneController.text.trim();

                    if (
                    name.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty ||
                        phone.isEmpty) {
                      print("Please fill all fields !!");
                      return;
                    }
                    if (password != confirmPassword) {
                      print("Password and Confirm Password do not match!");
                      return;
                    }
                    try {
                      final response = await ApiManager().register(
                        name: name,
                        email: email,
                        password: password,
                        confirmPassword: confirmPassword,
                        phone: phone,
                        avaterId: avatarId,
                      );

                      if (response.statusCode == 200 || response.statusCode == 201) {
                        print("Registration Successful: ${response.data['message']}");
                        MyDialog.show(context: context, title: "Registration Successful", message: "${response.data['message']}", onPressed: () {
                          Navigator.of(context).pushReplacementNamed(Approutenames.Login); // يروح لل لوج ان عشان يتأكد الاكونت بقي موجود فعلا او لا

                        });

                      } else {
                        print("Registration Failed: ${response.data['message']}");

                        MyDialog.show(context: context, title: "Registration Failed", message: "${response.data['message']}", onPressed: () {
                          Navigator.of(context).pop();

                        });
                      }
                    } catch (e) {
                      print("Exception: $e");
                      MyDialog.show(context: context, title: "Exception", message: "$e", onPressed: () {
                        Navigator.of(context).pop();

                      });
                    }
                  }

                  ,
                  child:  Text('Create Account', style: TextStyle(color: Appcolors.blackColor, fontSize: 18)),
                ),



              ),
              const SizedBox(height: 15),

              // Already Have Account ? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have Account ? ', style: TextStyle(color: Appcolors.whitekColor)),
                  GestureDetector(
                    onTap: () {},
                    child: Text('Login',
                        style: TextStyle(color: Appcolors.yellowColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Appcolors.grayColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Appcolors.yellowColor, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/EG.png', width: 28, height: 18, fit: BoxFit.cover),
                    const SizedBox(width: 8),
                    Container(width: 1.5, height: 20, color: Appcolors.yellowColor),
                    const SizedBox(width: 8),
                    Image.asset('assets/images/LR.png', width: 28, height: 18, fit: BoxFit.cover),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

