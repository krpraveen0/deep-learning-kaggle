# Kaggle Kernel Metadata Guide

Use one `kernel-metadata.json` file per module directory.

## Common Fields

- `id`: `username/kernel-slug` (must be unique on Kaggle)
- `title`: notebook title shown on Kaggle
- `code_file`: keep as `notebook.ipynb`
- `language`: `python`
- `kernel_type`: `notebook`
- `is_private`: `false` to publish, `true` while drafting
- `enable_gpu`: `true` for heavy modules
- `enable_internet`: keep `false` unless required

## Module Mapping in This Repository

| Module Folder | Kernel ID | GPU |
|---|---|---|
| `module-00-curriculum-index` | `krpraveen0/dl-from-scratch-curriculum-index` | No |
| `module-01-intro` | `krpraveen0/dl-from-scratch-module-01-intro` | No |
| `module-02-perceptrons` | `krpraveen0/dl-from-scratch-module-02-perceptrons` | No |
| `module-03-backprop` | `krpraveen0/dl-from-scratch-module-03-backprop` | No |
| `module-04-cnns` | `krpraveen0/dl-from-scratch-module-04-cnns` | Yes |
| `module-05-rnns` | `krpraveen0/dl-from-scratch-module-05-rnns` | Yes |
| `module-06-transformers` | `krpraveen0/dl-from-scratch-module-06-transformers` | Yes |
| `module-07-tips` | `krpraveen0/dl-from-scratch-module-07-tips` | No |
| `module-08-project` | `krpraveen0/dl-from-scratch-module-08-project` | Yes |

## Safe Template

```json
{
  "id": "krpraveen0/replace-with-kernel-slug",
  "title": "Deep Learning from Scratch | Module XX: Topic",
  "code_file": "notebook.ipynb",
  "language": "python",
  "kernel_type": "notebook",
  "is_private": "false",
  "enable_gpu": "false",
  "enable_internet": "false",
  "keywords": ["deep learning", "beginner", "education"],
  "dataset_sources": [],
  "kernel_sources": []
}
```

## Publish Commands

```bash
kaggle kernels push -p ./module-00-curriculum-index
kaggle kernels push -p ./module-01-intro
kaggle kernels push -p ./module-02-perceptrons
kaggle kernels push -p ./module-03-backprop
kaggle kernels push -p ./module-04-cnns
kaggle kernels push -p ./module-05-rnns
kaggle kernels push -p ./module-06-transformers
kaggle kernels push -p ./module-07-tips
kaggle kernels push -p ./module-08-project
```