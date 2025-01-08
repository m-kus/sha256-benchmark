# SHA256 + Rapidsnark

## Install

Circom toolchain:  
https://docs.circom.io/getting-started/installation/

Circom library:
```sh
git clone https://github.com/iden3/circomlib
```

Rapidsnark:
https://github.com/iden3/rapidsnark?tab=readme-ov-file#compile-prover-in-standalone-mode

After you compiled the binary, add it to `$PATH` as `rapidsnark`.

## Benchmark

```sh
# Create a new circuit from template with the specified input size
SIZE=32 make circuit
# Compile the circuit
SIZE=32 make compile
# Create trusted setup, POWER is ceil(log2(2 * number of wires))
SIZE=32 POWER=16 make setup
# Generate random witness
SIZE=32 make witness
# Prove
SIZE=32 make prove
```