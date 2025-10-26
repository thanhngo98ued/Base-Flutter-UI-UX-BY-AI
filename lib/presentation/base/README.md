# Base Cubit Pattern - Common Loading & Error Handling

## 📚 **Giới thiệu**

Pattern này tương đương với **Riverpod BaseViewModel** nhưng dành cho **BLoC/Cubit**. Giúp xử lý loading và error một cách tự động và thống nhất.

---

## 🏗️ **Architecture**

```
PageState<UiState>
├── uiState: T           // UI state của màn hình
├── isLoading: bool      // Loading indicator
└── exception: Object?   // Error từ API/Business logic

BaseCubit<UiState> extends Cubit<PageState<UiState>>
├── emitUiState()        // Emit UI state mới
├── emitError()          // Emit error
├── showLoading()        // Show loading overlay
├── hideLoading()        // Hide loading overlay
└── runCatching()        // Wrap async operations với auto loading & error handling

BlocPageBuilder<Cubit, UiState>
├── Auto loading indicator (full screen overlay với Lottie)
├── Auto error dialog (với custom messages)
└── Listen error changes và show dialog
```

---

## ✅ **Key Features**

- ✅ **Auto loading indicator** - Full screen overlay với Lottie animation
- ✅ **Auto error dialog** - Hiển thị dialog với messages phù hợp cho từng loại lỗi
- ✅ **runCatching method** - Wrap async operations với try-catch tự động
- ✅ **Loading count** - Handle multiple concurrent requests
- ✅ **Error detection** - Phát hiện và xử lý `ApiError` (ServerError, NetworkError, HttpError, UnexpectedError)
- ✅ **Clean separation** - `PageState<UiState>` tách biệt loading/error khỏi business state
- ✅ **Simpler than Bloc** - Không cần define Events

---

## 🚀 **Cách sử dụng**

### **1. Define UI State**

```dart
class LoginUiState extends Equatable {
  final String phone;
  final String password;
  final bool isPasswordVisible;
  final UserModel? user;

  const LoginUiState({
    this.phone = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.user,
  });

  LoginUiState copyWith({...}) { ... }

  @override
  List<Object?> get props => [phone, password, isPasswordVisible, user];
}
```

### **2. Define Cubit (extends BaseCubit)**

```dart
class LoginCubit extends BaseCubit<LoginUiState> {
  LoginCubit(this._loginUseCase) : super(const LoginUiState());

  final LoginUseCase _loginUseCase;

  // Sync methods - update UI state directly
  void onPhoneChanged(String phone) {
    emitUiState(uiState.copyWith(phone: phone));
  }

  // Async methods - use runCatching
  Future<void> login() async {
    await runCatching(
      action: () async {
        final user = await _loginUseCase.execute(
          uiState.phone,
          uiState.password,
        );
        emitUiState(uiState.copyWith(user: user));
      },
      // Optional callbacks
      doOnSuccess: () {
        // Navigate, show toast, etc.
      },
      doOnError: (error) {
        // Custom error handling if needed
      },
    );
  }
}
```

### **3. Use in UI (với BlocPageBuilder)**

```dart
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocPageBuilder<LoginCubit, LoginUiState>(
            onPageReady: () {
              // Optional: Initialize data when page ready
            },
            child: const LoginScreen(),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, PageState<LoginUiState>>(
      builder: (context, state) {
        final uiState = state.uiState; // Access UI state
        
        return Column(
          children: [
            TextField(
              onChanged: (value) =>
                context.read<LoginCubit>().onPhoneChanged(value),
            ),
            ElevatedButton(
              onPressed: () => context.read<LoginCubit>().login(),
              child: Text('Login'),
            ),
          ],
        );
      },
    );
  }
}
```

---

## 🎯 **So sánh với pattern cũ**

| Feature | Old (Bloc with Events) | New (BaseCubit) |
|---------|----------------------|-----------------|
| **Define Events** | ✅ Required | ❌ Not needed |
| **Handle Loading** | ⚠️ Manual (emit loading state) | ✅ Auto (runCatching) |
| **Handle Error** | ⚠️ Manual (try-catch in bloc) | ✅ Auto (runCatching) |
| **Show Error Dialog** | ⚠️ Manual (BlocListener in UI) | ✅ Auto (BlocPageBuilder) |
| **Loading Count** | ❌ No | ✅ Yes (multiple requests) |
| **Code Lines** | ~150 lines | ~50 lines |

---

## 📝 **runCatching Options**

```dart
await runCatching(
  action: () async {
    // Your async operation
  },
  handleLoading: true,         // Auto show/hide loading (default: true)
  handleError: true,           // Auto emit error (default: true)
  doOnLoading: () {},          // Callback when loading starts
  doOnSuccess: () {},          // Callback when success
  doOnError: (error) {},       // Callback when error occurs
);
```

---

## 🔧 **Error Handling**

Tự động phát hiện và hiển thị dialog phù hợp:

| Error Type | Dialog Title | Default Message |
|-----------|--------------|-----------------|
| `ServerError` | Lỗi máy chủ | Máy chủ đang gặp sự cố... |
| `NetworkError` | Lỗi kết nối | Không thể kết nối tới máy chủ... |
| `HttpError` | Lỗi HTTP | Đã xảy ra lỗi... |
| `UnexpectedError` | Lỗi không xác định | Đã xảy ra lỗi không xác định |
| Other | Lỗi không xác định | Đã xảy ra lỗi... |

---

## 📂 **Files Structure**

```
lib/presentation/base/
├── base_bloc.dart              # BaseCubit với runCatching
├── page_state.dart             # PageState<UiState>
├── bloc_page_builder.dart      # Widget với auto loading & error
├── app_error_handler.dart      # Mixin để handle errors
└── index.dart                  # Export all
```

---

## 🎉 **Benefits**

1. **Cleaner code** - Ít boilerplate hơn
2. **Consistent error handling** - Tất cả màn hình xử lý error giống nhau
3. **Better UX** - Loading và error được handle một cách thống nhất
4. **Easier to maintain** - Chỉ cần sửa 1 chỗ để thay đổi error handling cho toàn app
5. **Less bugs** - Không quên handle loading/error nữa

---

## 📚 **Đã áp dụng cho:**

- ✅ **LoginCubit** - `/lib/presentation/pages/login/`

