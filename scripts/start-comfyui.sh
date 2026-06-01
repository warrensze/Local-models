#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMFY_DIR="$ROOT_DIR/apps/ComfyUI"

if [ ! -d "$COMFY_DIR/.venv" ]; then
  echo "ComfyUI virtual environment not found at $COMFY_DIR/.venv" >&2
  exit 1
fi

cd "$COMFY_DIR"
export PYTORCH_ENABLE_MPS_FALLBACK=1
exec .venv/bin/python main.py --listen 127.0.0.1 --port 8188
