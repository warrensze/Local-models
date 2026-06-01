# Local Video Processing Setup Plan

Last updated: 2026-05-31

## Goal

Set up a free/local video AI environment on this MacBook Air M5 with 16 GB unified memory. The creator-facing target is Draw Things for easier Mac-native experimentation. The reproducible backend target is still ComfyUI running locally with Apple Silicon MPS acceleration, video input/output support, and the official Wan2.2 TI2V 5B workflow.

This plan is command-first, but staged so we can stop after each phase and verify before downloading large model files.

## 2026 Re-Audit Conclusion

ComfyUI is still the best default for this repo because it is open-source, scriptable, has official Apple Silicon support through MPS, and has first-party Wan2.2 workflow templates. It is not necessarily the easiest creative UI, but it is the safest reproducible foundation for free/local/unrestricted-by-default workflows.

Alternatives worth tracking:

- **Draw Things**: likely the best easy Mac-native app for casual local image/video generation. It supports local creation and current models such as Wan 2.2 and LTX-2.3, but the main app is not treated here as a fully open-source, command-reproducible stack. Use it as the creator UI, while ComfyUI stays the repo's reproducible foundation.
- **Phosphene / LTX MLX tools**: promising Apple-Silicon-native LTX-2.3 video/audio generation. Not default on this 16 GB machine because LTX-2.3 is heavy, many workflows expect more unified memory, and the LTX-2 license has revenue/use restrictions.
- **WanGP / Wan2GP**: excellent low-VRAM video UI on CUDA/Windows/Linux-style systems, but not the default for this Mac because upstream support is GPU/CUDA-oriented and Apple Silicon MPS support is not the main path.
- **LTX Desktop**: official LTX app/editor, but macOS local mode is not the first target here; LTX docs currently point macOS users toward API mode or heavier local setups.

## Current Local State

Observed in this workspace:

- Hardware: MacBook Air, Apple M5, 10 cores, 16 GB memory, macOS 26.5.
- Disk: about 384 GiB free when checked.
- Python: `/usr/bin/python3`, version 3.9.6. This is too old for the target stack.
- Git: installed.
- Homebrew: not found in PATH.
- ffmpeg: not found in PATH.
- uv: not found in PATH.
- huggingface CLI: not found in PATH.

## Recommended Stack

- **Draw Things** as the first creator UI for easier Mac-native experimentation.
- **ComfyUI manual install** as the primary reproducible setup. It is command-line friendly and easy to repair.
- **ComfyUI Desktop** as the easy fallback. Official docs support Apple Silicon and Homebrew install, but Desktop is still beta.
- **Wan2.2 TI2V 5B** as the first video model. ComfyUI docs provide an official native workflow, and the 5B variant is the realistic first target on 16 GB unified memory.
- **Draw Things CLI** as optional later tooling. The GUI app is enough for the immediate goal.
- **LTX-2/LTX-2.3** as later research only. It is technically strong and has MLX-native community tooling, but it is not a default because of hardware pressure and custom license restrictions.
- **VideoHelperSuite** for video load/save nodes.
- **ffmpeg** for local video encoding/decoding.
- **Frame interpolation** as phase 2, after base generation works.

## Alternative Decision Matrix

| Option | Role | Why use it | Why not default |
| --- | --- | --- | --- |
| ComfyUI manual | Primary | Open-source, reproducible, broadest workflow/model support, official Wan2.2 templates | More setup and node complexity |
| ComfyUI Desktop | Fallback/easy install | Official Mac app, Apple Silicon only, MPS setup flow | Beta; less transparent than manual setup |
| Draw Things | Creator app | Free local Mac app, polished UX, supports image/video generation | Not the repo's reproducible FOSS command stack; model/app behavior can change through app releases |
| Phosphene | Optional MLX/LTX experiment | Apple Silicon native, local panel/API, LTX-2.3 audio+video | LTX license is restricted; 16 GB RAM is below the comfortable tier |
| WanGP/Wan2GP | Non-default | Great low-VRAM video super-app on CUDA-like systems | Not Apple Silicon first; may duplicate model downloads |
| Diffusers scripts | Developer fallback | Direct Python pipelines, useful for testing model support | More brittle for creative daily use |

## Phase 0: Bootstrap System Tools

Install Homebrew if it is still missing:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to the current shell:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install the local toolchain:

```bash
brew update
brew install git git-lfs ffmpeg aria2 uv python@3.12
git lfs install
```

Verify:

```bash
brew --version
git --version
git lfs version
ffmpeg -version
uv --version
python3.12 --version
```

