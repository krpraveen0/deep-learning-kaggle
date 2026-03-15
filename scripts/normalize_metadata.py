"""Normalize kernel-metadata.json for Kaggle compatibility.

Removes the optional ``keywords`` field (rejected by Kaggle) and converts
boolean-like string values (e.g. ``"false"``, ``"true"``) to actual JSON
booleans for ``is_private``, ``enable_gpu``, and ``enable_internet``.

The Kaggle SDK coerces values via Python's ``bool()``, where
``bool("false") == True``, so passing string ``"false"`` would mark a
notebook as private.

Usage::

    python3 scripts/normalize_metadata.py <path-to-kernel-metadata.json>
"""

import json
import sys

if len(sys.argv) < 2:
    print('Usage: normalize_metadata.py <path-to-kernel-metadata.json>', file=sys.stderr)
    sys.exit(1)

p = sys.argv[1]
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
with open(p, 'w', encoding='utf-8') as f:
    f.write(json.dumps(d, indent=2) + '\n')
