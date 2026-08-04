# Karing UI Redesign — Phase 1

This phase introduces an isolated design preview without changing the production
VPN flow, existing home widget IDs, persisted settings, or navigation.

## What is included

- A small design-token layer for spacing, radius, motion, and breakpoints.
- A `ThemeExtension` for semantic colors used by network status UI.
- Shared preview components:
  - surface card
  - status badge
  - metric
  - section heading
  - quick action tile
- A responsive home-screen concept for compact and expanded layouts.
- A component gallery with light and dark mode switching.

## Run the preview

```bash
flutter pub get
flutter run -t lib/design_preview_main.dart
```

Select a desktop or mobile target to verify responsive behavior.

## Deliberate constraints

- No production screen is replaced in this phase.
- No VPN, subscription, DNS, routing, or persistence logic is called.
- No third-party UI dependency is added yet.
- Existing design code remains untouched, so this commit can be reverted cleanly.

After the visual direction is approved, the next phase can wrap any selected
third-party widgets behind Karing-owned components. This avoids binding business
screens directly to a library that may later change or become unmaintained.