## Phase 1: Create Workspace Layout

From `/Users/warren/Projects/Local-models`:

```bash
mkdir -p apps downloads logs models workflows outputs
mkdir -p models/video models/image models/upscale
```

Use `apps/` for cloned software, `downloads/` for temporary downloads, and ComfyUI's own `models/` folders for files that ComfyUI needs to discover directly.

## Phase 2: Install ComfyUI Manually

Clone ComfyUI:

```bash
cd /Users/warren/Projects/Local-models/apps
git clone https://github.com/Comfy-Org/ComfyUI.git
cd ComfyUI
```

Create the Python environment:

```bash
uv venv --python 3.12 .venv
source .venv/bin/activate
python -m pip install --upgrade pip wheel setuptools
```

Install PyTorch and ComfyUI requirements:

```bash
python -m pip install torch torchvision torchaudio
python -m pip install -r requirements.txt
python -m pip install "huggingface_hub[cli]"
```

Verify PyTorch MPS:

```bash
python -c "import torch; print('torch', torch.__version__); print('mps', torch.backends.mps.is_available())"
```

If MPS is `False`, stop and troubleshoot PyTorch before downloading video models.

Start ComfyUI:

```bash
python main.py --listen 127.0.0.1 --port 8188
```

After setup, the repo launcher can also be used from `/Users/warren/Projects/Local-models`:

```bash
scripts/start-comfyui.sh
```

Open:

```text
http://127.0.0.1:8188
```

## Phase 3: Add Minimal Video Nodes

Install ComfyUI Manager and VideoHelperSuite:

```bash
cd /Users/warren/Projects/Local-models/apps/ComfyUI/custom_nodes
git clone https://github.com/Comfy-Org/ComfyUI-Manager.git comfyui-manager
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
```

Install node dependencies in the ComfyUI environment:

```bash
cd /Users/warren/Projects/Local-models/apps/ComfyUI
source .venv/bin/activate
python -m pip install -r custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt
```

Restart ComfyUI and confirm the manager loads. Use custom nodes sparingly: install only the nodes required by a chosen workflow, because custom nodes can execute Python code.

## Phase 3A: Draw Things Creator App

Use this when the immediate priority is easiest creative experimentation rather than a command-reproducible open-source setup.

Install the app:

```bash
brew install --cask draw-things
```

Launch it:

```bash
open -a "Draw Things"
```

First-run guidance:

1. Keep cloud/API compute disabled for local-only testing unless explicitly choosing otherwise.
2. Start with image generation, then image-to-video. Text-to-video without a source image is more likely to produce flashing colors on this hardware.
3. Download only one small model path at a time. Do not duplicate ComfyUI's model downloads unless Draw Things requires its own format.
4. Prefer FLUX.1 Schnell or another permissive lightweight image model for still-image creation.
5. For video, test the smallest available Wan 2.2 local preset first, ideally a 5B, distilled, quantized, or "fast" variant.
6. Start at 384x224 or 512x288, 16 to 33 frames, 8 fps, batch size 1.
7. Record model name, bit depth/quantization, settings, generation time, memory symptoms, and whether it crashes on 16 GB.
8. Keep Draw Things as the creator UI while preserving ComfyUI as the reproducible workflow backend.

Do not download LTX-2.3 first on this 16 GB Mac. If testing LTX in Draw Things, use the smallest quantized/distilled option and expect instability until proven otherwise.

Detailed Draw Things run notes live in `DRAW_THINGS_QUICKSTART.md`.

## Phase 4: Download Wan2.2 TI2V 5B Model Files

Create target folders:

```bash
cd /Users/warren/Projects/Local-models/apps/ComfyUI
mkdir -p models/diffusion_models models/text_encoders models/vae
```

Download only the 5B starter set first:

```bash
curl -L -C - \
  -o models/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors \
  https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors
```

```bash
curl -L -C - \
  -o models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
  https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors
```

```bash
curl -L -C - \
  -o models/vae/wan2.2_vae.safetensors \
  https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors
```

Verify files landed:

```bash
du -sh models/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors
du -sh models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors
du -sh models/vae/wan2.2_vae.safetensors
```

## Phase 5: First Wan2.2 Smoke Test

Start ComfyUI:

```bash
cd /Users/warren/Projects/Local-models/apps/ComfyUI
source .venv/bin/activate
python main.py --listen 127.0.0.1 --port 8188
```

In the browser:

