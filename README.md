# Local Models

Planning and setup notes for a local, free/open-source AI environment on a 2026 MacBook Air M5 with 16 GB unified memory.

The current focus is a local video processing workflow using Draw Things for easier Mac-native creation, plus ComfyUI, ffmpeg, and permissive video models for reproducible workflows that can realistically run on this machine.

## Contents

- `VIDEO_PROCESSING_SETUP_PLAN.md`: command-first setup plan for the local ComfyUI/Wan2.2 video environment.
- `DRAW_THINGS_QUICKSTART.md`: Mac-native Draw Things install/run notes and conservative first video settings.
- `LOCAL_AI_M5_PLAN.md`: broader local AI plan for coding, image, and video workflows.
- `SESSION_CONTEXT.md`: compact handoff notes so work can resume after a lost session.
- `SETUP_STATUS.md`: current implementation status for the local ComfyUI video setup.
- `skills/local-ai-m5-mac/SKILL.md`: workspace Codex skill for future local AI setup and troubleshooting tasks.

## Current Defaults

- Creator UI: Draw Things macOS app.
- Reproducible video UI/runtime: ComfyUI manual install.
- First video model target: Wan2.2 TI2V 5B.
- Video utilities: ffmpeg and VideoHelperSuite.
- Hardware constraint: 16 GB unified memory; start small and benchmark locally.
- License policy: prefer Apache-2.0, MIT, BSD, and GPL components; avoid non-commercial or custom use-restrictive model licenses by default.

## Repository Policy

This repository should track plans, workflows, scripts, and small configuration files only.

Do not commit model weights, generated media, virtual environments, cloned app repos, or large downloads. The `.gitignore` is set up to keep those local.

## Quick Start

For the easiest local creator app, launch Draw Things:

```bash
open -a "Draw Things"
```

Use `DRAW_THINGS_QUICKSTART.md` for the first image-to-video test settings.

For the reproducible ComfyUI backend, start ComfyUI with:

```bash
scripts/start-comfyui.sh
```

Then open `http://127.0.0.1:8188`.
