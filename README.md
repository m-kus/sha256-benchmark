# SHA256 benchmark

Apples to oranges comparison, just to get some idea what to expect for the proving time on a M3 machine.

## Install

### Cairo runner

```
cargo install --git https://github.com/m-kus/cairo-vm --rev 6c23578739108f823510601a2097efb985d4149b cairo1-run
```

Cairo core library:

https://docs.swmansion.com/scarb/docs/reference/global-directories.html#cache-directory

```sh
ln -s $HOME/Library/Caches/com.swmansion.scarb/registry/std/v2.8.2/core cairo/corelib 
```

### Cairo0 runner

Make sure you have Python 3.9 installed locally/in venv.

```sh
pip install cairo-lang
```

### Stone prover

See https://stone-packaging.pages.dev/install/binaries

### Stwo prover

Make sure you have the latest Rust nightly toolchain installed.

```sh
cargo install --git https://github.com/starkware-libs/stwo-cairo adapted_stwo
```

### Risc0 toolchain

Follow the instructions from https://dev.risczero.com/api/zkvm/install

### SP1 toolchain

See instructions at https://docs.succinct.xyz/getting-started/install.html

## Run

### Cairo

Enter the cairo folder and run:

```sh
# Choose input size from {32, 64, 128, 256, 512, 1024}
SIZE=32 make artifacts

# Prove with Stone
make prove

# Update Stone parameters if necessary (if you get prover error, find `STARK: %bound%`)
BOUND=%bound% make params

# Prove with Stwo
make prove-stwo
```

### Cairo0

```sh
# Compile Cairo0 program
make compile

# Generate execution trace
make artifacts

# Prove with Stwo
make prove-stwo
```

### SP1 / R0

Open the respective folder and run:

```sh
# Choose arbitrary input size
SIZE=32 make prove
```
