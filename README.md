# Deep Learning from Scratch - Kaggle Curriculum

A beginner-friendly, publish-ready curriculum with 1 index notebook + 8 learning modules and examples from daily life.

## Curriculum Overview

| Module | Focus | Daily-Life Example | GPU |
|---|---|---|---|
| 00 | Curriculum Index | Single landing page linking all modules | No |
| 01 | What is Deep Learning? | Coffee spending prediction | No |
| 02 | Perceptrons and Activations | High electricity usage day classifier | No |
| 03 | Backpropagation and Optimization | Mobile data usage prediction | No |
| 04 | CNNs | Clothing image classification | Yes |
| 05 | RNNs and LSTMs | Step-count forecasting | Yes |
| 06 | Transformers and Attention | Reminder text next-word prediction | Yes |
| 07 | Training Best Practices | Grocery bill overfitting prevention | No |
| 08 | Capstone Project | Closet assistant image classifier | Yes |

## Kaggle Kernel IDs

The `id` field in every `kernel-metadata.json` is automatically rewritten to
`<KAGGLE_USERNAME>/<kernel-slug>` during deployment (both CI and the local
script), so kernels always land in **your own** Kaggle account.

If you are the original author (`krpraveen0`) the published slugs are:

- `krpraveen0/dl-from-scratch-curriculum-index`
- `krpraveen0/dl-from-scratch-module-01-intro`
- `krpraveen0/dl-from-scratch-module-02-perceptrons`
- `krpraveen0/dl-from-scratch-module-03-backprop`
- `krpraveen0/dl-from-scratch-module-04-cnns`
- `krpraveen0/dl-from-scratch-module-05-rnns`
- `krpraveen0/dl-from-scratch-module-06-transformers`
- `krpraveen0/dl-from-scratch-module-07-tips`
- `krpraveen0/dl-from-scratch-module-08-project`

> **Note on CI log URLs**: GitHub Actions masks the value of the
> `KAGGLE_USERNAME` secret in log output, replacing it with `***`.  The URL
> shown — `https://www.kaggle.com/code/***/dl-from-scratch-...` — is correct;
> `***` is your actual username, just hidden for security.  Open
> `https://www.kaggle.com/<your-username>/code` to find all pushed kernels.

## Publish a Module Manually

```bash
kaggle kernels push -p ./module-00-curriculum-index
kaggle kernels push -p ./module-01-intro
```

Run the same command for any module folder.

## Auto Deploy with GitHub Actions

This repository includes `.github/workflows/deploy-to-kaggle.yml` to push changed modules automatically.

### GitHub Secrets

1. Go to **kaggle.com → Your profile → Settings → API** and download `kaggle.json`.
2. Add the following repository secrets (**Settings → Secrets → Actions → New repository secret**):

| Secret | Value |
|---|---|
| `KAGGLE_USERNAME` | Your Kaggle username |
| `KAGGLE_KEY` | Your Kaggle API key from `kaggle.json` |

## Local vs GitHub Parity

Use this table when debugging deployment behavior.

| Local Terminal Flow | GitHub Actions Flow |
|---|---|
| `scripts/kaggle-local.sh auth` writes `~/.kaggle/kaggle.json` and `~/.kaggle/access_token` | `Configure Kaggle credentials` step writes the same files from GitHub secrets |
| `scripts/kaggle-local.sh test` runs a quick auth check | `Verify Kaggle authentication` step runs `kaggle kernels list -m` |
| `scripts/kaggle-local.sh push module-04-cnns` deploys one module after file checks | `Deploy single module (manual)` does the same via `workflow_dispatch` input |
| `scripts/kaggle-local.sh push-all` loops through `module-*` folders | `Deploy changed modules (auto)` loops `module-*` and deploys changed modules on push |
| Local script requires `notebook.ipynb` and `kernel-metadata.json` | Workflow uses the same file presence checks before deploy |
| `push` / `push-all` normalise metadata (remove `keywords`, fix bool types, set `id` username) before each push | `Normalize metadata` step does the same with `scripts/normalize_metadata.py --username $KAGGLE_USERNAME` |

If local deploy works but GitHub fails, first verify `KAGGLE_USERNAME` and `KAGGLE_KEY` in repository secrets.

## Folder Structure

```text
kaggle_workplace/
├── .github/
│   └── workflows/
│       └── deploy-to-kaggle.yml
├── METADATA_GUIDE.md
├── module-00-curriculum-index/
│   ├── notebook.ipynb
│   └── kernel-metadata.json
├── module-01-intro/
│   ├── notebook.ipynb
│   └── kernel-metadata.json
├── module-02-perceptrons/
├── module-03-backprop/
├── module-04-cnns/
├── module-05-rnns/
├── module-06-transformers/
├── module-07-tips/
└── module-08-project/
```

## Notes for Beginners

- Start from Module 01 and proceed in order.
- Every notebook has a short concept section, runnable code, and a practice task.
- Training settings are intentionally runtime-tuned for Kaggle quick runs.
- Keep modules private while iterating, then set `"is_private": "false"` to publish.
