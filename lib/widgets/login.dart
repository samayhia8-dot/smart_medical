
import 'package:flutter/material.dart'; 
 
class LoginForm extends StatefulWidget { 
  final bool isPatient; 
 
  const LoginForm({super.key, required this.isPatient}); 
 
  @override 
  State<LoginForm> createState() => _LoginFormState(); 
} 
 
class _LoginFormState extends State<LoginForm> { 
  bool rememberMe = true; 
  bool hidePassword = true; 
 
  final emailController = TextEditingController(); 
  final passwordController = TextEditingController(); 
 
  @override 
  void dispose() { 
    emailController.dispose(); 
    passwordController.dispose(); 
    super.dispose(); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Container( 
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration( 
          gradient: LinearGradient( 
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            colors: [ 
              Color(0xFFFFFFFF), 
              Color(0xFFE3F7FD), 
            ], 
          ), 
        ), 
      
        child: SafeArea( 
          child: SingleChildScrollView( 
            padding: const EdgeInsets.symmetric(horizontal: 32), 
            child: Column( 
              children: [
              SizedBox(
                height: 58 ,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF163B5C),
                      ),
                    ),
                     const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/healix_logo.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Healix',
                            style: TextStyle(
                              color: Color(0xFF163B5C),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                 const SizedBox(height: 40), 
                Text( 
                  widget.isPatient ? 'Patient Login' : 'Doctor Login', 
                  textAlign: TextAlign.center, 
                  style: const TextStyle( 
                    fontSize: 25, 
                     fontWeight: FontWeight.w600,
                    color:Color(0xFF163B5C), 
                  ), 
                ), 
                const SizedBox(height: 8), 
                const Text( 
                  'Welcome back', 
                  style: TextStyle( 
                    fontSize: 15, 
                    color: Color(0xFF58778D),
                  ), 
                ), 
                const SizedBox(height: 2), 
                const Text( 
                  'Please login to your account.', 
                  textAlign: TextAlign.center, 
                  style: TextStyle( 
                    fontSize: 15, 
                    color: Color(0xFF58778D),
                  ), 
                ), 
                const SizedBox(height: 30), 
                TextField( 
                  controller: emailController, 
                  keyboardType: TextInputType.emailAddress, 
                  decoration: InputDecoration( 
                    hintText: 'Email Address', 
                    hintStyle: const TextStyle( 
                      color: Color(0xFF718792), 
                    ), 
                    prefixIcon: const Icon( 
                      Icons.mail_outline, 
                      color: Color(0xFF3289B7), 
                    ), 
                    filled: true, 
                    fillColor: const Color(0xFFF7FCFE), 
                    contentPadding: const EdgeInsets.symmetric( 
                      vertical: 20, 
                    ), 
                    enabledBorder: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(16), 
                      borderSide: const BorderSide( 
                        color: Color(0xFFD2E4EB), 
                      ), 
                    ), 
                    focusedBorder: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(16), 
                      borderSide: const BorderSide( 
                        color: Color(0xFF258AC0), 
                      ), 
                    ), 
                  ), 
                ), 
                const SizedBox(height: 20), 
                TextField( 
                  controller: passwordController, 
                  obscureText: hidePassword, 
                  decoration: InputDecoration( 
                    hintText: 'Password', 
                    hintStyle: const TextStyle( 
                      color: Color(0xFF718792), 
                    ), 
                    prefixIcon: const Icon( 
                      Icons.lock_outline, 
                      color: Color(0xFF3289B7), 
                    ), 
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF718792),
                        ),
                      ),
                    filled: true, 
                    fillColor: const Color(0xFFF7FCFE), 
                    contentPadding: const EdgeInsets.symmetric( 
                      vertical: 20, 
                    ), 
                    enabledBorder: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(16), 
                      borderSide: const BorderSide( 
                        color: Color(0xFFD2E4EB), 
                      ), 
                    ), 
                    focusedBorder: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(16), 
                      borderSide: const BorderSide( 
                        color: Color(0xFF258AC0), 
                      ), 
                    ), 
                  ), 
                ), 
                const SizedBox(height: 4), 
                Row( 
                  children: [ 
                    SizedBox( 
                      width: 24, 
                      height: 40, 
                      child: Checkbox( 
                        value: widget.isPatient ? rememberMe : false, 
                        activeColor: const Color(0xFF22A58C), 
                        side: const BorderSide( 
                          color: Color(0xFFD2E4EB), 
                        ), 
                        onChanged: widget.isPatient 
                            ? (value) { 
                                setState(() { 
                                  rememberMe = value ?? false; 
                                }); 
                              } 
                            : null, 
                      ), 
                    ), 
                    const SizedBox(width: 6), 
                    const Expanded( 
                      child: Text( 
                        'Remember me', 
                        style: TextStyle( 
                          fontSize: 12, 
                          color: Color(0xFF607783), 
                        ), 
                      ), 
                    ), 
                    TextButton( 
                      onPressed: () {}, 
                      child: const Text( 
                        'Forgot Password?', 
                        style: TextStyle( 
                          fontSize: 12, 
                          color: Color(0xFF359F91), 
                        ), 
                      ), 
                    ), 
                  ], 
                ), 
                const SizedBox(height: 22), 
                Container( 
                  width: double.infinity, 
                  height: 48, 
                  decoration: BoxDecoration( 
                    gradient: const LinearGradient( 
                      colors: [ 
                         Color(0xFF078ACB),
                         Color(0xFF00A889),
                      ], 
                    ), 
                    borderRadius: BorderRadius.circular(30), 
                    boxShadow: const [ 
                      BoxShadow( 
                        color: Color(0x2230A99F), 
                        blurRadius: 12, 
                        offset: Offset(0, 5), 
                      ), 
                    ], 
                  ), 
                  child: ElevatedButton( 
                    onPressed: () { 
                      if (emailController.text.trim().isEmpty || 
                          passwordController.text.isEmpty) { 
                        ScaffoldMessenger.of(context).showSnackBar( 
                          const SnackBar( 
                            content: Text( 
                              'Please enter email and password', 
                            ), 
                          ), 
                        ); 
                      } 
                    }, 
                    style: ElevatedButton.styleFrom( 
                      backgroundColor: Colors.transparent, 
                      shadowColor: Colors.transparent, 
                      shape: const StadiumBorder(), 
                    ), 
                    child: const Row( 
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [ 
                        Text( 
                          'Log In', 
                          style: TextStyle( 
                            fontSize: 16, 
                            color: Colors.white, 
                          ), 
                        ), 
                        SizedBox(width: 12), 
                        Icon( 
                          Icons.arrow_forward, 
                          color: Colors.white, 
                          size: 18,
                        ), 
                      ], 
                    ), 
                  ), 
                ), 
                const SizedBox(height: 38), 
                const Row( 
                  children: [ 
                    Expanded( 
                      child: Divider(color: Color(0xFFD2E4EB)), 
                    ), 
                    Padding( 
                      padding: EdgeInsets.symmetric(horizontal: 14), 
                      child: Text( 
                        'or', 
                        style: TextStyle( 
                          fontSize: 15, 
                          color: Color(0xFF607783), 
                        ), 
                      ), 
                    ), 
                    Expanded( 
                      child: Divider(color: Color(0xFFD2E4EB)), 
                    ), 
                  ], 
                ), 
                const SizedBox(height: 20), 
                SizedBox( 
                  width: double.infinity, 
                  height: 58, 
                  child: OutlinedButton( 
                    onPressed: () {}, 
                    style: OutlinedButton.styleFrom( 
                      backgroundColor: Colors.white, 
                      side: const BorderSide( 
                        color: Color(0xFFD2E4EB), 
                      ), 
                      shape: const StadiumBorder(), 
                    ), 
                    child: const Row( 
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [ 
                        Text( 
                          'G', 
                          style: TextStyle( 
                            fontSize: 21, 
                            fontWeight: FontWeight.bold, 
                            color: Color(0xFF5285E8), 
                          ), 
                        ), 
                        SizedBox(width: 16), 
                        Text( 
                          'Continue with Google', 
                          style: TextStyle( 
                            fontSize: 16, 
                            color: Color(0xFF163B5C), 
                          ), 
                        ), 
                      ], 
                    ), 
                  ), 
                ), 
                const SizedBox(height: 22), 
                Wrap( 
                  alignment: WrapAlignment.center, 
                  children: [ 
                    const Text( 
                      "Don't have an account? ", 
                      style: TextStyle( 
                        fontSize: 13, 
                        color: Color(0xFF718792), 
                      ), 
                    ), 
                    GestureDetector( 
                      onTap: () {}, 
                      child: const Text( 
                        'Create Account', 
                        style: TextStyle( 
                          fontSize: 13, 
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF359F91), 
                        ), 
                      ), 
                    ), 
                  ], 
                ), 
                const SizedBox(height: 30), 
             ], 
           ), 
         ), 
      )
      ), 
    ); 
 } 
} 