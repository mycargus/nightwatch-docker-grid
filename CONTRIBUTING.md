# Contributing

First install the git hooks. This will save you some pull-request headaches. :)

```bash
./scripts/install-hooks.sh
```

We use `prettier` to format most of our files.

```bash
npm ci
npm run lint
```

If you get any lint errors, try

```bash
npm run lint:fix
```
