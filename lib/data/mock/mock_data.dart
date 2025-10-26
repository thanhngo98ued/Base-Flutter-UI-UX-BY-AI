import 'package:base/domain/model/user_model.dart';
import 'package:base/domain/model/service_model.dart';
import 'package:base/domain/model/job_model.dart';
import 'package:base/domain/model/chat_model.dart';
import 'package:base/domain/model/notification_model.dart';
import 'package:base/presentation/pages/price_table/pages/price_table.screen.dart';

/// Mock data cho toàn bộ app
class MockData {
  MockData._();

  // Current User - Default to customer (mock data tạm)
  static const currentUser = UserModel(
    userId: 1,
    phoneNumber: '0901234567',
    name: 'Nguyễn Văn A',
    role: UserRole.customer,
    verifyOPT: 1,
    accessToken: 'mock_access_token',
    refreshToken: 'mock_refresh_token',
  );

  // Rule User (0796803945)
  static const ruleUser = UserModel(
    userId: 2,
    phoneNumber: '0796803945',
    name: 'Rule User',
    role: UserRole.customer,
    verifyOPT: 1,
    accessToken: 'mock_access_token',
    refreshToken: 'mock_refresh_token',
  );

  // Rule Worker (0796803946)
  static const ruleWorker = UserModel(
    userId: 3,
    phoneNumber: '0796803946',
    name: 'Rule Worker',
    role: UserRole.worker,
    verifyOPT: 1,
    accessToken: 'mock_access_token',
    refreshToken: 'mock_refresh_token',
  );

  // Get user by phone number
  static UserModel getUserByPhone(String phone) {
    switch (phone) {
      case '0901234567':
        return currentUser;
      case '0796803945':
        return ruleUser;
      case '0796803946':
        return ruleWorker;
      default:
        return currentUser; // Default fallback
    }
  }

  // Workers
  static final workers = [
    WorkerModel(
      id: 'w1',
      name: 'Trần Văn Thợ',
      phone: '0912345678',
      avatar: 'https://i.pravatar.cc/150?u=worker1',
      rating: 4.8,
      jobsCompleted: 156,
      skills: const ['Điện lạnh', 'Sửa chữa điện'],
      hourlyRate: 150000,
      isOnline: true,
      distance: 0.8,
      location: const LocationModel(lat: 10.7779, lng: 106.7019),
    ),
    WorkerModel(
      id: 'w2',
      name: 'Lê Minh Công',
      phone: '0923456789',
      avatar: 'https://i.pravatar.cc/150?u=worker2',
      rating: 4.9,
      jobsCompleted: 203,
      skills: const ['Thợ sơn', 'Sửa chữa nhà'],
      hourlyRate: 120000,
      isOnline: true,
      distance: 1.2,
      location: const LocationModel(lat: 10.7759, lng: 106.6999),
    ),
    WorkerModel(
      id: 'w3',
      name: 'Phạm Văn Nước',
      phone: '0934567890',
      avatar: 'https://i.pravatar.cc/150?u=worker3',
      rating: 4.7,
      jobsCompleted: 178,
      skills: const ['Thợ nước', 'Sửa ống nước'],
      hourlyRate: 130000,
      isOnline: false,
      distance: 1.5,
      location: const LocationModel(lat: 10.7789, lng: 106.7029),
    ),
    WorkerModel(
      id: 'w4',
      name: 'Hoàng Văn Điện',
      phone: '0945678901',
      avatar: 'https://i.pravatar.cc/150?u=worker4',
      rating: 4.6,
      jobsCompleted: 142,
      skills: const ['Thợ điện', 'Lắp đặt điện'],
      hourlyRate: 140000,
      isOnline: true,
      distance: 1.9,
      location: const LocationModel(lat: 10.7749, lng: 106.6989),
    ),
    WorkerModel(
      id: 'w5',
      name: 'Nguyễn Thị Hàn',
      phone: '0956789012',
      avatar: 'https://i.pravatar.cc/150?u=worker5',
      rating: 4.9,
      jobsCompleted: 234,
      skills: const ['Thợ hàn', 'Hàn inox'],
      hourlyRate: 160000,
      isOnline: true,
      distance: 0.5,
      location: const LocationModel(lat: 10.7779, lng: 106.7019),
    ),
  ];

