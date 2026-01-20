# i18n Localization

> Đa ngôn ngữ và bản địa hóa

## Patterns

### React (react-intl)
```tsx
import { FormattedMessage } from 'react-intl';

<FormattedMessage id="greeting" defaultMessage="Hello" />
```

### Next.js (next-intl)
```tsx
import { useTranslations } from 'next-intl';

const t = useTranslations('Common');
<p>{t('greeting')}</p>
```

## File Structure

```
locales/
├── en/
│   ├── common.json
│   └── auth.json
├── vi/
│   ├── common.json
│   └── auth.json
└── ja/
    ├── common.json
    └── auth.json
```

## Best Practices

- Extract strings to files
- Use ICU message format
- Handle pluralization
- Date/currency formatting
- RTL support if needed
