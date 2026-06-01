# Draw Things Quickstart

Last updated: 2026-05-31

## What This Is For

Draw Things is the easiest local-first creative UI to try on this MacBook Air M5. Use it for interactive image and video experiments when ComfyUI feels too slow or too workflow-heavy.

ComfyUI remains the reproducible open-source backend in this repo. Draw Things is installed as the Mac-native creator app.

## Installed App

Installed with Homebrew Cask:

```bash
brew install --cask draw-things
```

Installed app:

```text
/Applications/Draw Things.app
```

Installed version verified locally:

```text
1.20260518.2
```

Launch it with:

```bash
open -a "Draw Things"
```

## Keep The Mac Awake During Model Downloads

Large model downloads can stall if the Mac idles, the display sleeps, or the lid closes. Before starting a multi-GB download, run this in Terminal to keep the Mac awake for two hours:

```bash
caffeinate -dimsu -t 7200
```

Keep that Terminal window open until the download finishes. To stop it early, press `Control-C`.

The current FLUX.1 Schnell Draw Things download may appear as a `.partial` file until it completes. That is normal.

## First-Run Rules For This Mac

This machine has 16 GB unified memory, so start small:

- Keep generation local. Do not enable cloud/API compute for this local setup unless explicitly choosing to.
- Prefer image-to-video over text-to-video. A strong starting image gives the video model much more structure.
- Prefer the smallest Wan 2.2 local video preset available in Draw Things, ideally a 5B, distilled, quantized, or "fast" variant.
- Avoid 14B video models, 720p presets, high-frame-count presets, and multi-minute workflows at first.
- Avoid LTX-2/LTX-2.3 as the default because the license is not unrestricted and the models are heavy for 16 GB.
- Keep at least 100 GB free on disk.

## Recommended First Test

1. Open Draw Things.
2. In model download/model manager, search for a lightweight permissive image model first, such as FLUX.1 Schnell if available.
3. Generate one still image at a small size, for example 512x512 or 768x512.
4. Save or keep that image as the source frame.
5. Switch to image-to-video if the app exposes it for the selected video model.
6. Search for Wan 2.2 and pick the smallest local variant available.
7. Use conservative video settings:
   - 384x224 or 512x288.
   - 16 to 33 frames.
   - 8 fps.
   - Batch size 1.
   - Low/fast quality preset first.
8. Prompt for motion, not an entire scene rebuild. Example:

```text
Subtle handheld camera movement, warm lamp flicker, the subject breathes gently, soft natural motion, coherent scene
```

## What Good Looks Like

A good first result is not a polished film. It is:

- The source image remains recognizable.
- Motion is visible and not just flashing colors.
- The Mac stays responsive.
- The app finishes without memory pressure warnings or crashes.

After that, increase only one thing at a time: frames, resolution, quality/steps, or prompt complexity.

## If Output Is Just Flashing Colors

That usually means the model does not have enough visual anchor or the settings are too ambitious.

Try this order:

1. Use image-to-video instead of text-to-video.
2. Lower resolution to 384x224.
3. Use 16 frames before 33 frames.
4. Keep fps at 8.
5. Use a simple motion-only prompt.
6. Try a different smaller Wan 2.2 preset if Draw Things offers multiple variants.

## Optional CLI Track

Draw Things also publishes a GPLv3 command-line tool through its own Homebrew tap. This is optional and not required to run the app:

```bash
brew tap drawthingsai/draw-things
brew install draw-things-cli
```

Only install this after the GUI workflow is useful, because the immediate goal is interactive local video creation.

## Sources

- Draw Things official site: https://drawthings.ai/
- Homebrew Cask entry for Draw Things: https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/d/draw-things.rb
- Draw Things CLI announcement: https://releases.drawthings.ai/p/draw-things-cli-local-media-generation