  // Services - 20 services
  static const services = [
    ServiceModel(
      id: 's1',
      name: 'Thợ điện',
      icon: 'Zap',
      category: 'Điện',
      image: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e',
    ),
    ServiceModel(
      id: 's2',
      name: 'Thợ nước',
      icon: 'Droplet',
      category: 'Nước',
      image: 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39',
    ),
    ServiceModel(
      id: 's3',
      name: 'Điện lạnh',
      icon: 'Wind',
      category: 'Điện lạnh',
    ),
    ServiceModel(
      id: 's4',
      name: 'Thợ sơn',
      icon: 'Paintbrush',
      category: 'Sơn',
    ),
    ServiceModel(
      id: 's5',
      name: 'Sửa nhà',
      icon: 'Home',
      category: 'Nhà',
      image: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd',
    ),
    ServiceModel(id: 's6', name: 'Thợ mộc', icon: 'Hammer', category: 'Mộc'),
    ServiceModel(id: 's7', name: 'Thợ hàn', icon: 'Flame', category: 'Hàn'),
    ServiceModel(
      id: 's8',
      name: 'Vệ sinh',
      icon: 'Sparkles',
      category: 'Vệ sinh',
    ),
    ServiceModel(
      id: 's9',
      name: 'Thông cống',
      icon: 'Droplet',
      category: 'Nước',
    ),
    ServiceModel(
      id: 's10',
      name: 'Lắp đặt điện',
      icon: 'Zap',
      category: 'Điện',
    ),
    ServiceModel(id: 's11', name: 'Sửa khóa', icon: 'Build', category: 'Khóa'),
    ServiceModel(id: 's12', name: 'Sửa cửa', icon: 'Home', category: 'Nhà'),
    ServiceModel(
      id: 's13',
      name: 'Lắp rèm',
      icon: 'Home',
      category: 'Nội thất',
    ),
    ServiceModel(
      id: 's14',
      name: 'Sửa tivi',
      icon: 'Build',
      category: 'Điện tử',
    ),
    ServiceModel(
      id: 's15',
      name: 'Lắp camera',
      icon: 'Build',
      category: 'An ninh',
    ),
    ServiceModel(
      id: 's16',
      name: 'Sửa máy giặt',
      icon: 'Build',
      category: 'Điện tử',
    ),
    ServiceModel(
      id: 's17',
      name: 'Lắp tủ bếp',
      icon: 'Hammer',
      category: 'Nội thất',
    ),
    ServiceModel(
      id: 's18',
      name: 'Sơn xe',
      icon: 'Paintbrush',
      category: 'Sơn',
    ),
    ServiceModel(id: 's19', name: 'Lắp đèn', icon: 'Zap', category: 'Điện'),
    ServiceModel(
      id: 's20',
      name: 'Sửa máy lạnh',
      icon: 'Wind',
      category: 'Điện lạnh',
    ),
  ];

  // Banners
  static const banners = [
    BannerModel(
      id: 'b1',
      title: 'Tìm thợ nhanh chóng',
      image: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952',
    ),
    BannerModel(
      id: 'b2',
      title: 'Ưu đãi đặc biệt',
      image: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd',
    ),
    BannerModel(
      id: 'b3',
      title: 'Thợ chuyên nghiệp',
      image: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e',
    ),
  ];

