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

### Stone prover

See https://stone-packaging.pages.dev/install/binaries

### Risc0 toolchain

Follow the instructions from https://dev.risczero.com/api/zkvm/install

### SP1 toolchain

See instructions at https://docs.succinct.xyz/getting-started/install.html
