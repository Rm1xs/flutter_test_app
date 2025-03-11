import 'package:flutter/material.dart';
import 'error_widget.dart';
import 'loading_skeleton.dart';
import 'package:get/get.dart';

import '../controllers/tournament_controller.dart';

class TournamentTable extends GetView<TournamentController> {
  const TournamentTable({super.key});

  static const tablePadding = EdgeInsets.all(8.0);
  static const tableMargin = EdgeInsets.symmetric(horizontal: 16.0);
  static const searchPadding = EdgeInsets.all(12.0);
  static const borderRadius = BorderRadius.all(Radius.circular(12));
  static const shadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: 2,
      offset: Offset(0, 5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: searchPadding,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.blueGrey[700]),
                    hintText: 'Пошук турніру...',
                    hintStyle: TextStyle(color: Colors.blueGrey[400]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  style: theme.textTheme.bodyMedium,
                  onChanged: controller.filterTournaments,
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.blueGrey[700]),
                onPressed: controller.fetchTournaments,
                tooltip: 'Оновити',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) return const LoadingSkeleton();
            if (controller.errorMessage.value.isNotEmpty) {
              return ErrorTableWidget(
                message: controller.errorMessage.value,
                onRetry: controller.fetchTournaments,
              );
            }
            if (controller.filteredTournaments.isEmpty) {
              return Center(
                child: Text(
                  'Нічого не знайдено',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              );
            }

            return Container(
              padding: tablePadding,
              margin: tableMargin,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.white,
                boxShadow: shadow,
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: SingleChildScrollView(
                  child: Table(
                    border:
                        TableBorder.all(color: Colors.grey[300]!, width: 0.5),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(1.5),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.blueGrey[900]),
                        children: [
                          _buildHeaderCell(context, 'Турнір', sortable: false),
                          GestureDetector(
                            onTap: () {
                              controller.sortByDate();
                            },
                            child: _buildHeaderCell(context, 'Дата початку'),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.sortByDate();
                            },
                            child: _buildHeaderCell(context, 'Дата завершення'),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.sortByTeamsCount();
                            },
                            child: _buildHeaderCell(context, 'Команди'),
                          ),
                        ],
                      ),
                      ...controller.filteredTournaments.map(
                        (tournament) => TableRow(
                          decoration: BoxDecoration(
                            color: controller.filteredTournaments
                                    .indexOf(tournament)
                                    .isEven
                                ? Colors.grey[100]
                                : Colors.white,
                          ),
                          children: [
                            _buildDataCell(context, tournament.name,
                                isBold: true),
                            _buildDataCell(context, tournament.startDate),
                            _buildDataCell(context, tournament.endDate),
                            _buildDataCell(
                                context, tournament.teams.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(
    BuildContext context,
    String text, {
    bool sortable = true,
    bool isAscending = true,
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (sortable) ...[
            const SizedBox(width: 4),
            Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDataCell(BuildContext context, String text,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          color: Colors.grey[800],
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