  // Jobs
  static final jobs = [
    JobModel(
      id: 'j1',
      title: 'Sửa điều hòa không lạnh',
      description:
          'Điều hòa tại phòng khách không lạnh, cần thợ kiểm tra và sửa chữa',
      address: '123 Nguyễn Huệ, Quận 1, TP.HCM',
      category: 'Điện lạnh',
      customerId: '1',
      customerName: 'Nguyễn Văn A',
      workerId: 'w1',
      workerName: 'Trần Văn Thợ',
      status: JobStatus.completed,
      price: 300000,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      completedAt: DateTime.now().subtract(const Duration(days: 5)),
      location: const LocationModel(lat: 10.7769, lng: 106.7009),
    ),
    JobModel(
      id: 'j2',
      title: 'Thay ống nước bị rò rỉ',
      description: 'Ống nước trong nhà vệ sinh bị rò rỉ, cần thay mới',
      address: '123 Nguyễn Huệ, Quận 1, TP.HCM',
      category: 'Thợ nước',
      customerId: '1',
      customerName: 'Nguyễn Văn A',
      workerId: 'w3',
      workerName: 'Phạm Văn Nước',
      status: JobStatus.inProgress,
      price: 250000,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      location: const LocationModel(lat: 10.7769, lng: 106.7009),
    ),
    JobModel(
      id: 'j3',
      title: 'Lắp đặt quạt trần',
      description: 'Cần thợ lắp đặt 2 quạt trần tại phòng ngủ',
      address: '456 Lê Lợi, Quận 3, TP.HCM',
      category: 'Thợ điện',
      customerId: '1',
      customerName: 'Nguyễn Văn A',
      status: JobStatus.findingWorker,
      createdAt: DateTime.now(),
      location: const LocationModel(lat: 10.7769, lng: 106.7009),
    ),
    JobModel(
      id: 'j4',
      title: 'Sơn lại tường phòng khách',
      description: 'Cần sơn lại tường phòng khách diện tích 30m2',
      address: '789 Trần Hưng Đạo, Quận 5, TP.HCM',
      category: 'Thợ sơn',
      customerId: '1',
      customerName: 'Nguyễn Văn A',
      workerId: 'w2',
      workerName: 'Lê Minh Công',
      status: JobStatus.waitingConfirmation,
      price: 1500000,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      location: const LocationModel(lat: 10.7769, lng: 106.7009),
    ),
    JobModel(
      id: 'j5',
      title: 'Sửa chữa cửa gỗ',
      description: 'Cửa phòng ngủ bị lỏng bản lề, cần sửa chữa',
      address: '321 Võ Văn Tần, Quận 3, TP.HCM',
      category: 'Thợ mộc',
      customerId: '1',
      customerName: 'Nguyễn Văn A',
      status: JobStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      location: const LocationModel(lat: 10.7769, lng: 106.7009),
    ),
    JobModel(
      id: 'j6',
      title: 'Sửa chữa máy giặt',
      description: 'Máy giặt không hoạt động, cần thợ kiểm tra',
      address: '555 Nguyễn Trãi, Quận 5, TP.HCM',
      category: 'Điện tử',
      customerId: '1',
      customerName: 'Nguyễn Văn A',
      status: JobStatus.rejected,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      location: const LocationModel(lat: 10.7769, lng: 106.7009),
    ),
  ];

  // Chats - Dynamic based on current user  
  // TODO: Fix participants type mismatch - need to convert WorkerModel to UserModel
  static List<ChatModel> get chats => []; // generateChats(currentUser);

  /*
  static List<ChatModel> generateChats(UserModel user) => [
    ChatModel(
      id: 'c1',
      participants: [user, workers[0]],
      lastMessage: ChatMessageModel(
        id: 'm1',
        chatId: 'c1',
        senderId: 'w1',
        senderName: 'Trần Văn Thợ',
        senderAvatar: 'https://i.pravatar.cc/150?u=worker1',
        message: 'Tôi sẽ đến trong 15 phút nữa',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        read: false,
      ),
      unreadCount: 2,
      updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatModel(
      id: 'c2',
      participants: [user, workers[1]],
      lastMessage: ChatMessageModel(
        id: 'm2',
        chatId: 'c2',
        senderId: '1',
        senderName: 'Nguyễn Văn A',
        senderAvatar: 'https://i.pravatar.cc/150?u=user1',
        message: 'Cảm ơn anh nhiều!',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        read: true,
      ),
      unreadCount: 0,
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatModel(
      id: 'c3',
      participants: [user, workers[2]],
      lastMessage: ChatMessageModel(
        id: 'm3',
        chatId: 'c3',
        senderId: 'w3',
        senderName: 'Phạm Văn Nước',
        senderAvatar: 'https://i.pravatar.cc/150?u=worker3',
        message: 'Tôi đang trên đường đến',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        read: false,
      ),
      unreadCount: 1,
      updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatModel(
      id: 'c4',
      participants: [user, workers[3]],
      lastMessage: ChatMessageModel(
        id: 'm4',
        chatId: 'c4',
        senderId: '1',
        senderName: 'Nguyễn Văn A',
        message: 'Bao giờ anh có thể đến?',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        read: true,
      ),
      unreadCount: 0,
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
  */

