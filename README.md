# 🎁 Gift Guides Site

29-page affiliate gift guide site. Static HTML, deployed on Vercel.

## Structure

```
deploy/
├── public/                     ← Vercel root directory
│   ├── index.html              ← Homepage hub
│   ├── sitemap.xml
│   ├── robots.txt
│   ├── privacy/index.html
│   ├── best-gifts-for-dads/index.html
│   ├── best-gifts-for-moms/index.html
│   ├── best-fathers-day-gifts/index.html
│   ├── best-mothers-day-gifts/index.html
│   ├── ... (29 pages total)
└── vercel.json                 ← Clean URLs + headers config
```

## Deploy

### First time
```bash
# Edit DOMAIN, GITHUB_USER in deploy.sh first
chmod +x deploy.sh
./deploy.sh
```

Requires GitHub CLI (`gh`) — install: https://cli.github.com

### Vercel setup (after pushing)
1. vercel.com → Add New Project
2. Import your GitHub repo
3. **Root Directory → set to `public`**
4. Deploy
5. Add custom domain under Project → Domains

## Adding affiliate URLs

Each page has a `PRODUCTS` array at the bottom of its `<script>` block:

```js
const PRODUCTS = [
  {
    title: 'Premium Coffee Subscription',
    url: '#',        // ← paste full affiliate URL here
    asin: '',        // ← OR paste bare ASIN (e.g. B08XYZ1234)
    ...
  }
]
```

Set either `url` OR `asin` — not both. ASIN auto-builds the link with your tag.

Your Associates tag (`ericcoste-20`) is already set at the top of every page.

## Updating domain

If you change domains, run:
```bash
find public -name "*.html" -exec sed -i 's|olddomain.com|newdomain.com|g' {} \;
sed -i 's|olddomain.com|newdomain.com|g' public/sitemap.xml public/robots.txt
```

## PAAPI migration

When Amazon PAAPI access is approved:
1. Set up a Railway Express endpoint that calls PAAPI and returns `{asin, title, price, image, url}`
2. In each page, replace `renderGrid(PRODUCTS)` with a fetch to your endpoint
3. The JSON config structure is already compatible — just map API fields to `PRODUCTS` shape

## Pages

### Evergreen
- `/best-gifts-for-dads` — Best Gifts for Dad
- `/best-gifts-for-moms` — Best Gifts for Mom

### Father's Day cluster
- `/best-fathers-day-gifts`
- `/best-gifts-for-dad-under-50`
- `/best-fathers-day-gifts-under-50`
- `/last-minute-fathers-day-gifts`
- `/last-minute-fathers-day-gifts-under-50`
- `/last-minute-gifts-for-dad`
- `/last-minute-gifts-for-dad-under-50`

### Mother's Day cluster
- `/best-mothers-day-gifts`
- `/best-gifts-for-mom-under-50`
- `/last-minute-mothers-day-gifts`
- `/last-minute-gifts-for-mom`
- `/last-minute-gifts-for-mom-under-50`

### Christmas cluster
- `/christmas-gifts-for-dad`
- `/christmas-gifts-for-mom`
- `/christmas-gifts-for-grandpa`
- `/christmas-gifts-for-grandma`
- `/christmas-gifts-for-him`
- `/christmas-gifts-for-her`
- `/christmas-gifts-under-50`
- `/last-minute-christmas-gifts`

### Secret Santa cluster
- `/secret-santa-gifts`
- `/secret-santa-gifts-under-25`
- `/secret-santa-gifts-under-30`
- `/white-elephant-gifts`
- `/white-elephant-gifts-under-25`
- `/office-secret-santa-gifts`
- `/last-minute-secret-santa-gifts`
