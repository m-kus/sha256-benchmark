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
RUSTFLAGS="-C target-cpu=native -C opt-level=3" cargo install --git https://github.com/starkware-libs/stwo-cairo adapted_stwo
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

# Choose input size from {32, 64, 128, 256, 512, 1024}
SIZE=32 make artifacts

# Prove with Stwo
make prove-stwo
```

### SP1 / R0

Open the respective folder and run:

```sh
make build
# Choose arbitrary input size
SIZE=32 make prove
```

## Results

Obtained on a M3 machine by running `./bench.sh`

```
+----------+---------------+----------------+----------+----------+
| Size     | Stwo (Cairo)  | Stwo (Cairo0)  | SP1      | RISC0    |
+----------+---------------+----------------+----------+----------+
| 32       | 1.48          | 1.40           | 10.62    | 2.61     |
| 64       | 1.63          | 1.35           | 10.48    | 2.65     |
| 128      | 1.96          | 1.35           | 10.77    | 2.64     |
| 256      | 2.12          | 1.35           | 11.13    | 2.62     |
| 512      | 3.09          | 1.40           | 11.28    | 3.48     |
| 1024     | 5.45          | 1.44           | 11.15    | 3.49     |
| 2048     | 10.91         | 1.51           | 11.37    | 3.94     |
| 4096     | ---           | 1.63           | 12.03    | 3.71     |
| 8192     | ---           | 2.00           | 13.46    | 5.20     |
| 16384    | ---           | 2.63           | 16.77    | 5.25     |
| 32768    | ---           | 3.85           | 24.06    | 8.70     |
| 65536    | ---           | 7.35           | 38.65    | 16.68    |
+----------+---------------+----------------+----------+----------+
```