circuit:
	mkdir sha256_$(SIZE) || true
	sed "s/%NUM_BITS%/$$(($(SIZE) * 8))/" main.circom > sha256_$(SIZE)/circuit.circom

compile:
	cd sha256_$(SIZE) && circom circuit.circom --r1cs --wasm --sym

setup:
	cd sha256_$(SIZE) \
		&& snarkjs powersoftau new bn128 $(POWER) pot_0000.ptau \
		&& snarkjs powersoftau prepare phase2 pot_0000.ptau pot_final.ptau \
		&& snarkjs groth16 setup circuit.r1cs pot_final.ptau circuit_0000.zkey \
		&& snarkjs zkey export verificationkey circuit_0000.zkey verification_key.json

witness:
	cd sha256_$(SIZE) \
		&& echo '{"in": ['$(shell seq 1 $(shell echo $$((SIZE * 8))) | awk 'BEGIN {srand()} {printf "\\\"%s\\\",", int(rand()*2)}' | sed 's/,$$//')']}' > input.json \
		&& node circuit_js/generate_witness.js circuit_js/circuit.wasm input.json witness.wtns

prove:
	cd sha256_$(SIZE) \
		&& time rapidsnark circuit_0000.zkey witness.wtns proof.json public.json
