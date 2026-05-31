# Local Models

Planning and setup notes for a local, free/open-source AI environment on a 2026 MacBook Air M5 with 16 GB unified memory.

The current focus is a local video processing workflow using ComfyUI, ffmpeg, and permissive video models that can realistically run on this machine.

## Contents

- `VIDEO_PROCESSING_SETUP_PLAN.md`: command-first setup plan for the local ComfyUI/Wan2.2 video environment.
- `LOCAL_AI_M5_PLAN.md`: broader local AI plan for coding, image, and video workflows.
- `SESSION_CONTEXT.md`: compact handoff notes so work can resume after a lost session.
- `skills/local-ai-m5-mac/SKILL.md`: workspace Codex skill for future local AI setup and troubleshooting tasks.

## Current Defaults

- Video UI/runtime: ComfyUI manual install.
- First video model target: Wan2.2 TI2V 5B.
- Video utilities: ffmpeg and VideoHelperSuite.
- Hardware constraint: 16 GB unified memory; start small and benchmark locally.
- License policy: prefer Apache-2.0, MIT, BSD, and GPL components; avoid non-commercial or custom use-restrictive model licenses by default.

## Repository Policy

This repository should track plans, workflows, scripts, and small configuration files only.

Do not commit model weights, generated media, virtual environments, cloned app repos, or large downloads. The `.gitignore` is set up to keep those local.

## Next Step

Follow `VIDEO_PROCESSING_SETUP_PLAN.md` phase by phase. Verify PyTorch MPS before downloading model files, then render one short low-resolution Wan2.2 clip before adding larger models or optional nodes.
