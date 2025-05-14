import 'package:flutter/material.dart';
import '../models/contract_model.dart';
import '../theme/theme.dart';

class StudentsListWidget extends StatelessWidget {
  final List<ContractModel> contracts;
  final Function(ContractModel contract) onContractTap;

  const StudentsListWidget({
    Key? key,
    required this.contracts,
    required this.onContractTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context, index) {
        final contract = contracts[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                contract.customerName.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              contract.customerName,
              style: AppTextStyles.coach_detail,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lịch tập: ${contract.schedule.map((s) => '${s.day} (${s.time})').join(', ')}",
                  style: AppTextStyles.normal_nutri,
                ),
                Text(
                  "Thời hạn: ${contract.duration}",
                  style: AppTextStyles.normal_nutri,
                ),
              ],
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.primary,
            ),
            onTap: () {
              onContractTap(contract);
            },
          ),
        );
      },
    );
  }
}