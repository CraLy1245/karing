# Karing UI Redesign

The redesign is implemented on the `ui-redesign` branch without changing the
production VPN, subscription, DNS, routing, persistence, or server-selection
business logic.

## Completed scope

### Design system

- Shared spacing, radius, motion, breakpoint, and content-width tokens.
- Semantic light and dark color systems through `ThemeExtension`.
- Production Material 3 themes for cards, lists, inputs, buttons, switches,
  dialogs, sheets, menus, tooltips, notifications, and page transitions.
- Karing-owned component wrappers so business pages are not locked to a
  third-party UI package.

### Home and dashboard

- Modern dashboard cards with consistent hierarchy, borders, hover, focus, and
  selection states.
- The old painted convex control is replaced by a responsive connection dock.
- Existing connection callbacks, server selection, widget IDs, drag ordering,
  layout import/export, and saved dashboard configuration remain unchanged.

### Settings and configuration

- Settings groups use centered, width-constrained surfaces on large displays.
- Text, input, switch, navigation, interval, date, and string-picker rows share
  one responsive renderer.
- Mobile actions use bottom sheets; larger displays use compact dialogs.

### Profiles, nodes, DNS, and routing

- Shared data lists gain responsive width, spacing, and dividers.
- Latency, traffic, expiration, warning, and permission states use semantic
  status treatments.
- DNS, routing, system, and advanced configuration screens inherit the new
  settings renderer without duplicating visual code.

### Accessibility and platform behavior

- Interactive targets are at least 44 logical pixels in the new theme.
- Existing semantics, focus nodes, keyboard traversal, TV mode, and platform
  callbacks are preserved.
- Compact and expanded layouts are available in the isolated design preview.

## Preview

```bash
flutter pub get
flutter run -t lib/design_preview_main.dart
```

## Validation

The branch workflow:

1. resolves the public project dependencies;
2. creates a minimal local placeholder for the separately maintained sibling
   `vpn_service` package;
3. formats all migrated UI source with the Dart formatter;
4. runs static analysis on the independent design and shared layout modules;
5. publishes the formatted source as a short-lived workflow artifact.

The workflow validates the redesign code that is independent from the real VPN
service. A full application build still requires the actual sibling
`../vpn-service` source used by Karing's normal development environment.

## Dependency decision

No new UI library was added. Material 3 plus Karing-owned components currently
covers the required interaction patterns with lower maintenance and upgrade
risk. A third-party component can still be introduced later behind the Karing
component layer when it provides a demonstrated benefit that cannot be achieved
reliably with the existing stack.
