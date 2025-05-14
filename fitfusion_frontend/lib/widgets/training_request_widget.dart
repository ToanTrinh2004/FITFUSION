import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/training_request_model.dart';
import '../theme/theme.dart';

class TrainingRequestsWidget extends StatelessWidget {
  final List<TrainingRequest> trainingRequests;
  final VoidCallback onRefresh;
  final Function(TrainingRequest request, bool accept) onRequestAction;

  const TrainingRequestsWidget({
    Key? key,
    required this.trainingRequests,
    required this.onRequestAction,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (trainingRequests.isEmpty) {
      return const Center(
        child: Text(
          "Không có yêu cầu thuê mới",
          style: AppTextStyles.title1,
        ),
      );
    }

    return ListView.builder(
      itemCount: trainingRequests.length,
      itemBuilder: (context, index) {
        final request = trainingRequests[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Khách hàng: ${request.customerName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.school,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Huấn luyện viên: ${request.coachName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildRequestInfoRow("Lịch tập", request.schedule.map((s) => "${s.day} (${s.time})").join(' | ')),
                _buildRequestInfoRow("Thời hạn", request.duration),
                _buildRequestInfoRow("Học phí", "${NumberFormat('#,###', 'vi_VN').format(request.fee)} VNĐ"),
                _buildRequestInfoRow("Trạng thái", _getStatusLabel(request.status)),
                _buildRequestInfoRow("Ngày tạo", DateFormat('dd/MM/yyyy HH:mm').format(request.createdAt)),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async => onRequestAction(request, false), // Reject
                      child: const Text("Từ chối"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async => onRequestAction(request, true), // Accept
                      child: const Text("Chấp nhận"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return "Đang chờ xử lý";
      case 'accepted':
        return "Đã chấp nhận";
      case 'rejected':
        return "Đã từ chối";
      default:
        return "Không xác định";
    }
  }
}