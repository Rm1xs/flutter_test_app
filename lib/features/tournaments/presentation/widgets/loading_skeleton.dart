import 'package:flutter/material.dart';
import 'tournament_table.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  static const _rowCount = 5;
  static const _rowHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TournamentTable.tablePadding,
      margin: TournamentTable.tableMargin,
      decoration: BoxDecoration(
        borderRadius: TournamentTable.borderRadius,
        color: Colors.white,
        boxShadow: TournamentTable.shadow,
      ),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[600]!,
            highlightColor: Colors.grey[400]!,
            child: Container(
              height: _rowHeight,
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),
          ),
          ...List.generate(_rowCount, (index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: _rowHeight,
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.grey[100] : Colors.white,
                  border: Border(),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildSkeletonCell()),
                    Expanded(flex: 3, child: _buildSkeletonDateCells()),
                    Expanded(flex: 1, child: _buildSkeletonCell()),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  BorderSide customBorderSide() =>
      const BorderSide(color: Colors.grey, width: 0.5);

  Widget _buildSkeletonCell() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Container(height: 20, color: Colors.white),
    );
  }

  Widget _buildSkeletonDateCells() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(child: Container(height: 20, color: Colors.white)),
          const SizedBox(width: 8),
          Expanded(child: Container(height: 20, color: Colors.white)),
        ],
      ),
    );
  }
}
