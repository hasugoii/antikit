# AntiKit Community Library

This directory contains community-contributed packages for AntiKit.

## Structure

```
library/
├── workflows/     # Custom workflow definitions
├── skills/        # Specialized skill modules
├── agents/        # Agent personality configurations
└── rules/         # Coding rules and conventions
```

## Package Format

Each package has its own folder with:
- `manifest.json` - Package metadata
- `translations/` - Language-specific content
  - `vi.md` - Vietnamese
  - `en.md` - English
  - `ja.md` - Japanese
  - `zh.md` - Chinese

## Contributing

Use `/ak-contribute` to submit your local customizations to the library.

```
/ak-contribute workflow my-workflow
```

Your contribution will be automatically:
1. Validated for format
2. Translated to all supported languages
3. Published to the library

## Browsing

Use `/ak-browse` to explore available packages:

```
/ak-browse skills --tag=react
/ak-browse --all-languages
```

## Updating

Use `/ak-update` to selectively install packages:

```
/ak-update
```
