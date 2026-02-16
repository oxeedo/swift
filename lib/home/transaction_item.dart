import 'package:flutter/material.dart';
import '../theme.dart';

// Transaction data model
class Transaction {
  final String name;
  final String amount;
  final String time;
  final bool isDebit;
  final IconData icon;
  final Color iconColor;

  Transaction({
    required this.name,
    required this.amount,
    required this.time,
    required this.isDebit,
    required this.icon,
    required this.iconColor,
  });
}

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Transaction icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: transaction.iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            transaction.icon,
            color: transaction.iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        // Transaction details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                transaction.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        // Transaction amount
        Text(
          '${transaction.isDebit ? '-' : '+'}${transaction.amount}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: transaction.isDebit ? Colors.red : AppTheme.primaryBlue,
          ),
        ),
      ],
    );
  }
}
