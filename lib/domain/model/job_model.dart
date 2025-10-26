import 'package:equatable/equatable.dart';
import 'package:base/domain/model/user_model.dart';

import 'service_model.dart';

enum JobStatus {
  findingWorker,      // Đang tìm thợ
  waitingConfirmation, // Đang chờ xác nhận
  inProgress,         // Đã nhận việc
  completed,          // Đã hoàn thành
  cancelled,         // Đã huỷ bỏ
  rejected,          // Đã từ chối
}

class JobModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String address;
  final String category;
  final String customerId;
  final String customerName;
  final String? workerId;
  final String? workerName;
  final JobStatus status;
  final double? price;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? videoDescription;
  final LocationModel location;

  const JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.category,
    required this.customerId,
    required this.customerName,
    required this.status,
    required this.createdAt,
    required this.location,
    this.workerId,
    this.workerName,
    this.price,
    this.completedAt,
    this.videoDescription,
  });

  JobModel copyWith({
    String? id,
    String? title,
    String? description,
    String? address,
    String? category,
    String? customerId,
    String? customerName,
    String? workerId,
    String? workerName,
    JobStatus? status,
    double? price,
    DateTime? createdAt,
    DateTime? completedAt,
    String? videoDescription,
    LocationModel? location,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      category: category ?? this.category,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      workerId: workerId ?? this.workerId,
      workerName: workerName ?? this.workerName,
      status: status ?? this.status,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      videoDescription: videoDescription ?? this.videoDescription,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        address,
        category,
        customerId,
        customerName,
        workerId,
        workerName,
        status,
        price,
        createdAt,
        completedAt,
        videoDescription,
        location,
      ];
}