1. Open `http://127.0.0.1:8188`.
2. Go to `Workflow` -> `Browse Templates` -> `Video`.
3. Load `Wan2.2 5B video generation`.
4. Confirm these nodes point to:
   - `wan2.2_ti2v_5B_fp16.safetensors`
   - `umt5_xxl_fp8_e4m3fn_scaled.safetensors`
   - `wan2.2_vae.safetensors`
5. Start with conservative settings:
   - 512x288 or the template default if lower.
   - 33 frames or fewer.
   - Batch size 1.
   - Short prompt.
6. Queue one prompt and monitor Activity Monitor for memory pressure.

The first successful output is more important than quality. Improve resolution, frame count, and steps only after the first clip completes.

## Phase 6: Video Utilities

Use ffmpeg to inspect and convert outputs:

```bash
ffprobe -hide_banner output/*.mp4
```

Convert a generated clip to a widely compatible MP4:

```bash
ffmpeg -i input.mp4 -c:v libx264 -pix_fmt yuv420p -movflags +faststart output_compatible.mp4
```

Make a preview GIF:

```bash
ffmpeg -i input.mp4 -vf "fps=12,scale=512:-1:flags=lanczos" preview.gif
```

Extract frames:

```bash
mkdir -p frames
ffmpeg -i input.mp4 frames/frame_%05d.png
```

Rebuild frames into video:

```bash
ffmpeg -framerate 12 -i frames/frame_%05d.png -c:v libx264 -pix_fmt yuv420p rebuilt.mp4
```

## Phase 7: Optional Frame Interpolation

Only after Wan2.2 generation and ffmpeg output work:

```bash
cd /Users/warren/Projects/Local-models/apps/ComfyUI/custom_nodes
git clone https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git
```

```bash
cd /Users/warren/Projects/Local-models/apps/ComfyUI
source .venv/bin/activate
python -m pip install -r custom_nodes/ComfyUI-Frame-Interpolation/requirements.txt
```

Restart ComfyUI. If the latest ComfyUI native frame interpolation nodes are available and stable, prefer those over extra custom nodes.

## Phase 8: Optional ComfyUI Desktop

If the manual setup becomes fussy, install the official Desktop app:

```bash
brew install comfyui
```

During Desktop initialization:

- Select MPS.
- Use a separate empty install folder.
- Keep models in a shared folder or link Desktop to the manual model folders through the Desktop extra model paths config.
- Do not modify Desktop's internal `resource/ComfyUI` folder.

## Phase 9: Later Research Track

Do not install these until the 5B Wan2.2 workflow is stable:

- Wan2.2 14B T2V/I2V FP8: likely heavy on 16 GB unified memory, but maybe testable at very low settings.
- LTX-2/LTX-2.3 through Phosphene, Draw Things, or MLX ports: strong video/audio stack, but custom-licensed and memory-heavy. Treat as opt-in research, not unrestricted default.
- WanGP/Wan2GP: revisit only if Apple Silicon support becomes first-class or if a separate CUDA machine is available.
- Upscaling models: add only after base generation works and disk/memory are understood.
- Audio/video generation: later, because it compounds model size and workflow complexity.

## Acceptance Criteria

The video environment is ready when:

- `ffmpeg` and `ffprobe` work.
- Draw Things is installed and launches from `/Applications/Draw Things.app`.
- ComfyUI starts locally at `http://127.0.0.1:8188`.
- PyTorch reports MPS available.
- ComfyUI Manager and VideoHelperSuite load without import errors.
- The Wan2.2 5B template loads without missing core model files.
- A short low-resolution video renders and saves locally.
- The output can be converted by ffmpeg to a compatible MP4.

## Sources Checked

- ComfyUI macOS Desktop docs: Apple Silicon support, Homebrew install, MPS recommendation, Desktop beta status.
- ComfyUI GitHub: GPL-3.0 project, current official repository.
- ComfyUI Wan2.2 official workflow docs: Wan2.2 5B template, required model files, low VRAM/offloading guidance.
- Wan2.2 GitHub: Apache-2.0 model repository.
- Draw Things official site and Homebrew Cask: free local Mac app install path and current app version.
- Draw Things CLI announcement: optional GPLv3 command-line tool via Homebrew tap.
- Phosphene GitHub: MLX-native Apple Silicon panel and hardware tiering.
- LTX-2 license: custom community license with revenue and use restrictions, so not unrestricted.
- LTX-2 ComfyUI docs: ComfyUI integration, but CUDA 32 GB+ VRAM and 100 GB+ disk requirement for the documented local path.
- WanGP/Wan2GP GitHub: strong low-VRAM model support, but not Apple Silicon-first.
- PyTorch official install docs: macOS support and Python 3.10+ requirement.