  // Chat Messages for detail
  static final chatMessages = {
    'c1': [
      ChatMessageModel(
        id: 'm1',
        chatId: 'c1',
        senderId: '1',
        senderName: 'Nguyễn Văn A',
        senderAvatar: 'https://i.pravatar.cc/150?u=user1',
        message: 'Xin chào, anh có thể đến sửa điều hòa không?',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        read: true,
      ),
      ChatMessageModel(
        id: 'm2',
        chatId: 'c1',
        senderId: 'w1',
        senderName: 'Trần Văn Thợ',
        senderAvatar: 'https://i.pravatar.cc/150?u=worker1',
        message: 'Dạ được ạ, anh ở đâu ạ?',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
        read: true,
      ),
      ChatMessageModel(
        id: 'm3',
        chatId: 'c1',
        senderId: '1',
        senderName: 'Nguyễn Văn A',
        senderAvatar: 'https://i.pravatar.cc/150?u=user1',
        message: 'Tôi ở 123 Nguyễn Huệ, Quận 1',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
        read: true,
      ),
      ChatMessageModel(
        id: 'm4',
        chatId: 'c1',
        senderId: 'w1',
        senderName: 'Trần Văn Thợ',
        senderAvatar: 'https://i.pravatar.cc/150?u=worker1',
        message: 'Tôi sẽ đến trong 15 phút nữa',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        read: false,
      ),
    ],
  };

  // Notifications
  static final notifications = [
    NotificationModel(
      id: 'n1',
      userId: '1',
      type: NotificationType.newJob,
      title: 'Công việc mới',
      message: 'Có 3 thợ trong khu vực của bạn sẵn sàng nhận việc',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      read: false,
    ),
    NotificationModel(
      id: 'n2',
      userId: '1',
      type: NotificationType.jobAccepted,
      title: 'Công việc được chấp nhận',
      message: 'Trần Văn Thợ đã chấp nhận công việc của bạn',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      read: false,
    ),
    NotificationModel(
      id: 'n4',
      userId: '1',
      type: NotificationType.adminAnnouncement,
      title: 'Thông báo từ Admin',
      message: 'Chúng tôi vừa khai trương chi nhánh mới tại Quận 7!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      read: true,
    ),
    NotificationModel(
      id: 'n5',
      userId: '1',
      type: NotificationType.topUp,
      title: 'Nạp tiền thành công',
      message: 'Bạn đã nạp thành công 500.000đ vào tài khoản',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      read: true,
    ),
    NotificationModel(
      id: 'n6',
      userId: '1',
      type: NotificationType.systemUpdate,
      title: 'Cập nhật hệ thống',
      message: 'Phiên bản mới 2.0 đã có sẵn với nhiều tính năng hấp dẫn',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      read: true,
    ),
    NotificationModel(
      id: 'n7',
      userId: '1',
      type: NotificationType.newBranch,
      title: 'Chi nhánh mới',
      message: 'Tìm Thợ mở rộng dịch vụ tại Bình Dương',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      read: true,
    ),
  ];

  // Price Table
  static const priceTable = [
    PriceTableItem(
      service: 'Sửa điều hòa',
      minPrice: 200000,
      maxPrice: 500000,
      unit: 'lần',
    ),
    PriceTableItem(
      service: 'Sửa ống nước',
      minPrice: 150000,
      maxPrice: 300000,
      unit: 'lần',
    ),
    PriceTableItem(
      service: 'Lắp đặt điện',
      minPrice: 100000,
      maxPrice: 200000,
      unit: 'giờ',
    ),
    PriceTableItem(
      service: 'Sơn nhà',
      minPrice: 80000,
      maxPrice: 150000,
      unit: 'm²',
    ),
    PriceTableItem(
      service: 'Sửa chữa nhà',
      minPrice: 120000,
      maxPrice: 250000,
      unit: 'giờ',
    ),
    PriceTableItem(
      service: 'Làm đồ gỗ',
      minPrice: 200000,
      maxPrice: 500000,
      unit: 'sản phẩm',
    ),
    PriceTableItem(
      service: 'Hàn inox',
      minPrice: 150000,
      maxPrice: 350000,
      unit: 'giờ',
    ),
    PriceTableItem(
      service: 'Vệ sinh máy lạnh',
      minPrice: 100000,
      maxPrice: 200000,
      unit: 'máy',
    ),
  ];
}
