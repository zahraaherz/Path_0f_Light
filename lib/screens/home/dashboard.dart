// Component 5: Navigation Dashboard Widget
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/responsive.dart';

class NavigationDashboardComponent extends StatelessWidget {
  const NavigationDashboardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(vertical: r.spaceSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r.radiusMedium),
          topRight: Radius.circular(r.radiusMedium),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(
            context,
            r,
            l10n,
            icon: Icons.home,
            label: 'Home',
            isActive: true,
            onTap: () {
              // Already on home page
            },
          ),
          _buildNavButton(
            context,
            r,
            l10n,
            icon: Icons.collections_bookmark,
            label: 'Collections',
            isActive: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.collectionsComingSoon)),
              );
            },
          ),
          _buildNavButton(
            context,
            r,
            l10n,
            icon: Icons.menu_book,
            label: 'Books',
            isActive: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.booksComingSoon)),
              );
            },
          ),
          _buildNavButton(
            context,
            r,
            l10n,
            icon: Icons.history_edu,
            label: 'Sira',
            isActive: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.siraComingSoon)),
              );
            },
          ),
          _buildNavButton(
            context,
            r,
            l10n,
            icon: Icons.settings,
            label: 'Settings',
            isActive: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.settingsComingSoon)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context,
      Responsive r,
      AppLocalizations l10n, {
        required IconData icon,
        required String label,
        required bool isActive,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.radiusSmall),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: r.spaceSmall, horizontal: r.paddingSmall),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(r.radiusSmall),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Theme.of(context).primaryColor : Colors.grey,
              size: r.iconMedium,
            ),
            SizedBox(height: r.spaceSmall / 2),
            Text(
              label,
              style: TextStyle(
                fontSize: r.fontSmall,
                color: isActive ? Theme.of(context).primaryColor : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}