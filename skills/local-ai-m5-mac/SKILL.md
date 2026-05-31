---
name: local-ai-m5-mac
description: Use when setting up, maintaining, benchmarking, or troubleshooting a free/open-source local AI stack on a MacBook Air 2026 Apple M5 with 16 GB unified memory, especially for MLX, vLLM-Metal, vllm-mlx, llama.cpp, Ollama fallback, coding models, ComfyUI, Draw Things, diffusion, and local image/video generation.
---

# Local AI M5 Mac

Use this skill for local AI work on this machine: MacBook Air, Apple M5, 10 cores, 16 GB unified memory, macOS 26.5, 512 GB disk. Optimize for practical performance on this hardware, not NVIDIA-server benchmarks.

## Core Rules

- Verify latest official docs, releases, and model cards before installing or recommending versions.
- Prefer local, free/open-source, unrestricted-use components.
- Default-allow licenses: Apache-2.0, MIT, BSD, GPL.
- Do not default to non-commercial, source-available, custom community, OpenRAIL-style, or use-restrictive model licenses. Ask before using them.
- Keep at least 100 GB free. Avoid keeping the same model in MLX, GGUF, ComfyUI, and Draw Things formats unless there is a clear need.
- Treat 16 GB unified memory as the main constraint. Prefer 4B-9B models; use 14B 4-bit only after a local smoke test; treat 30B/35B MoE models as experiments, not defaults.

## Runtime Priority

For LLM inference, choose runtimes in this order:

1. **vLLM-Metal** for OpenAI-compatible local API serving on Apple Silicon. It is the preferred API server path because it uses vLLM with the Apple Silicon Metal/MLX plugin.
2. **mlx-lm** for lowest-overhead direct generation, chat, benchmarking, conversion, and quantization when no HTTP API is needed.
3. **vllm-mlx** as an experimental high-performance alternative when it benchmarks faster locally, or when its Anthropic-compatible API, multimodal support, or continuous batching is specifically useful.
4. **llama.cpp/GGUF** for durable model compatibility and fallback workflows.
5. **Ollama** only for convenience or compatibility when another tool or packaged model specifically needs it.

Do not use stock vLLM CPU as the default on this Mac. Apple Silicon CPU support is experimental/source-build-oriented and does not provide the intended Metal acceleration unless using vLLM-Metal or a verified MLX-backed path.

## Coding Workflow

- Point coding tools first at a local OpenAI-compatible endpoint from vLLM-Metal or vllm-mlx.
- Configure Continue and Aider against that endpoint before trying Ollama.
- Keep Ollama optional and secondary; do not make it the main runtime unless vLLM-Metal/vllm-mlx/mlx-lm fail the local smoke tests.
- Default coding/chat models should be the latest verified permissive Qwen Coder/Instruct or comparable 4B-9B MLX models.
- Use a 14B 4-bit model only after checking memory pressure and interactive speed on this Mac.
- Avoid making 30B/35B MoE models the default on 16 GB RAM, even if a quantized build can launch.

## Media Workflow

- Use ComfyUI as the default open-source graph workflow for image and video generation.
- Include Draw Things app/CLI as a Mac-native efficient option only after verifying current GPL/free-app status and model license compatibility.
- Prefer MLX/CoreML/MPS-aware workflows and small/fast models.
- Image defaults should use FLUX.1 Schnell or other permissive models; do not default to FLUX Dev-style non-commercial licenses.
- Video defaults should use Wan2.2-class Apache-2.0 models only, limited to short low-resolution tests on this hardware.

## Setup Procedure

When asked to implement or refresh the stack:

1. Inspect current hardware, macOS version, disk space, installed package managers, Python, Node, and existing AI tools.
2. Check official sources for vLLM-Metal, MLX, mlx-lm, vllm-mlx, llama.cpp, ComfyUI, Draw Things, Continue, Aider, and any target models.
3. Build an install plan that starts with vLLM-Metal and mlx-lm, then adds vllm-mlx only if useful, then llama.cpp/GGUF, then Ollama as fallback.
4. Before downloading large models, record model name, source URL, license, format, quantization, expected disk size, and why it fits 16 GB memory.
5. Prefer one small known-good model first. Add larger models only after the runtime and client tools pass smoke tests.

## Smoke Tests

After setup changes, verify the relevant path:

- `vllm` or the vLLM-Metal server starts and answers a local OpenAI-compatible chat completion request.
- `mlx_lm.generate` works with one small MLX model.
- Continue and Aider can call the local OpenAI-compatible endpoint.
- Ollama is absent or clearly secondary unless needed for compatibility.
- ComfyUI launches and runs one lightweight image workflow.
- Draw Things is tested only if it is part of the selected media workflow.

## Benchmark Promotion

Promote a runtime/model to default only after a local benchmark records:

- model identifier, quantization, runtime, command, context length, prompt type, tokens/sec or elapsed time, peak memory symptoms, and subjective usability;
- license status and whether outputs are unrestricted for the intended use;
- whether the same model already exists locally in another format.

Prefer the fastest stable runtime that fits memory, keeps the machine responsive, and uses an unrestricted license.
