# Local Video Setup Status

Last updated: 2026-05-31

## Installed

- Homebrew toolchain available under `/opt/homebrew`.
- `git-lfs` 3.7.1.
- `ffmpeg` 8.1.1.
- `aria2` 1.37.0_2.
- `uv` 0.11.17.
- Python 3.12.13.
- Draw Things macOS app 1.20260518.2 installed at `/Applications/Draw Things.app`.
- Draw Things currently has an in-progress FLUX.1 Schnell Q8 partial download:
  - `~/Library/Containers/com.liuliu.draw-things/Data/Documents/Models/flux_1_schnell_q8p.ckpt.partial`
- ComfyUI cloned into `apps/ComfyUI`.
- ComfyUI virtual environment at `apps/ComfyUI/.venv`.
- ComfyUI Manager installed in `apps/ComfyUI/custom_nodes/comfyui-manager`.
- VideoHelperSuite installed in `apps/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite`.
- Wan2.2 TI2V 5B starter files installed:
  - `apps/ComfyUI/models/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors`
  - `apps/ComfyUI/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors`
  - `apps/ComfyUI/models/vae/wan2.2_vae.safetensors`

## Verified

- ComfyUI starts at `http://127.0.0.1:8188`.
- ComfyUI reports device `mps`.
- API sees the Wan model files in `diffusion_models`, `text_encoders`, and `vae`.
- Safetensors headers open successfully for all three Wan files.
- Tiny Wan2.2 smoke render completed successfully.
- Draw Things launches with `open -a "Draw Things"`.
- Smoke output:
  - `apps/ComfyUI/output/video/smoke_test_00001_.mp4`
  - 128x128 H.264 MP4, 1 second, verified with `ffprobe`.
- Smoke prompt runtime: about 92 seconds.

## Run

For Draw Things:

```bash
open -a "Draw Things"
```

Use `DRAW_THINGS_QUICKSTART.md` for conservative first image-to-video settings.

For ComfyUI:

From `/Users/warren/Projects/Local-models`:

```bash
scripts/start-comfyui.sh
```

Then open:

```text
http://127.0.0.1:8188
```

## Notes

- ComfyUI must run outside the command sandbox to access Apple Metal/MPS.
- The sandboxed PyTorch check reports MPS unavailable, but the same venv reports MPS available outside the sandbox and ComfyUI runs on `mps`.
- The first real creative Wan2.2 run should stay conservative: use image-to-video when possible, low resolution, short frame count, batch size 1.
- Use `caffeinate -dimsu -t 7200` during large Draw Things model downloads so display/system sleep does not stall the transfer.
- `apps/`, `models/`, `outputs/`, caches, and generated media are ignored by Git.
