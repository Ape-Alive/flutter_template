import 'dart:async';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  bool _isSendingCode = false;
  bool _isPhoneValid = false;
  int _countdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _validatePhone() {
    // 验证手机号格式
    final phone = _phoneController.text;
    final isValid = RegExp(r"^1[3-9]\d{9}$").hasMatch(phone);
    setState(() {
      _isPhoneValid = isValid;
    });
  }

  void _startCountdown() {
    setState(() {
      _countdown = 60;
      _isSendingCode = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        timer.cancel();
        setState(() {
          _isSendingCode = false;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void _sendCode() {
    if (_isPhoneValid) {
      _startCountdown();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('验证码已发送')),
      );
    }
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登录成功')),
      );
    }
  }

  void _navigateToRegister() {
    // 模拟跳转到注册页面逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('跳转到注册页面')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  "欢迎登录慧为智能生活",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "手机号验证码直接登录，无需注册",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // 手机号输入框
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "手机号",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffix: GestureDetector(
                          onTap: (_isSendingCode || !_isPhoneValid) ? null : _sendCode,
                          child: Text(
                            _isSendingCode
                                ? "$_countdown 秒后重发"
                                : (_isPhoneValid ? "发送验证码" : "输入手机号"),
                            style: TextStyle(
                              color: (_isSendingCode || !_isPhoneValid)
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "请输入手机号";
                        }
                        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
                          return "请输入有效的手机号";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // 验证码输入框
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "输入验证码",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "请输入验证码";
                        }
                        if (value.length != 6) {
                          return "验证码格式错误";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // 登录按钮
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "登录",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 注册按钮
                    Center(
                      child: TextButton(
                        onPressed: _navigateToRegister,
                        child: const Text(
                          "还没有账号？点击注册",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text("其他账号登录方式", style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/wechat.png',
                      width: 48,
                      height: 48,
                    ),
                    onPressed: () {
                      // 微信登录逻辑
                    },
                  ),
                  const SizedBox(width: 32),
                  IconButton(
                    icon: Image.asset(
                      'assets/apple.png',
                      width: 48,
                      height: 48,
                    ),
                    onPressed: () {
                      // 苹果登录逻辑
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {
                      // 隐私协议逻辑
                    },
                  ),
                  const Text("我已阅读并同意《个人隐私法律服务》"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
