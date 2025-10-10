#!/usr/bin/env python3
"""
Convert .py files with # %% cell markers to Jupyter .ipynb notebooks.

Usage:
    python py_to_ipynb.py input.py output.ipynb
    python py_to_ipynb.py input.py  # Creates input.ipynb
    python py_to_ipynb.py *.py      # Convert all .py files
"""

import sys
import json
import argparse
from pathlib import Path
from typing import List, Tuple


def parse_cells(content: str) -> List[Tuple[str, str]]:
    """
    Parse Python file content into cells based on # %% markers.
    Returns list of (cell_type, source) tuples.
    """
    cells = []
    lines = content.split('\n')
    current_cell = []
    cell_type = 'code'

    for line in lines:
        if line.strip().startswith('# %%'):
            # Save previous cell if it has content
            if current_cell:
                source_text = '\n'.join(current_cell)
                if source_text.strip():
                    cells.append((cell_type, source_text))
            # Start new code cell (ignore cell type comments for now)
            current_cell = []
            cell_type = 'code'
        else:
            current_cell.append(line)

    # Add last cell
    if current_cell:
        source_text = '\n'.join(current_cell)
        if source_text.strip():
            cells.append((cell_type, source_text))

    return cells


def create_notebook(cells: List[Tuple[str, str]]) -> dict:
    """
    Create a Jupyter notebook structure from cells.
    """
    notebook_cells = []

    for cell_type, source in cells:
        if cell_type == 'code':
            cell = {
                "cell_type": "code",
                "execution_count": None,
                "metadata": {},
                "outputs": [],
                # Preserve line breaks explicitly
                "source": [line + '\n' for line in source.splitlines()]
            }
        else:  # markdown
            cell = {
                "cell_type": "markdown",
                "metadata": {},
                "source": [line + '\n' for line in source.splitlines()]
            }

        notebook_cells.append(cell)

    notebook = {
        "cells": notebook_cells,
        "metadata": {
            "kernelspec": {
                "display_name": "Python 3",
                "language": "python",
                "name": "python3"
            },
            "language_info": {
                "codemirror_mode": {
                    "name": "ipython",
                    "version": 3
                },
                "file_extension": ".py",
                "mimetype": "text/x-python",
                "name": "python",
                "nbconvert_exporter": "python",
                "pygments_lexer": "ipython3",
                "version": "3.10.0"
            }
        },
        "nbformat": 4,
        "nbformat_minor": 4
    }

    return notebook


def convert_file(input_path: Path, output_path: Path = None) -> None:
    """
    Convert a single .py file to .ipynb format.
    """
    if not input_path.exists():
        print(f"Error: File {input_path} not found")
        return

    if output_path is None:
        output_path = input_path.with_suffix('.ipynb')

    # Read input file
    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Parse cells
    cells = parse_cells(content)

    if not cells:
        print(f"Warning: No cells found in {input_path}")
        return

    # Create notebook
    notebook = create_notebook(cells)

    # Write output file
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(notebook, f, indent=1, ensure_ascii=False)

    print(f"✓ Converted: {input_path} → {output_path}")


def main():
    parser = argparse.ArgumentParser(
        description='Convert .py files with # %% markers to Jupyter .ipynb notebooks'
    )
    parser.add_argument(
        'input',
        nargs='+',
        help='Input .py file(s). Supports glob patterns like *.py'
    )
    parser.add_argument(
        '-o', '--output',
        help='Output .ipynb file (only for single input file)'
    )

    args = parser.parse_args()

    # Handle multiple input files (glob patterns)
    input_files = []
    for pattern in args.input:
        matches = list(Path('.').glob(pattern))
        if matches:
            input_files.extend(matches)
        else:
            input_files.append(Path(pattern))

    # If output is specified, only process one file
    if args.output and len(input_files) > 1:
        print("Error: Cannot specify -o/--output with multiple input files")
        sys.exit(1)

    # Convert files
    for input_path in input_files:
        output_path = Path(args.output) if args.output else None
        convert_file(input_path, output_path)


if __name__ == '__main__':
    main()

