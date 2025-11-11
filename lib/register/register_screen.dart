import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

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
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/gamer (1).png'),
                  ),
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/gamer (2).png'),
                  ),
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/gamer (3).png'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
               Text('Avatar', style: TextStyle(color:Appcolors.whitekColor, fontSize: 16)),
              const SizedBox(height: 30),

              // Name
              TextField(
                style: TextStyle(color: Appcolors.whitekColor),
                decoration: inputDecoration(Icons.person_outline, 'Name'),
              ),
              const SizedBox(height: 15),

              // Email
              TextField(
                style: TextStyle(color:Appcolors.whitekColor),
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration(Icons.email_outlined, 'Email'),
              ),
              const SizedBox(height: 15),

              // Password
              TextField(
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
                  onPressed: () {},
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

