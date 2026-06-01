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
- Draw Things is installed and should be used first as the Mac-native creator UI for interactive image/video experiments.
- ComfyUI is the default reproducible open-source media workflow/backend.
- Draw Things is not treated as the reproducible FOSS backend.
- LTX-2/LTX-2.3 is no longer treated as unrestricted; its custom license has revenue/use restrictions, so it is opt-in research only.
- Phosphene/LTX MLX tools are promising Apple Silicon alternatives, but not defaults on 16 GB unified memory.
- WanGP/Wan2GP is strong for low-VRAM CUDA-style systems, but not Apple Silicon-first.
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
- `DRAW_THINGS_QUICKSTART.md`: step-by-step Draw Things launch and first image-to-video settings.
- `scripts/start-comfyui.sh`: launcher for the installed ComfyUI environment.
- `SETUP_STATUS.md`: current implementation status and verification notes.

## Validation Already Done

- `skills/local-ai-m5-mac/SKILL.md` YAML frontmatter parsed successfully with Ruby YAML.
- Skill file length was 77 lines when created.
- Hardware inspection via `system_profiler SPHardwareDataType` confirmed MacBook Air, Apple M5, 10 cores, 16 GB memory, macOS 26.5.
- Disk inspection showed about 384 GiB free on the current volume.
- This folder was not a git repository when checked.
- Repo prep added GitHub-friendly metadata and ignores; a local git repo has been initialized and is ready for first commit.
- Video setup implementation completed: ComfyUI manual install, Manager, VideoHelperSuite, Wan2.2 TI2V 5B model files, MPS launch, and tiny smoke MP4.
- Draw Things 1.20260518.2 installed with Homebrew Cask at `/Applications/Draw Things.app` and launched once with `open -a "Draw Things"`.
- Running app URL: `http://127.0.0.1:8188`.
- Launcher: `scripts/start-comfyui.sh`.

## Next Likely Step

If the user asks to continue implementation:

1. For quick creator testing, open Draw Things and follow `DRAW_THINGS_QUICKSTART.md`.
2. Prefer image-to-video from a good still image over raw text-to-video on this 16 GB Mac.
3. For reproducible backend work, use `scripts/start-comfyui.sh` and follow `VIDEO_PROCESSING_SETUP_PLAN.md`.
4. Avoid adding larger models, interpolation, Phosphene, or LTX until one small image-to-video path is useful.

## Important Constraint

Do not silently replace the performance-first plan with an Ollama-first plan. Ollama is useful, but in this setup it is secondary to MLX/vLLM-Metal paths.
