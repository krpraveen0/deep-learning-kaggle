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

- `krpraveen0/dl-from-scratch-curriculum-index`
- `krpraveen0/dl-from-scratch-module-01-intro`
- `krpraveen0/dl-from-scratch-module-02-perceptrons`
- `krpraveen0/dl-from-scratch-module-03-backprop`
- `krpraveen0/dl-from-scratch-module-04-cnns`
- `krpraveen0/dl-from-scratch-module-05-rnns`
- `krpraveen0/dl-from-scratch-module-06-transformers`
- `krpraveen0/dl-from-scratch-module-07-tips`
- `krpraveen0/dl-from-scratch-module-08-project`

## Publish a Module Manually

```bash
kaggle kernels push -p ./module-00-curriculum-index
kaggle kernels push -p ./module-01-intro
```

Run the same command for any module folder.

## Auto Deploy with GitHub Actions

This repository includes `deploy-to-kaggle.yml` to push changed modules automatically.

### GitHub Secrets — New API Token (Recommended, kaggle CLI >= 1.8.0)

1. Go to **kaggle.com → Your profile → Settings → API → API Tokens (Recommended) → Create New Token**.
2. Copy the token value shown.
3. Add a repository secret named **`KAGGLE_KEY`** and paste the token as the value. No `KAGGLE_USERNAME` is needed.

| Secret | Value |
|---|---|
| `KAGGLE_KEY` | Your new API token from Kaggle settings |

### GitHub Secrets — Legacy API Credentials

If you are still using the old **Legacy API credentials**, set both secrets:

| Secret | Value |
|---|---|
| `KAGGLE_USERNAME` | Your Kaggle username |
| `KAGGLE_KEY` | Your Kaggle API key |

> **Note:** If `KAGGLE_USERNAME` is set, the legacy credential format is used. If only `KAGGLE_KEY` is set, the new token format is used.

## Folder Structure

```text
kaggle_workplace/
├── deploy-to-kaggle.yml
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
