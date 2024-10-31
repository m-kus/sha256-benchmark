artifacts:
	cairo1-run src/lib.cairo --layout recursive --args '[8 0 0 0 0 0 0 0 0 1718123181 4167220599 1821360523 2392821280 144118917 1860318131 2418694429 224340261]' --proof_mode --air_public_input target/public_input.json --air_private_input target/private_input.json --trace_file target/trace --memory_file target/memory

prove:
	cpu_air_prover --parameter_file prover_params.json --prover_config_file prover_config.json --private_input_file target/private_input.json --public_input_file target/public_input.json --out_file target/proof.json
