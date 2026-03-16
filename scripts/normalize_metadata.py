"""Normalize kernel-metadata.json for Kaggle compatibility.

Removes the optional ``keywords`` field (rejected by Kaggle) and converts
boolean-like string values (e.g. ``"false"``, ``"true"``) to actual JSON
booleans for ``is_private``, ``enable_gpu``, and ``enable_internet``.

The Kaggle SDK coerces values via Python's ``bool()``, where
``bool("false") == True``, so passing string ``"false"`` would mark a
notebook as private.

Optionally substitutes the username in the ``id`` field so that kernels are
pushed to the authenticated user's own Kaggle account rather than the
hardcoded owner embedded in the repository metadata.

Override flags (``--enable-gpu``, ``--enable-internet``, ``--is-private``)
let callers change these settings at deployment time without modifying the
committed metadata files.

Usage::

    python3 scripts/normalize_metadata.py <path-to-kernel-metadata.json> \\
        [--username <kaggle-username>] \\
        [--enable-gpu true|false] \\
        [--enable-internet true|false] \\
        [--is-private true|false]
"""

import argparse
import json

parser = argparse.ArgumentParser(
    description='Normalize kernel-metadata.json for Kaggle compatibility.'
)
parser.add_argument('path', help='Path to kernel-metadata.json')
parser.add_argument(
    '--username',
    default='',
    help='Kaggle username to substitute into the id field (replaces the embedded owner).',
)
parser.add_argument(
    '--enable-gpu',
    default=None,
    choices=['true', 'false'],
    help='Override enable_gpu in the metadata (true or false).',
)
parser.add_argument(
    '--enable-internet',
    default=None,
    choices=['true', 'false'],
    help='Override enable_internet in the metadata (true or false).',
)
parser.add_argument(
    '--is-private',
    default=None,
    choices=['true', 'false'],
    help='Override is_private in the metadata (true or false).',
)
args = parser.parse_args()

p = args.path
with open(p, 'r', encoding='utf-8') as f:
    d = json.load(f)
d.pop('keywords', None)
for field in ('is_private', 'enable_gpu', 'enable_internet'):
    if field in d and isinstance(d[field], str):
        val = d[field].strip().lower()
        if val not in ('true', 'false'):
            print(
                f'WARNING: unexpected value for {field} in {p}: {d[field]!r}'
                ' (treating as false)',
                flush=True,
            )
        d[field] = val == 'true'

# Apply runtime overrides (take precedence over committed metadata values).
if args.enable_gpu is not None:
    d['enable_gpu'] = args.enable_gpu == 'true'
if args.enable_internet is not None:
    d['enable_internet'] = args.enable_internet == 'true'
if args.is_private is not None:
    d['is_private'] = args.is_private == 'true'

if args.username and 'id' in d:
    parts = d['id'].split('/', 1)
    if len(parts) == 2:
        d['id'] = f"{args.username}/{parts[1]}"
    else:
        print(
            f'WARNING: id field in {p} does not contain a slash separator: {d["id"]!r}'
            ' (username substitution skipped)',
            flush=True,
        )

with open(p, 'w', encoding='utf-8') as f:
    f.write(json.dumps(d, indent=2) + '\n')
