import 'package:flutter/material.dart';
import '../../../models/contract_model.dart';
import '../../../theme/theme.dart';

class MyCoachScreen extends StatelessWidget {
  final List<ContractModel> contracts;

  const MyCoachScreen({Key? key, required this.contracts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
       
      ),
      child: contracts.isEmpty
          ? const Center(
              child: Text(
                "Bạn chưa có huấn luyện viên nào.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  final contract = contracts[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          (contract.coachName ?? "U")[0], // Lấy chữ cái đầu tiên của tên huấn luyện viên
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      title: Text(
                        contract.coachName ?? "Không rõ tên",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            "Thời gian: ${contract.duration ?? 'Không rõ'}",
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          Text(
                            "Học phí: ${contract.fee != null ? '${contract.fee!.toStringAsFixed(2)} VNĐ' : 'Không rõ'}",
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          if (contract.schedule != null && contract.schedule!.isNotEmpty)
                            Text(
                              "Lịch tập: ${contract.schedule.map((s) => '${s.day} (${s.time})').join(', ')}",
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.primary,
                      ),
                      onTap: () {
                        // Xử lý khi nhấn vào huấn luyện viên (ví dụ: điều hướng đến chi tiết huấn luyện viên)
                        debugPrint("Đã nhấn vào huấn luyện viên: ${contract.coachName}");
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}