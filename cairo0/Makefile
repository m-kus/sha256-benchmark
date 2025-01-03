compile:
	cairo-compile --proof_mode --output target/sha256.casm.json src/lib.cairo

artifacts:
	cairo-run --program target/sha256.casm.json --layout recursive --proof_mode --air_public_input target/public_input.json --air_private_input target/private_input.json --trace_file target/trace --memory_file target/memory

prove:
	time cpu_air_prover --parameter_file target/prover_params.json --prover_config_file prover_config.json --private_input_file target/private_input.json --public_input_file target/public_input.json --out_file target/proof.json

prove-stwo:
	time cpu_air_prover2 --private_input_file target/private_input.json --public_input_file target/public_input.json --out_file target/proof.json
