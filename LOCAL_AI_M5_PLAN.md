# Local AI Mac M5 Performance-First Plan

Last updated: 2026-05-31

## Goal

Set up and maintain the best practical free/open-source local AI workflow for this machine:

- MacBook Air 2026
- Apple M5, 10 cores
- 16 GB unified memory
- macOS 26.5
- 512 GB disk, with roughly 384 GiB free when this plan was created

The setup is for local AI coding models plus diffusion/photo/video graphics workflows. It should favor local execution, unrestricted-use components, strong Apple Silicon performance, and minimal dependence on cloud services.

## Guiding Principles

- Prefer free/open-source software and permissive or standard FOSS licenses: Apache-2.0, MIT, BSD, GPL.
- Avoid non-commercial, source-available, OpenRAIL-style, custom community, or otherwise use-restrictive model licenses unless explicitly approved.
- Verify current official docs, releases, and model cards before installing or recommending exact versions.
- Treat 16 GB unified memory as the main constraint.
- Keep at least 100 GB free on disk.
- Avoid keeping the same model in multiple formats unless there is a clear runtime need.
- Optimize for this Mac, not for NVIDIA server benchmarks.

## Runtime Priority

Use this order for local LLM inference:

1. **vLLM-Metal**: default for local API serving on Apple Silicon. It provides a vLLM path backed by Metal/MLX and should be the first OpenAI-compatible endpoint to try.
2. **mlx-lm**: default for direct generation, chat, benchmarking, model conversion, and quantization when no server is needed.
3. **vllm-mlx**: experimental high-performance alternative if it benchmarks better locally or if its Anthropic-compatible API, multimodal support, or continuous batching is useful.
4. **llama.cpp/GGUF**: compatibility fallback for broad model availability and durable offline workflows.
5. **Ollama**: convenience fallback only, especially for tools or packaged models that specifically require it.

Do not make stock vLLM CPU the default on this Mac. Apple Silicon CPU support is experimental/source-build-oriented and does not provide the intended Metal acceleration unless using vLLM-Metal or another verified MLX-backed path.

## Coding Workflow

The coding stack should point first to an OpenAI-compatible local endpoint served by vLLM-Metal or vllm-mlx.

Recommended tools:

- Continue for editor-integrated local coding assistance.
- Aider for terminal pair programming and repo-aware edits.
- Optional Ollama support only after the vLLM-Metal or MLX path is working.

Model policy:

- Default to latest verified permissive Qwen Coder/Instruct or comparable 4B-9B MLX models.
- Try 14B 4-bit models only after checking local memory pressure and responsiveness.
- Treat 30B/35B MoE models as experiments on 16 GB RAM, not defaults.

## Media Workflow

Recommended tools:

- ComfyUI as the default open-source graph workflow for image and video generation.
- Draw Things as a Mac-native creative option after verifying local-only settings and model license compatibility. Treat it as free/local creator software, not the reproducible FOSS backend.
- The concrete video-first setup commands live in `VIDEO_PROCESSING_SETUP_PLAN.md`.

Model policy:

- Image: prefer FLUX.1 Schnell or other permissive models. Do not default to FLUX Dev-style non-commercial licenses.
- Video: default to Wan2.2-class Apache-2.0 models, limited to short low-resolution tests on this hardware. Treat LTX-2/LTX-2.3 as opt-in because its custom license is not unrestricted.
- Prefer MLX/CoreML/MPS-aware workflows and small/fast model variants.

## Implementation Order

1. Inspect hardware, macOS version, disk space, package managers, Python, Node, and existing AI tools.
2. Verify official installation docs and releases for vLLM-Metal, MLX, mlx-lm, vllm-mlx, llama.cpp, ComfyUI, Draw Things, Continue, Aider, and target models.
3. Install or configure vLLM-Metal and mlx-lm first.
4. Add vllm-mlx only if it helps the target workflow or benchmarks better.
5. Add llama.cpp/GGUF support for compatibility.
6. Add Ollama only as a fallback or compatibility layer.
7. Install media tooling with ComfyUI first, Draw Things second if useful.
8. Download one small known-good model first, then larger models only after smoke tests pass.

## Model Intake Checklist

Before downloading a large model, record:

- Model name and source URL.
- License.
- Runtime format: MLX, GGUF, safetensors, ComfyUI/Draw Things format, etc.
- Quantization and expected disk size.
- Expected memory fit on 16 GB unified memory.
- Why this model is needed instead of an existing local model.

## Smoke Tests

Run these after setup changes:

- vLLM-Metal or `vllm` endpoint starts and answers a local OpenAI-compatible chat completion request.
- `mlx_lm.generate` works with one small MLX model.
- Continue can call the local OpenAI-compatible endpoint.
- Aider can call the same endpoint.
- Ollama is absent or clearly secondary unless needed for compatibility.
- ComfyUI launches and runs one lightweight image workflow.
- Draw Things is tested only if selected for the media workflow.

## Benchmark Promotion Criteria

Promote a runtime or model to default only after recording:

- Model identifier.
- Quantization.
- Runtime.
- Command used.
- Context length.
- Prompt type.
- Tokens/sec or elapsed time.
- Memory symptoms and machine responsiveness.
- License status and output-use restrictions.
- Whether the same model exists locally in another format.

The winning default is the fastest stable option that fits memory, keeps the Mac responsive, and uses an unrestricted license.

## Workspace Skill

A reusable Codex workspace skill exists at:

- `skills/local-ai-m5-mac/SKILL.md`

The dedicated video environment plan exists at:

- `VIDEO_PROCESSING_SETUP_PLAN.md`

Use that skill when future work touches this local AI stack.

## Source Notes

Sources checked during planning included official or primary pages for vLLM, vLLM-Metal, MLX, mlx-lm, vllm-mlx, ComfyUI, FLUX.1, Wan2.2, Continue, Aider, LibreChat, and Draw Things. Re-check those sources before installation because model and runtime support changes quickly.
