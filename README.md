# ctransformers cuBLAS wheels
Wheels for [ctransformers](https://github.com/marella/ctransformers) compiled with cuBLAS support.  
The purpose of this is to provide pre-built CUDA binaries for additional CUDA and AVX versions.  
Original package only contains a cuBLAS library built for CUDA 12.1 and AVX2.

Requirements:
- Windows or Linux x86_64
- CPU with support for AVX or AVX2
- CUDA 11.7 - 12.2
- Python 3.x

### ctransformers 0.2.21 hardcodes checks for CUDA 12 libs installed through Python. You may receive a warning about this that should be ignorable so long as CUDA is properly installed elsewhere.

Installation instructions:
---
To install this package with requirements, you can use this command:
```
python -m pip install ctransformers --prefer-binary --extra-index-url=https://jllllll.github.io/ctransformers-cuBLAS-wheels/AVX2/cu117
```
This will install the latest ctransformers version available from here for CUDA 11.7. You can change `cu117` to change the CUDA version.  
You can also change `AVX2` to `AVX` based on what your CPU supports.  
You may need to change the command if the latest version is not yet available in this repo:
```
python -m pip install huggingface-hub py-cpuinfo
python -m pip install ctransformers --index-url=https://jllllll.github.io/ctransformers-cuBLAS-wheels/AVX2/cu117
```

You can install a specific version with:
```
python -m pip install ctransformers==<version> --prefer-binary --extra-index-url=https://jllllll.github.io/ctransformers-cuBLAS-wheels/AVX2/cu117
```
List of available versions:
```
python -m pip index versions ctransformers --index-url=https://jllllll.github.io/ctransformers-cuBLAS-wheels/AVX2/cu117
```

Wheels can be manually downloaded from: https://jllllll.github.io/ctransformers-cuBLAS-wheels

---
### All wheels are compiled using GitHub Actions
