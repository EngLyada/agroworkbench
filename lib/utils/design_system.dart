/*
AGROWORKBENCH DESIGN SYSTEM

This document outlines the complete design system for the AgroWorkbench application,
based on the requirements provided.

COLORS
-------
Primary: #10B981 (Green - Agriculture)
Secondary: #3B82F6 (Blue - Trust)
Warning: #F59E0B (Orange)
Danger: #EF4444 (Red)
Success: #22C55E

TYPOGRAPHY
----------
Font Family: Inter
Weights:
- Regular (400)
- Medium (500)
- Bold (700)

Sizes:
- Mobile base: 14-16px
- Desktop base: 16-18px

Headers:
- Display Large: 36px, Bold
- Display Medium: 32px, Semi-bold
- Display Small: 28px, Semi-bold
- Headline Medium: 24px, Bold
- Headline Small: 20px, Bold

Body:
- Large: 16px, Regular
- Medium: 14px, Regular
- Small: 12px, Regular

COMPONENTS
----------
Cards:
- Border Radius: 8px (rounded-lg)
- Elevation: 2
- Shadow: Default Flutter card shadow

Buttons:
- Border Radius: 8px (rounded-lg)
- Padding: 16px vertical, 24px horizontal
- Text Style: Medium weight, 16px
- Full width on mobile, auto on desktop

Input Fields:
- Border Radius: 8px (rounded-lg)
- Padding: 14px vertical, 16px horizontal
- Border: OutlineInputBorder with grey (0.3 opacity) side
- Focus Border: Primary color with 2px width

APP BAR
-------
- Elevation: 0
- Title: 20px, Bold, White text
- Background: Primary color
- Foreground: White

BOTTOM NAVIGATION
------------------
- Type: Fixed
- Selected Item Color: Primary color
- Unselected Item Color: Grey
- Selected Label: 12px, Medium
- Unselected Label: 12px, Regular

SPACING
-------
- Small: 8px
- Medium: 16px
- Large: 24px
- Extra Large: 32px

BREAKPOINTS
-----------
- Mobile: Default (320px+)
- Tablet: 768px+
- Desktop: 1024px+

ACCESSIBILITY
-------------
- All text elements have sufficient contrast (≥ 4.5:1)
- Touch targets are ≥ 44×44px
- Semantic widgets are used appropriately
- Screen reader labels are provided

ICONS
-----
- Using Material Icons
- Lucide React library mentioned as an option (via Flutter equivalents)

SHADOWS
-------
- Mobile: shadow-sm (small)
- Desktop: shadow-md (medium)

BORDER RADIUS
-------------
- All components: 8px (rounded-lg)
*/

// This file serves as documentation of the design system implemented in the app
// See app_theme.dart for actual implementation