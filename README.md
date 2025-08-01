# iTerm Color Schemes

- [Intro](#intro)
- [Installation Instructions](#installation-instructions)
- [Contribute](#contribute)
- [Screenshots](#screenshots)
- [Credits](#credits)
- [Extra](#extra)
  - [Previewing color schemes](#previewing-color-schemes)
  - [X11 Installation](#x11-installation)
  - [Konsole color schemes](#konsole-color-schemes)
  - [Terminator color schemes](#terminator-color-schemes)
  - [Mac OS Terminal color schemes](#terminal-color-schemes)
  - [PuTTY color schemes](#putty-color-schemes)
  - [Xfce Terminal color schemes](#xfce-terminal-color-schemes)
  - [FreeBSD vt(4) color schemes](#freebsd-vt-color-schemes)
  - [MobaXterm color schemes](#mobaxterm-color-schemes)
  - [LXTerminal color schemes](#lxterminal-color-schemes)
  - [Visual Studio Code color schemes](#visual-studio-code-color-schemes)
  - [Windows Terminal color schemes](#windows-terminal-color-schemes)
  - [Alacritty color schemes](#alacritty-color-schemes)
  - [Ghostty color schemes](#ghostty-color-schemes)
  - [Termux color schemes](#termux-color-schemes)
  - [Generic color schemes](#generic-color-schemes)

## Intro

This is a set of color schemes for iTerm (aka iTerm2). It also includes ports to Terminal, Konsole, PuTTY, Xresources, XRDB, Remmina, Termite, XFCE, Tilda, FreeBSD VT, Terminator, Kitty, Ghostty, MobaXterm, LXTerminal, Microsoft's Windows Terminal, Visual Studio, Alacritty

Screenshots below and in the [screenshots](screenshots/) directory.

## Installation Instructions

There are 3 ways to install an iTerm theme:

- Direct way via keyboard shortcut:

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Type CMD+i (⌘+i)
  - Navigate to **Colors** tab
  - Click on **Color Presets**
  - Click on **Import**
  - Click on the **schemes** folder
  - Select the **.itermcolors** profiles you would like to import
  - Click on **Color Presets** and choose a color scheme

- Via iTerm preferences (go to the same configuration location as above):

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Click on **iTerm2** menu title
  - Select **Preferences...** option
  - Select **Profiles**
  - Navigate to **Colors** tab
  - Click on **Color Presets**
  - Click on **Import**
  - Select the .itermcolors file(s) of the [schemes](schemes/) you'd like to use \* Click on **Color Presets** and choose a color scheme

- Via Bash script

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Run the following command:

  ```sh
  # Import all color schemes
  tools/import-scheme.sh schemes/*

  # Import all color schemes (verbose mode)
  tools/import-scheme.sh -v schemes/*

  # Import specific color schemes (quotations are needed for schemes with spaces in name)
  tools/import-scheme.sh 'schemes/SpaceGray Eighties.itermcolors' # by file path
  tools/import-scheme.sh 'SpaceGray Eighties'       # by scheme name
  tools/import-scheme.sh Molokai 'SpaceGray Eighties'     # import multiple
  ```

  - Restart iTerm 2. (Need to quit iTerm 2 to reload the configuration file.)

## Contribute

### Using Docker

If docker is installed, the script `generate-all.sh` will do most of the
steps described in [Prerequisits](#prerequisits), except for the instructions
related to `pyenv` as this is not required in a docker container dedicated to
generating the required files.

With docker, there is no need to install python and its dependencies on your
computer.

The remaining manual tasks are to update `README.md` to include your theme and
screenshot, and to update `CREDITS.md` to credit yourself for your contribution.

#### Debugging using Docker

In cases where new tools have to be tested, `./generate-all.sh debug` will start
an interactive terminal session inside the container.

### Prerequisites

1. For convenient work with generation scripts, it is recommended to install [pyenv](https://github.com/pyenv/pyenv).
2. Run `pyenv install` inside project folder to install python version from `.python-version` file.
3. Run `pip install -r requirements.txt` to install the project dependencies.

### How to add new theme

Have a great theme? Send it to me via a Pull Request!

#### Have an iTerm theme?

1. Get your theme's`.itermcolors` file.
   - Launch iTerm 2
   - Type CMD+i (⌘+i)
   - Navigate to **Colors** tab
   - Click on **Color Presets**
   - Click on **Export**
   - Save the .itermcolors file
   - Adjust the [Color Space](#color-space)
2. Put your theme file into `/schemes/`
   - `mv <your-itermcolors-file> schemes/`
3. Continue with the "Create derived versions" below.

##### Color Space

iTerm seems to store the colors in its color presets in P3 color space.
The tools only can handle sRGB color space.
To convert an `.itermcolors` file int sRGB color space, use the provided `p3tosRGB.py` tool:

```shell
python3 tools/p3tosRGB.py schemes/YOUR_SCHEME
```

When using Docker:

```shell
./generate-all.sh debug
python3 tools/p3tosRGB.py schemes/YOUR_SCHEME
```

This will overwrite your scheme with a converted version.

#### Have a theme in another format?

1. Convert it to the YAML format specified in `yaml/README.md`.
   This is an extension of the format supported by the [Gogh](https://github.com/Gogh-Co/Gogh/) project.
   - If it helps, you can use `tools/kitty_to_yaml.py` and `tools/ghostty_to_yaml.py`.
     These tools accept configuration file streamed into stdin, and output a YAML fragment to stdout.
2. Put the YAML file in `yaml/`, with the `.yml` extension.
3. Continue with the "Create derived versions" below.

#### Create derived versions

If you have `make` installed, steps 1 to 4 can be run with `make` from the root of the repository.

1. Generate other formats for your theme using the `gen.py` script.
   - `python3 tools/gen.py`
2. If you only want to generate files for your theme, you can specify this with the `-s` flag.
   - `python3 tools/gen.py -s Dracula`
3. Generate a screenshot of your theme using the `screenshot_gen` tool.
   - `pushd tools && python3 -m screenshot_gen && popd`. This will generate new screenshots where they are missing.
   - If you have `oxipng` or `zopflipng` installed, the screenshot will be optimized for you.
4. Run `generate_screenshots_readme.py` to include your theme's screenshot in the `screenshots/README.md` file:
   - `python3 tools/generate_screenshots_readme.py`

#### Add your theme to the README

1. Update `README.md` to include your theme and screenshot. Also update `CREDITS.md` to credit yourself for your contribution.

### How to add new template

Do you want to convert existing iTerm themes to themes for your favorite terminal/editor/etc?

1. Get config file from your terminal/editor/etc.
2. Change actual colors in config to template placeholders from the list below.

```
  {{ Background_Color }}
  {{ Bold_Color }}
  {{ Cursor_Color }}
  {{ Cursor_Text_Color }}
  {{ Foreground_Color }}
  {{ Selected_Text_Color }}
  {{ Selection_Color }}
  {{ Ansi_0_Color }} // black
  {{ Ansi_1_Color }} // red
  {{ Ansi_2_Color }} // green
  {{ Ansi_3_Color }} // yellow
  {{ Ansi_4_Color }} // blue
  {{ Ansi_5_Color }} // magenta
  {{ Ansi_6_Color }} // cyan
  {{ Ansi_7_Color }} // white
  {{ Ansi_8_Color }} // bright black
  {{ Ansi_9_Color }} // bright red
  {{ Ansi_10_Color }} // bright green
  {{ Ansi_11_Color }} // bright yellow
  {{ Ansi_12_Color }} // bright blue
  {{ Ansi_13_Color }} // bright magenta
  {{ Ansi_14_Color }} // bright cyan
  {{ Ansi_15_Color }} // bright white

  Each color has these fields:
 - {{ Background_Color.hex }} for hex representation
 - {{ Background_Color.rgb }} for rgb representation as a "(r, g, b)" string
 - {{ Backgroun_Color.guint16 }} for guint16 representation

  Also you have access to this metadata fields:
 - {{ Guint16_Palette }} with a string containing all ansi colors as guint16 values
 - {{ Dark_Theme }} which contains a sign that the theme is dark
```

3. If you need a new value type for color, add it too `tools/converter.py`
4. Put your template file into `tool/templates`. A folder with schemas will be created based on the filename. And the file extension will remain with all generated ones. Example: `editor.ext` file will generate schemas as `editor/scheme_name.ext`
5. Generate all existing themes for all templates `cd tools/ && ./gen.py`. Or, if you only want to generate schemas for your template, you can use the `-t` flag.

- `./gen.py -t kitty`

6. If in the process you had to add new dependencies or update the version of python, do not forget to indicate this in `requirements.txt` or `.python-version`.

## Screenshots

### 0x96f

![Screenshot](screenshots/0x96f.png)

### 12-bit Rainbow

![Screenshot](screenshots/12-bit_rainbow.png)

### 3024 Day

![Screenshot](screenshots/3024_day.png)

### 3024 Night

![Screenshot](screenshots/3024_night.png)

### Aardvark Blue

![Screenshot](screenshots/aardvark_blue.png)

### Abernathy

![Screenshot](screenshots/abernathy.png)

### Adventure

![Screenshot](screenshots/adventure.png)

### AdventureTime

![Screenshot](screenshots/adventure_time.png)

### Adwaita Dark

![Screenshot](screenshots/adwaita_dark.png)

### Adwaita

![Screenshot](screenshots/adwaita.png)

### Afterglow

![Screenshot](screenshots/afterglow.png)

### Alabaster

![Screenshot](screenshots/alabaster.png)

### AlienBlood

![Screenshot](screenshots/alien_blood.png)

### Andromeda

![Screenshot](screenshots/andromeda.png)

### Apple Classic

![Screenshot](screenshots/apple-classic.png)

### Apple System Colors

![Screenshot](screenshots/apple-system-colors.png)

### Apple System Colors Light

![Screenshot](screenshots/apple_system_colors_light.png)

### Arcoiris

![Screenshot](screenshots/arcoiris.png)

### Ardoise

![Screenshot](screenshots/ardoise.png)

### Argonaut

![Screenshot](screenshots/argonaut.png)

### Arthur

![Screenshot](screenshots/arthur.png)

### AtelierSulphurpool

![Screenshot](screenshots/atelier-sulphurpool_dark.png)

### Atom

![Screenshot](screenshots/atom.png)

### Atom One Dark

![Screenshot](screenshots/atom_one_dark.png)

### Atom One Light

![Screenshot](screenshots/atom_one_light.png)

### ayu

![Screenshot](screenshots/ayu.png)

### ayu Light

![Screenshot](screenshots/ayu_light.png)

### ayu Mirage

![Screenshot](screenshots/ayu_mirage.png)

### Aura

![Screenshot](screenshots/aura.png)

### Aurora

![Screenshot](screenshots/aurora.png)

### Banana Blueberry

![Screenshot](screenshots/banana_blueberry.png)

### Batman

![Screenshot](screenshots/batman.png)

### Belafonte Day

![Screenshot](screenshots/belafonte_day.png)

### Belafonte Night

![Screenshot](screenshots/belafonte_night.png)

### BirdsOfParadise

![Screenshot](screenshots/birds_of_paradise.png)

### Black Metal (Bathory)

![Screenshot](screenshots/black_metal_bathory.png)

### Black Metal (Burzum)

![Screenshot](screenshots/black_metal_burzum.png)

### Black Metal (Dark Funeral)

![Screenshot](screenshots/black_metal_dark_funeral.png)

### Black Metal (Gorgoroth)

![Screenshot](screenshots/black_metal_gorgoroth.png)

### Black Metal (Immortal)

![Screenshot](screenshots/black_metal_immortal.png)

### Black Metal (Khold)

![Screenshot](screenshots/black_metal_khold.png)

### Black Metal (Marduk)

![Screenshot](screenshots/black_metal_marduk.png)

### Black Metal (Mayhem)

![Screenshot](screenshots/black_metal_mayhem.png)

### Black Metal (Nile)

![Screenshot](screenshots/black_metal_nile.png)

### Black Metal (Venom)

![Screenshot](screenshots/black_metal_venom.png)

### Black Metal

![Screenshot](screenshots/black_metal.png)

### Blazer

![Screenshot](screenshots/blazer.png)

### BlueBerry Pie

![Screenshot](screenshots/blueberry_pie.png)

### BlueDolphin

![Screenshot](screenshots/BlueDolphin.png)

### Blue Matrix

![Screenshot](screenshots/blue_matrix.png)

### Bluloco Dark

![Screenshot](screenshots/bluloco_dark.png)

### Bluloco Light

![Screenshot](screenshots/bluloco_light.png)

### Borland

![Screenshot](screenshots/borland.png)

### Box

![Screenshot](screenshots/box.png)

### Breadog

![Screenshot](screenshots/breadog.png)

### Breeze

![Screenshot](screenshots/breeze.png)

### Bright Lights

![Screenshot](screenshots/bright_lights.png)

### Broadcast

![Screenshot](screenshots/broadcast.png)

### Brogrammer

![Screenshot](screenshots/brogrammer.png)

### C64

![Screenshot](screenshots/c64.png)

### Calamity

![Screenshot](screenshots/calamity.png)

### Catppuccin Frappé

![Screenshot](screenshots/catppuccin-frappe.png)

### Catppuccin Latte

![Screenshot](screenshots/catppuccin-latte.png)

### Catppuccin Macchiato

![Screenshot](screenshots/catppuccin-macchiato.png)

### Catppuccin Mocha

![Screenshot](screenshots/catppuccin-mocha.png)

### CGA

![Screenshot](screenshots/cga.png)

### Chalk

![Screenshot](screenshots/chalk.png)

### Chalkboard

![Screenshot](screenshots/chalkboard.png)

### ChallengerDeep

![Screenshot](screenshots/challenger_deep.png)

### Chester

![Screenshot](screenshots/chester.png)

### Ciapre

![Screenshot](screenshots/ciapre.png)

### Citruszest

![Screenshot](screenshots/citruszest.png)

### CLRS

![Screenshot](screenshots/clrs.png)

### Cobalt Neon

![Screenshot](screenshots/cobalt_neon.png)

### Cobalt2

![Screenshot](screenshots/cobalt2.png)

### Coffee

![Screenshot](screenshots/Coffee.png)

### CrayonPonyFish

### CutiePro

![Screenshot](screenshots/CutiePro.png)

![Screenshot](screenshots/crayon_pony_fish.png)

### Cyberdyne

![Screenshot](screenshots/cyberdyne.png)

### Cyberpunk

![Screenshot](screenshots/cyberpunk.png)

### Cyberpunk Scarlet Protocol

![Screenshot](screenshots/cyberpunk_scarlet_protocol.png)

### Dark Modern

![Screenshot](screenshots/dark_modern.png)

### Dark Pastel

![Screenshot](screenshots/dark_pastel.png)

### Dark+

![Screenshot](screenshots/dark_plus.png)

### Darkside

![Screenshot](screenshots/darkside.png)

### Dayfox

![Screenshot](screenshots/dayfox.png)

### Deep

![Screenshot](screenshots/deep.png)

### Desert

![Screenshot](screenshots/desert.png)

### Detuned

![Screenshot](screenshots/detuned.png)

### Dimidium

![Screenshot](screenshots/dimidium.png)

### DimmedMonokai

![Screenshot](screenshots/dimmed_monokai.png)

### Django

![Screenshot](screenshots/django.png)

### DjangoRebornAgain

![Screenshot](screenshots/DjangoRebornAgain.png)

### DjangoSmoothy

![Screenshot](screenshots/DjangoSmoothy.png)

### Doom One

![Screenshot](screenshots/doom_one.png)

### Doom Peacock

![Screenshot](screenshots/doom_peacock.png)

### DotGov

![Screenshot](screenshots/dot_gov.png)

### Dracula

![Screenshot](screenshots/dracula.png)

### Dracula+

![Screenshot](screenshots/dracula+.png)

### Duckbones

![Screenshot](screenshots/duckbones.png)

### Duotone Dark

![Screenshot](screenshots/duotone_dark.png)

### Earthsong

![Screenshot](screenshots/earthsong.png)

### Electron Highlighter

![Screenshot](screenshots/electron-highlighter.png)

### Elegant

![Screenshot](screenshots/elegant.png)

### Elemental

![Screenshot](screenshots/elemental.png)

### Elementary

![Screenshot](screenshots/elementary.png)

### Embers

![Screenshot](screenshots/embers.png)

### ENCOM

![Screenshot](screenshots/encom.png)

### Espresso

![Screenshot](screenshots/espresso.png)

### Espresso Libre

![Screenshot](screenshots/espresso_libre.png)

### Everblush

![Screenshot](screenshots/everblush.png)

### Everforest Dark - Hard

![Screenshot](screenshots/everforest_dark_hard.png)

### Everforest Light - Med

![Screenshot](screenshots/everforest_light_med.png)

### Fairyfloss

![Screenshot](screenshots/fairyfloss.png)

### Fahrenheit

![Screenshot](screenshots/fahrenheit.png)

### Farmhouse Dark

![Screenshot](screenshots/farmhouse-dark.png)

### Farmhouse Light

![Screenshot](screenshots/farmhouse-light.png)

### Fideloper

![Screenshot](screenshots/fideloper.png)

### Firefly Traditional

![Screenshot](screenshots/firefly-traditional.png)

### FirefoxDev

![Screenshot](screenshots/firefox_dev.png)

### Firewatch

![Screenshot](screenshots/firewatch.png)

### FishTank

![Screenshot](screenshots/fish_tank.png)

### Flat

![Screenshot](screenshots/flat.png)

### Flatland

![Screenshot](screenshots/flatland.png)

### Flexoki Dark

![Screenshot](screenshots/flexoki-dark.png)

### Flexoki Light

![Screenshot](screenshots/flexoki-light.png)

### Floraverse

![Screenshot](screenshots/floraverse.png)

### Forest Blue

![Screenshot](screenshots/forest_blue.png)

### Framer

![Screenshot](screenshots/framer.png)

### FrontEndDelight

![Screenshot](screenshots/front_end_delight.png)

### FunForrest

![Screenshot](screenshots/fun_forrest.png)

### Galaxy

![Screenshot](screenshots/galaxy.png)

### Galizur

![image](screenshots/galizur.png)

### Ghostty Default StyleDark

![image](screenshots/Ghostty_Default_StyleDark.png)

### GitHub Dark Default

![image](screenshots/github-dark-default.png)

### GitHub Dark Dimmed

![image](screenshots/github-dark-dimmed.png)

### GitHub Dark Colorblind

![image](screenshots/github-dark-colorblind.png)

### GitHub Dark High Contrast

![image](screenshots/github-dark-high-contrast.png)

### GitHub Light Default

![image](screenshots/github-light-default.png)

### GitHub Light Colorblind

![image](screenshots/github-light-colorblind.png)

### GitHub Light High Contrast

![image](screenshots/github-light-high-contrast.png)

### Github

![Screenshot](screenshots/github.png)

### GitHub Dark

![Screenshot](screenshots/github_dark.png)

### GitLab Dark

![Screenshot](screenshots/git_lab-dark.png)

### GitLab Dark Grey

![Screenshot](screenshots/git_lab-dark-grey.png)

### GitLab Light

![Screenshot](screenshots/git_lab-light.png)

### Glacier

![Screenshot](screenshots/glacier.png)

### Grape

![Screenshot](screenshots/grape.png)

### Grass

![Screenshot](screenshots/grass.png)

### Grey-green

![Screenshot](screenshots/grey-green.png)

### Gruber Darker

![Screenshot](screenshots/gruber-darker.png)

### Gruvbox Dark

![Screenshot](screenshots/gruvbox_dark.png)

### Gruvbox Dark Hard

![Screenshot](screenshots/gruvbox_dark_hard.png)

### Gruvbox Light

![Screenshot](screenshots/gruvbox_light.png)

### Gruvbox Light Hard

![Screenshot](screenshots/gruvbox_light_hard.png)

### gruvbox_material

![Screenshot](screenshots/gruvbox_material.png)

### Guezwhoz

![Screenshot](screenshots/guezwhoz.png)

### Hacktober

![Screenshot](screenshots/hacktober.png)

### Hardcore

![Screenshot](screenshots/hardcore.png)

### Harper

![Screenshot](screenshots/harper.png)

### Havn Daggry

![Screenshot](screenshots/havn_daggry.png)

### Havn Skumring

![Screenshot](screenshots/havn_skumring.png)

### HaX0R_R3D

![Screenshot](screenshots/hax0r_r3d.png)

### HaX0R_GR33N

![Screenshot](screenshots/hax0r_gr33n.png)

### HaX0R_BLUE

![Screenshot](screenshots/hax0r_blue.png)

### heeler

![Screenshot](screenshots/heeler.png)

### Highway

![Screenshot](screenshots/highway.png)

### Hipster Green

![Screenshot](screenshots/hipster_green.png)

### Hivacruz

![Screenshot](screenshots/hivacruz.png)

### Homebrew

![Screenshot](screenshots/homebrew.png)

### Hopscotch

![Screenshot](screenshots/hopscotch.png)

### Hopscotch 256

![Screenshot](screenshots/hopscotch_256.png)

### Horizon

![Screenshot](screenshots/horizon.png)

### Horizon Bright

![Screenshot](screenshots/horizon-bright.png)

### Hurtado

![Screenshot](screenshots/hurtado.png)

### Hybrid

![Screenshot](screenshots/hybrid.png)

### IC_Green_PPL

![Screenshot](screenshots/ic_green_ppl.png)

### IC_Orange_PPL

![Screenshot](screenshots/ic_orange_ppl.png)

### iceberg

![Screenshot](screenshots/iceberg.png)

### IDEA Dark

![Screenshot](screenshots/idea.png)

### idleToes

![Screenshot](screenshots/idleToes.png)

### IR_Black

![Screenshot](screenshots/ir_black.png)

### IRIX Console

![Screenshot](screenshot/irix_console.png)

### IRIX Terminal

![Screenshot](screenshot/irix_terminal.png)

### iTerm2 Default

![Screenshot](screenshots/iterm2-default.png)

### iTerm2 Dark Background

![Screenshot](screenshots/iterm2-dark-background.png)

### iTerm2 Light Background

![Screenshot](screenshots/iterm2-light-background.png)

### iTerm2 Pastel (Dark Background)

![Screenshot](screenshots/iterm2-pastel-dark-background.png)

### iTerm2 Smoooooth

![Screenshot](screenshots/iterm2-smoooooth.png)

### iTerm2 Solarized Dark

![Screenshot](screenshots/iterm2-solarized-dark.png)

### iTerm2 Solarized Light

![Screenshot](screenshots/iterm2-solarized-light.png)

### iTerm2 Tango Dark

![Screenshot](screenshots/iterm2-tango-dark.png)

### iTerm2 Tango Light

![Screenshot](screenshots/iterm2-tango-light.png)

### Jackie Brown

![Screenshot](screenshots/jackie_brown.png)

### Japanesque

![Screenshot](screenshots/japanesque.png)

### Jellybeans

![Screenshot](screenshots/jellybeans.png)

### JetBrains Darcula

![Screenshot](screenshots/jetbrains_darcula.png)

### Jubi

![Screenshot](screenshots/jubi.png)

### Kanagawa Dragon

![Screenshot](screenshots/kanagawa-dragon.png)

### Kanagawa Wave

![Screenshot](screenshots/kanagawa-wave.png)

### Kanagawabones

![Screenshot](screenshots/kanagawabones.png)

### Kibble

![Screenshot](screenshots/kibble.png)

### Kolorit

![Screenshot](screenshots/kolorit.png)

### Konsolas

![Screenshot](screenshots/konsolas.png)

### Kurokula

![Screenshot](screenshots/kurokula.png)

### Lab Fox

![Screenshot](screenshots/lab_fox.png)

### Laser

![Screenshot](screenshots/laser.png)

### Later This Evening

![Screenshot](screenshots/later_this_evening.png)

### Lavandula

![Screenshot](screenshots/lavandula.png)

### Light Owl

![Screenshot](screenshots/light_owl.png)

### LiquidCarbon

![Screenshot](screenshots/liquid_carbon.png)

### LiquidCarbonTransparent

![Screenshot](screenshots/liquid_carbon_transparent.png)

### LiquidCarbonTransparentInverse

![Screenshot](screenshots/liquid_carbon_transparent_inverse.png)

### LoveLace

![Screenshot](screenshots/lovelace.png)

### Man Page

![Screenshot](screenshots/man_page.png)

### Mariana

![Screenshot](screenshots/mariana.png)

### Material

![Screenshot](screenshots/material.png)

### MaterialDark

![Screenshot](screenshots/material_dark.png)

### MaterialDarker

![Screenshot](screenshots/material_darker.png)

### MaterialDesignColors

![Screenshot](screenshots/material_design_colors.png)

### MaterialOcean

![Screenshot](screenshots/material_ocean.png)

### Mathias

![Screenshot](screenshots/mathias.png)

### Matrix

![Screenshot](screenshots/matrix.png)

### Dark Matrix

![Screenshot](screenshots/darkmatrix.png)

### Darker Matrix

![Screenshot](screenshots/darkermatrix.png)

### Melange Light

![Screenshot](screenshots/melange_light.png)

### Melange Dark

![Screenshot](screenshots/melange_dark.png)

### Medallion

![Screenshot](screenshots/medallion.png)

### Mellifluous

![Screenshot](screenshots/mellifluous.png)

### Mellow

![Screenshot](screenshots/mellow.png)

### Miasma

![Screenshot](screenshots/miasma.png)

### Midnight In Mojave

![Screenshot](screenshots/midnight_in_mojave.png)

### Mirage

![Screenshot](screenshots/mirage.png)

### Misterioso

![Screenshot](screenshots/misterioso.png)

### Molokai

![Screenshot](screenshots/molokai.png)

### MonaLisa

![Screenshot](screenshots/mona_lisa.png)

### Monokai Classic

![Screenshot](screenshots/monokai-classic.png)

### Monokai Pro

![Screenshot](screenshots/monokai-pro.png)

### Monokai Pro Octagon

![Screenshot](screenshots/monokai-pro-octagon.png)

### Monokai Pro Machine

![Screenshot](screenshots/monokai-pro-machine.png)

### Monokai Pro Ristretto

![Screenshot](screenshots/monokai-pro-ristretto.png)

### Monokai Pro Spectrum

![Screenshot](screenshots/monokai-pro-spectrum.png)

### Monokai Pro Light

![Screenshot](screenshots/monokai-pro-light.png)

### Monokai Pro Light Sun

![Screenshot](screenshots/monokai-pro-light-sun.png)

### Monokai Remastered

![Screenshot](screenshots/monokai_remastered.png)

### Monokai Soda

![Screenshot](screenshots/monokai_soda.png)

### Monokai Vivid

![Screenshot](screenshots/monokai_vivid.png)

### moonfly

![Screenshot](screenshots/moonfly.png)

### N0tch2k

![Screenshot](screenshots/n0tch2k.png)

### Neobones Dark

![Screenshot](screenshots/neobones_dark.png)

### Neobones Light

![Screenshot](screenshots/neobones_light.png)

### Neon

![Screenshot](screenshots/neon.png)

### Neopolitan

![Screenshot](screenshots/neopolitan.png)

### Neutron

![Screenshot](screenshots/neutron.png)

### Nightfox

![Screenshot](screenshots/nightfox.png)

### NightLion v1

![Screenshot](screenshots/nightlion_v1.png)

### NightLion v2

![Screenshot](screenshots/nightlion_v2.png)

### Night Owl

![Screenshot](screenshots/night_owl.png)

### Night Owlish Light

![Screenshot](screenshots/night_owlish_light.png)

### Niji

![Screenshot](screenshots/niji.png)

### Novel

![Screenshot](screenshots/novel.png)

### Nocturnal Winter

![Screenshot](screenshots/nocturnal_winter.png)

### Nord

![Screenshot](screenshots/nord.png)

### Nord-light

![Screenshot](screenshots/nord_light.png)

### Nord-wave

![Screenshot](screenshots/nord-wave.png)

### NvimDark

![Screenshot](screenshots/NvimDark.png)

### NvimLight

![Screenshot](screenshots/NvimLight.png)

### Obsidian

![Screenshot](screenshots/obsidian.png)

### Ocean

![Screenshot](screenshots/ocean.png)

### OceanicMaterial

![Screenshot](screenshots/oceanic_material.png)

### Oceanic Next

![Screenshot](screenshots/oceanic_next.png)

### Ollie

![Screenshot](screenshots/ollie.png)

### One Double Dark

![Screenshot](screenshots/one_double_dark.png)

### One Double Light

![Screenshot](screenshots/one_double_light.png)

### One Half Dark

![Screenshot](screenshots/onehalfdark.png)

### One Half Light

![Screenshot](screenshots/onehalflight.png)

### Operator Mono Dark

![Screenshot](screenshots/operator_mono_dark.png)

### Overnight Slumber

![Screenshot](screenshots/overnight_slumber.png)

### Oxocarbon

![Screenshot](screenshots/oxocarbon.png)

### Palenight High Contrast

![Screenshot](screenshots/PaleNightHC.png)

### Pandora

![Screenshot](screenshots/pandora.png)

### Paraiso Dark

![Screenshot](screenshots/paraiso_dark.png)

### PaulMillr

![Screenshot](screenshots/paul_millr.png)

### Pencil Dark

![Screenshot](screenshots/pencil_dark.png)

### Pencil Light

![Screenshot](screenshots/pencil_light.png)

### Peppermint

![Screenshot](screenshots/peppermint.png)

### Piatto Light

![Screenshot](screenshots/piatto_light.png)

### Pnevma

![Screenshot](screenshots/pnevma.png)

### Popping and Locking

![Screenshot](screenshots/popping_and_locking.png)

### Primary

![Screenshot](screenshots/primary.png)

### Pro

![Screenshot](screenshots/pro.png)

### Pro Light

![Screenshot](screenshots/pro_light.png)

### Purple Peter

![Screenshot](screenshots/purplepeter.png)

### Purple Rain

![Screenshot](screenshots/purple_rain.png)

### Rapture

![Screenshot](screenshots/rapture.png)

### Raycast Dark

![Screenshot](screenshots/raycast_dark.png)

### Raycast Light

![Screenshot](screenshots/raycast_light.png)

### Rebecca

![Screenshot](screenshots/rebecca.png)

### Red Alert

![Screenshot](screenshots/red_alert.png)

### Red Planet

![Screenshot](screenshots/red_planet.png)

### Red Sands

![Screenshot](screenshots/red_sands.png)

### Relaxed

![Screenshot](screenshots/relaxed.png)

### Retro

![Screenshot](screenshots/retro.png)

### RetroLegends

![image](screenshots/RetroLegends.png)

### Rippedcasts

![Screenshot](screenshots/rippedcasts.png)

### Rosé Pine

![Screenshot](screenshots/rose-pine.png)

### Rosé Pine Dawn

![Screenshot](screenshots/rose-pine-dawn.png)

### Rosé Pine Moon

![Screenshot](screenshots/rose-pine-moon.png)

### Rouge 2

![Screenshot](screenshots/rouge_2.png)

### Royal

![Screenshot](screenshots/royal.png)

### Ryuuko

![Screenshot](screenshots/ryuuko.png)

### Sakura

![Screenshot](screenshots/sakura.png)

### Scarlet Protocol

![Screenshot](screenshots/scarlet_protocol.png)

### Seafoam Pastel

![Screenshot](screenshots/seafoam_pastel.png)

### SeaShells

![Screenshot](screenshots/sea_shells.png)

### Seoulbones Dark

![Screenshot](screenshots/seoulbones_dark.png)

### Seoulbones Light

![Screenshot](screenshots/seoulbones_light.png)

### Selenized Dark

![Screenshot](screenshots/selenized-dark.png)

### Selenized Light

![Screenshot](screenshots/selenized-light.png)

### Seti

![Screenshot](screenshots/seti.png)

### Shaman

![Screenshot](screenshots/shaman.png)

### Shades-Of-Purple

![Screenshot](screenshots/ShadesOfPurple.png)

### Slate

![Screenshot](screenshots/slate.png)

### SleepyHollow

![Screenshot](screenshots/SleepyHollow.png)

### Smyck

![Screenshot](screenshots/smyck.png)

### Snazzy Soft

![Screenshot](screenshots/snazzy_soft.png)

### Snazzy

![Screenshot](screenshots/snazzy.png)

### SoftServer

![Screenshot](screenshots/soft_server.png)

### Solarized Darcula (With background image)

![Screenshot](screenshots/solarized_darcula_with_background.png)

### Solarized Darcula (Without background image)

![Screenshot](screenshots/solarized_darcula.png)

### Solarized Dark - Patched

Some applications assume the ANSI color code 8 is a gray color. Solarized treats
this code as equal to the background. This theme is for people who prefer the
former. See issues [#59][issue-59], [#62][issue-62], and [#63][issue-63] for
more information.

![Screenshot](screenshots/solarized_dark_patched.png)

[issue-59]: https://github.com/mbadolato/iTerm2-Color-Schemes/issues/59
[issue-62]: https://github.com/mbadolato/iTerm2-Color-Schemes/issues/62
[issue-63]: https://github.com/mbadolato/iTerm2-Color-Schemes/pull/63

### Solarized Dark Higher Contrast

![Screenshot](screenshots/solarized_dark_higher_contrast.png)

### Solarized Osaka Night

![Screenshot](screenshots/solarized-osaka-night.png)

### Sonokai

![Screenshot](screenshots/sonokai.png)

### SpaceGray

![Screenshot](screenshots/space_gray.png)

### SpaceGray Bright

![Screenshot](screenshots/spacegray_bright.png)

### SpaceGray Eighties

![Screenshot](screenshots/spacegray_eighties.png)

### SpaceGray Eighties Dull

![Screenshot](screenshots/spacegray_eighties_dull.png)

### Spacedust

![Screenshot](screenshots/spacedust.png)

### Spiderman

![Screenshot](screenshots/spiderman.png)

### Spring

![Screenshot](screenshots/spring.png)

### Square

![Screenshot](screenshots/square.png)

### Squirrelsong Dark

![Screenshot](screenshots/squirrelsong_dark.png)

### Srcery

![Screenshot](screenshots/srcery.png)

### Starlight

![Screenshot](screenshots/starlight.png)

### Sublette

![Screenshot](screenshots/sublette.png)

### Subliminal

![Screenshot](screenshots/subliminal.png)

### Sugarplum

![Screenshot](screenshots/sugarplum.png)

### Sundried

![Screenshot](screenshots/sundried.png)

### Symfonic

![Screenshot](screenshots/symfonic.png)

### synthwave

![Screenshot](screenshots/synthwave.png)

### Synthwave Alpha

![Screenshot](screenshots/synthwave_alpha.png)

### Synthwave Everything

![Screenshot](screenshots/synthwave-everything.png)

### Tango Adapted

![Screenshot](screenshots/tango_adapted.png)

### Tango Half Adapted

![Screenshot](screenshots/tango_half_adapted.png)

### Tearout

![Screenshot](screenshots/tearout.png)

### Teerb

![Screenshot](screenshots/teerb.png)

### Terafox

![Screenshot](screenshots/terafox.png)

### Terminal Basic

![Screenshot](screenshots/terminal_basic.png)

### Thayer Bright

![Screenshot](screenshots/thayer_bright.png)

### The Hulk

![Screenshot](screenshots/the_hulk.png)

### Tinacious Design (Dark)

![Screenshot](screenshots/tinacious_design_dark.png)

### Tinacious Design (Light)

![Screenshot](screenshots/tinacious_design_light.png)

### TokyoNight

![Screenshot](screenshots/tokyonight.png)

### TokyoNight Storm

![Screenshot](screenshots/tokyonight-storm.png)

### TokyoNight Moon

![Screenshot](screenshots/tokyonight-moon.png)

### TokyoNight Day

![Screenshot](screenshots/tokyonight-day.png)

### TokyoNight Night

![Screenshot](screenshots/tokyonight-night.png)

### Tomorrow

![Screenshot](screenshots/tomorrow.png)

### Tomorrow Night

![Screenshot](screenshots/tomorrow_night.png)

### Tomorrow Night Blue

![Screenshot](screenshots/tomorrow_night_blue.png)

### Tomorrow Night Bright

![Screenshot](screenshots/tomorrow_night_bright.png)

### Tomorrow Night Eighties

![Screenshot](screenshots/tomorrow_night_eighties.png)

### Tomorrow Night Burns

![Screenshot](screenshots/tomorrow_night_burns.png)

### ToyChest

![Screenshot](screenshots/toy_chest.png)

### Treehouse

![Screenshot](screenshots/treehouse.png)

### Twilight

![Screenshot](screenshots/twilight.png)

### Ubuntu

![Screenshot](screenshots/ubuntu.png)

### UltraViolent

![Screenshot](screenshots/ultra_violent.png)

### UltraDark

![Screenshot](screenshots/ultradark.png)

### Under The Sea

![Screenshot](screenshots/under_the_sea.png)

### Unikitty

![Screenshot](screenshots/unikitty.png)

### Urple

![Screenshot](screenshots/urple.png)

### Vague

![Screenshot](screenshots/vague.png)

### Vaughn

![Screenshot](screenshots/vaughn.png)

### Vesper

![Screenshot](screenshots/vesper.png)

### VibrantInk

![Screenshot](screenshots/vibrant_ink.png)

### Vimbones

![Screenshot](screenshots/vimbones.png)

### Violet Light

![Screenshot](screenshots/violet_light.png)

### Violet Dark

![Screenshot](screenshots/violet_dark.png)

### WarmNeon

![Screenshot](screenshots/warm_neon.png)

### Wez

![Screenshot](screenshots/wez.png)

### Whimsy

![Screenshot](screenshots/whimsy.png)

### WildCherry

![Screenshot](screenshots/wild_cherry.png)

### Wilmersdorf

![Screenshot](screenshots/wilmersdorf.png)

### Wombat

![Screenshot](screenshots/wombat.png)

### Wryan

![Screenshot](screenshots/wryan.png)

### Xcode dark

![Screenshot](screenshots/xcodedark.png)

### Xcode dark (High Contrast)

![Screenshot](screenshots/xcodedarkhc.png)

### Xcode light

![Screenshot](screenshots/xcodelight.png)

### Xcode light (High Contrast)

![Screenshot](screenshots/xcodelighthc.png)

### Xcode WWDC

![Screenshot](screenshots/xcodewwdc.png)

### Zenbones

![Screenshot](screenshots/zenbones.png)

### Zenbones Dark

![Screenshot](screenshots/zenbones_dark.png)

### Zenbones Light

![Screenshot](screenshots/zenbones_light.png)

### Zenburn

![Screenshot](screenshots/zenburn.png)

### Zenburned

![Screenshot](screenshots/zenburned.png)

### Zenwritten Dark

![Screenshot](screenshots/zenwritten_dark.png)

### Zenwritten Light

![Screenshot](screenshots/zenwritten_light.png)

## Credits

- The schemes [_Novel_](#novel), [_Espresso_](#espresso), [_Grass_](#grass), [_Homebrew_](#homebrew), [_Ocean_](#ocean), [_Pro_](#pro), [_Man Page_](#man-page), [_Red Sands_](#red-sands), and [_Terminal Basic_](#terminal-basic) are ports of the schemes of the same name included with the Mac Terminal application. All of Terminal's schemes have now been ported, with the exception of _Solid Colors_ (random backgrounds, which iTerm doesn't support) and _Aerogel_ (which is hideous).
- The schemes [_iTerm2 Default_](#iterm2-default), [_iTerm2 Dark Background_](#iterm2-dark-background), [_iTerm2 Light Background_](#iterm2-light-background), [_iTerm2 Pastel (Dark Background)_](#iterm2-pastel-dark-background), [_iTerm2 Smoooooth_](#iterm2-smoooooth), [_iTerm2 Solarized Dark_](#iterm2-solarized-dark), [_iTerm2 Solarized Light_](#iterm2-solarized-light), [_iTerm2 Tango Dark_](#iterm2-tango-dark), and [_iTerm2 Tango Light_](#iterm2-tango-light) are ports from the built-in color schemes of iTerm2 (current source is iTerm2 v3.4.19).
- Credits for all other themes are listed in [CREDITS.md](./CREDITS.md)

If there are other color schemes you'd like to see included, drop me a line!

## Extra

### X11 Installation

To install under the [X Window System](https://www.x.org/):

- Import the .xrdb file of the scheme you'd like to use:

  #include "/home/mbadolato/iTerm2-Color-Schemes/xrdb/Blazer.xrdb"

- Use the `#define`s provided by the imported .xrdb file:

  Rxvt*color0: Ansi_0_Color
  Rxvt*color1: Ansi_1_Color
  Rxvt*color2: Ansi_2_Color
  Rxvt*color3: Ansi_3_Color
  Rxvt*color4: Ansi_4_Color
  Rxvt*color5: Ansi_5_Color
  Rxvt*color6: Ansi_6_Color
  Rxvt*color7: Ansi_7_Color
  Rxvt*color8: Ansi_8_Color
  Rxvt*color9: Ansi_9_Color
  Rxvt*color10: Ansi_10_Color
  Rxvt*color11: Ansi_11_Color
  Rxvt*color12: Ansi_12_Color
  Rxvt*color13: Ansi_13_Color
  Rxvt*color14: Ansi_14_Color
  Rxvt*color15: Ansi_15_Color
  Rxvt*colorBD: Bold_Color
  Rxvt*colorIT: Italic_Color
  Rxvt*colorUL: Underline_Color
  Rxvt*foreground: Foreground_Color
  Rxvt*background: Background_Color
  Rxvt*cursorColor: Cursor_Color

  XTerm*color0: Ansi_0_Color
  XTerm*color1: Ansi_1_Color
  XTerm*color2: Ansi_2_Color
  XTerm*color3: Ansi_3_Color
  XTerm*color4: Ansi_4_Color
  XTerm*color5: Ansi_5_Color
  XTerm*color6: Ansi_6_Color
  XTerm*color7: Ansi_7_Color
  XTerm*color8: Ansi_8_Color
  XTerm*color9: Ansi_9_Color
  XTerm*color10: Ansi_10_Color
  XTerm*color11: Ansi_11_Color
  XTerm*color12: Ansi_12_Color
  XTerm*color13: Ansi_13_Color
  XTerm*color14: Ansi_14_Color
  XTerm*color15: Ansi_15_Color
  XTerm*colorBD: Bold_Color
  XTerm*colorIT: Italic_Color
  XTerm*colorUL: Underline_Color
  XTerm*foreground: Foreground_Color
  XTerm*background: Background_Color
  XTerm*cursorColor: Cursor_Color

- Store the above snippets in a file and pass it in:

  xrdb -merge YOUR_FILE_CONTAINING_ABOVE_SNIPPETS

- Open new XTerm or Rxvt windows to see the changes.

- Adapt this procedure to other terminals as needed.

### Terminator color schemes

Edit your Terminator configuration file (located in: `$HOME/.config/terminator/config`) and add the configurations for the theme(s) you'd like to use the `[profiles]` section. The `terminator/` directory contains the config snippets you'll need. Just paste the configurations into the `[profiles]` sections, and you're good to go!

At a minimum, this is all you need. You can customize the fonts and other aspects as well, if you wish. See the Terminator documentation for more details.

An example config file that includes the code snippet for the Symfonic theme would look like this:

```ini
[global_config]
 [keybindings]
 [profiles]
   [[default]]
  palette = "#1a1a1a:#f4005f:#98e024:#fa8419:#9d65ff:#f4005f:#58d1eb:#c4c5b5:#625e4c:#f4005f:#98e024:#e0d561:#9d65ff:#f4005f:#58d1eb:#f6f6ef"
  background_image = None
  use_system_font = False
  cursor_color = "#f6f7ec"
  foreground_color = "#c4c5b5"
  font = Source Code Pro Light 11
  background_color = "#1a1a1a"
   [[Symfonic]]
  palette = "#000000:#dc322f:#56db3a:#ff8400:#0084d4:#b729d9:#ccccff:#ffffff:#1b1d21:#dc322f:#56db3a:#ff8400:#0084d4:#b729d9:#ccccff:#ffffff"
  background_color = "#000000"
  cursor_color = "#dc322f"
  foreground_color = "#ffffff"
  background_image = None
 [layouts]
   [[default]]
  [[[child1]]]
    type = Terminal
    parent = window0
  [[[window0]]]
    type = Window
    parent = ""
 [plugins]
```

### Konsole color schemes

Copy the themes from the `konsole` directory to `$HOME/.config/konsole` (in some versions of KDE, the theme directory may be located at `$HOME/.local/share/konsole`), restart Konsole and choose your new theme from the profile preferences window.

If you want to make the themes available to all users, copy the .colorscheme files to `/usr/share/konsole`.

### Terminal color schemes

Just double click on selected theme in `terminal` directory

### PuTTY color schemes

#### New Session Method

This method creates a new blank session with JUST colors set properly.

Download the appropriate `colorscheme.reg` file and import the registry changes by right-clicking and choosing Merge. Choose "Yes" when prompted if you're sure. Color scheme will show up as a new PuTTY session with all defaults except entries at `Window > Colours > Adjust the precise colours PuTTY displays`.

#### Modify Session Method

This method modifies an existing session and changes JUST the color settings.

Download the appropriate `colorscheme.reg` file. Open the file with a text editor and change the color scheme portion (`Molokai` below) to match the session you want to modify:

```
[HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Molokai]
- CHANGE TO (EXAMPLE) -
[HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\root@localhost]
```

**NOTE**: Some special characters will need to be changed to their Percent-encoded representation (IE, Space as `%20`). To quickly find the right session name view the top-level entries at `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\` with `regedit.exe`.

#### Other PuTTY Recommendations

```
Window > Appearance
 Font: Consolas, bold, 14-point
 Font quality:
  ( ) Antialiased   ( ) Non-Antialiased
  (O) ClearType    ( ) Default
Window > Colours
 [X] Allow terminal to specify ANSI colours
 [X] Allow terminal to use xterm 256-colour mode
 Indicate bolded text by changing:
  ( ) The font  (O) The colour   ( ) Both
 [ ] Attempt to use logical palettes
 [ ] Use system colours
```

### Xfce Terminal color schemes

Copy the `colorschemes` folder to `~/.local/share/xfce4/terminal/` and restart Terminal.

### FreeBSD vt color schemes

Append your favourite theme from `freebsd_vt/` to `/boot/loader.conf`
or `/boot/loader.conf.local` and reboot.

### MobaXterm color schemes

Copy the theme content from `mobaxterm/` and paste the content to your `MobaXterm.ini` in the corresponding place (`[Colors]`).

### LXTerminal color schemes

Copy the theme content from `lxterminal/` and paste the content to your `lxterminal` in the corresponding place (`[general]`).

### Visual Studio Code color schemes

Copy the theme content from `vscode/` and paste the content to your [UserSettings.json](https://code.visualstudio.com/docs/getstarted/settings).

### Windows Terminal color schemes

Copy the theme content from `windowsterminal/` and paste the content to your `profiles.json` in the corresponding place (`"schemes"`). Then specify the name of your theme by `"colorScheme"` in `"profiles"`.

### Alacritty color schemes

Copy the theme content from `alacritty/` and paste the content to your alacritty config file, at `~/.config/alacritty/alacritty.toml`. You can also set your theme by adding the following line at your config's 1st line `import = ["~/.config/alacritty/themes/mytheme.toml"]`.

If you still need a color scheme with .yml, you can get it [here](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/56d74c3e29040e44ff7e379a84e0fa3a57b3e903/alacritty).

### Ghostty color schemes

Copy the theme content from `ghostty/` and paste the content in your Ghostty config file, at `~/.config/ghostty/config`.

### Rio color schemes

Copy the theme file from `rio/` and paste to your rio theme config directory (typically `~/.config/rio/themes/`).
Then specify the name of your theme in the `theme` field in the [config file](https://raphamorim.io/rio/docs/#configuration-file).

### Termux color schemes

Copy the theme content from `termux/` and paste the content to `~/.termux` directory as `~/.termux/colors.properties` file and run `termux-reload-settings` to apply the theme.

### Generic color schemes

These schemes work with any terminal emulator with support for the OSC 4 escape code (including the Linux console, GNOME Terminal, and more).

Copy the shell script from `generic/` and paste the script to `~/bin/set-colors.sh`, or wherever you prefer to put shell scripts.
Then add `bash ~/bin/set-colors.sh` to your shell's config file (`~/.bashrc`, `~/.zshrc`, etc).

### Previewing color schemes

[preview.rb](tools/preview.rb) is a simple script that allows you to preview
the color schemes without having to import them. It parses .itermcolors files
and applies the colors to the current session using [iTerm's proprietary
escape codes](https://iterm2.com/documentation-escape-codes.html). As noted in
the linked page, it doesn't run on tmux or screen.

```sh
# Apply AdventureTime scheme to the current session
tools/preview.rb schemes/AdventureTime.itermcolors

# Apply the schemes in turn.
# - Press (almost) any key to advance; hit CTRL-C or ESC to stop
# - Press the delete key to go back
tools/preview.rb schemes/*
```

#### Previewing color schemes in other terminal emulators

[preview-generic.sh](tools/preview-generic.sh) is a script which can preview
the themes in any terminal emulator which has support for the OSC 4 escape
codes. It works by running the shell scripts from the `generic/` directory. 

```sh
# Apply AdventureTime scheme to the current session
bash generic/AdventureTime.sh

# Apply the schemes in turn
# - Press left/right arrow keys to navigate, press `q` to stop
./tools/preview-generic.sh generic/*
```
---

iTerm Color Schemes | iTerm2 Color Schemes | iTerm 2 Color Schemes | iTerm Themes | iTerm2 Themes | iTerm 2 Themes

[![Analytics](https://ga-beacon.appspot.com/UA-30661340-2/mbadolato/iTerm2-Color-Schemes?pixel)](https://github.com/igrigorik/ga-beacon)
