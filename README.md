# Rich chess notes

A rich chess notes organizer

## For developpers

### Dependencies

#### Linux

##### libsecret

Ubuntu

```bash
sudo apt install libsecret-1-dev
```

#### Windows

You need the C++ ATL libraries installed along with the rest of Visual Studio Build Tools. Download them from here and make sure the C++ ATL under optional is installed as well.

### Locales

In order to update locales, run `dart run slang` from your terminal.

### Riverpod files generation

```bash
dart run build_runner build
```

### Launcher icons

```bash
dart run icons_launcher:create
```
