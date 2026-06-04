import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // GlobalKey dùng để quản lý trạng thái và kích hoạt validate của Form
  final _formKey = GlobalKey<FormState>();

  // Các bộ điều khiển dữ liệu (TextEditingController) để lấy dữ liệu từ các ô nhập
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Các nút FocusNode quản lý hành vi chuyển ô nhập liệu của bàn phím
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  // Các biến trạng thái giao diện UI
  bool _obscurePassword = true; // Ẩn/hiện mật khẩu chính
  bool _obscureConfirmPassword = true; // Ẩn/hiện mật khẩu xác nhận
  bool _isLoading = false; // Trạng thái đợi khi bấm Submit (để làm hiệu ứng xoay tròn UX)

  // Giải phóng bộ nhớ khi widget bị hủy (Quy tắc bắt buộc của sinh viên giỏi)
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  // LAB 7.4: Hàm giả lập kiểm tra Email đã tồn tại bất đồng bộ (Async Validation)
  Future<bool> _isEmailAlreadyTaken(String email) async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập delay mạng 2 giây
    // Nếu sinh viên nhập test@gmail.com thì báo lỗi trùng hệ thống
    if (email.toLowerCase() == 'test@gmail.com') {
      return true;
    }
    return false;
  }

  // Hàm xử lý khi người dùng nhấn nút Đăng ký (Submit Form)
  void _submitForm() async {
    // Tắt bàn phím trước khi xử lý logic
    FocusScope.of(context).unfocus();

    // 1. Kiểm tra Validate cơ bản (Đồng bộ)
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Bật vòng xoay loading
      });

      // 2. Chạy Validate bất đồng bộ (Kiểm tra trùng email)
      bool isTaken = await _isEmailAlreadyTaken(_emailController.text);

      setState(() {
        _isLoading = false; // Tắt vòng xoay loading
      });

      if (isTaken) {
        // Hiện thông báo lỗi nếu trùng email
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: Email "test@gmail.com" is already taken!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Đăng ký thành công rực rỡ
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Success! Account created for ${_nameController.text}'),
              backgroundColor: Colors.green,
            ),
          );
          _formKey.currentState!.reset(); // Reset trắng toàn bộ Form nhập
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // LAB 7.3: Sử dụng GestureDetector bao quanh để khi chạm ngoài màn hình sẽ ẩn bàn phím ngay lập tức (Good UX)
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView( // Chống tràn màn hình (Overflow) khi bàn phím ảo đẩy lên
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey, // Gán key quản lý form
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.person_add_alt_1_rounded, size: 80, color: Colors.deepPurple),
                    const SizedBox(height: 12),
                    const Text(
                      'Join Us Today!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    // -------------------------------------------------
                    // 1. FIELD: FULL NAME
                    // -------------------------------------------------
                    TextFormField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      textInputAction: TextInputAction.next, // Nhấn nút Action trên bàn phím sẽ nhảy sang ô kế
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Full Name is required'; // Báo lỗi trống
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // -------------------------------------------------
                    // 2. FIELD: EMAIL
                    // -------------------------------------------------
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress, // Hiện phím @ chuyên dụng
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'e.g., student@fpt.edu.vn',
                        prefixIcon: const Icon(Icons.mail_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        // Regex kiểm tra định dạng cấu trúc Email chuẩn
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // -------------------------------------------------
                    // 3. FIELD: PASSWORD
                    // -------------------------------------------------
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      obscureText: _obscurePassword, // Biến toggle ẩn hiện ký tự
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmPasswordFocus),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long'; // Yêu cầu tối thiểu 8 ký tự
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least 1 digit'; // Yêu cầu ít nhất 1 chữ số
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // -------------------------------------------------
                    // 4. FIELD: CONFIRM PASSWORD
                    // -------------------------------------------------
                    TextFormField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done, // Nút hành động cuối là Done
                      onFieldSubmitted: (_) => _submitForm(), // Gõ xong enter kích hoạt submit luôn
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock_reset),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match'; // Kiểm tra trùng khớp mật khẩu
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // -------------------------------------------------
                    // BUTTON: SUBMIT SIGNUP FORM
                    // -------------------------------------------------
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm, // Khóa nút khi đang load để tránh nhấn liên tục
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}