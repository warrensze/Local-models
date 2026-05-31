# Session Context

Last updated: 2026-05-31

## Current Objective

Set up this `Local-models` workspace to plan and maintain a free/open-source local AI environment for the user's actual hardware:

- MacBook Air 2026
- Apple M5
- 10 CPU cores, 4 performance and 6 efficiency
- 16 GB unified memory
- macOS 26.5
- 512 GB disk

The user wants local AI coding models and diffusion/photo/video graphics workflows, with the latest practical free/open-source software and no default use-restrictive model licenses.

## Decisions Made

- Workspace skill location was chosen instead of global Codex install.
- Easy daily use was originally selected, then revised to performance-first Apple Silicon native tooling.
- Runtime priority is:
  1. vLLM-Metal for local API serving.
  2. mlx-lm for direct Apple Silicon inference and benchmarking.
  3. vllm-mlx as experimental high-performance/API alternative.
  4. llama.cpp/GGUF for compatibility.
  5. Ollama only as fallback/convenience.
- Stock vLLM CPU should not be the default on this Mac.
- ComfyUI is the default open-source media workflow.
- Draw Things app/CLI is allowed as a Mac-native option after verifying current GPL/free-app status.
- Default model size target is 4B-9B. 14B 4-bit is stretch. 30B/35B MoE is experimental on 16 GB RAM.
- Default licenses allowed: Apache-2.0, MIT, BSD, GPL.
- Avoid non-commercial, source-available, custom community, OpenRAIL-style, or use-restrictive model licenses unless explicitly approved.

## Files Created

- `README.md`: repository overview and file guide.
- `.gitignore`: excludes local app clones, model weights, generated media, environments, and caches.
- `.gitattributes`: normalizes text files for GitHub.
- `LICENSE`: MIT license for repository docs/scripts/configs.
- `skills/local-ai-m5-mac/SKILL.md`: reusable Codex workspace skill for this local AI setup.
- `LOCAL_AI_M5_PLAN.md`: human-readable implementation and maintenance plan.
- `SESSION_CONTEXT.md`: this handoff/context file.
- `VIDEO_PROCESSING_SETUP_PLAN.md`: command-first setup plan for the local ComfyUI/Wan2.2 video environment.

## Validation Already Done

- `skills/local-ai-m5-mac/SKILL.md` YAML frontmatter parsed successfully with Ruby YAML.
- Skill file length was 77 lines when created.
- Hardware inspection via `system_profiler SPHardwareDataType` confirmed MacBook Air, Apple M5, 10 cores, 16 GB memory, macOS 26.5.
- Disk inspection showed about 384 GiB free on the current volume.
- This folder was not a git repository when checked.
- Repo prep added GitHub-friendly metadata and ignores; a local git repo has been initialized and is ready for first commit.

## Next Likely Step

If the user asks to continue implementation:

1. For video work, follow `VIDEO_PROCESSING_SETUP_PLAN.md` first.
2. Bootstrap Homebrew, ffmpeg, uv, Python 3.12, Git LFS, and the ComfyUI manual environment.
3. Verify PyTorch MPS before downloading model files.
4. Download only the Wan2.2 TI2V 5B starter files first.
5. Smoke-test one short low-resolution ComfyUI video before adding larger models, interpolation, or LTX.

## Important Constraint

Do not silently replace the performance-first plan with an Ollama-first plan. Ollama is useful, but in this setup it is secondary to MLX/vLLM-Metal paths.
