args:
	echo '{"input": "'$$(openssl rand -hex 32)'"}' > data/args_32.json
	echo '{"input": "'$$(openssl rand -hex 64)'"}' > data/args_64.json
	echo '{"input": "'$$(openssl rand -hex 128)'"}' > data/args_128.json
	echo '{"input": "'$$(openssl rand -hex 256)'"}' > data/args_256.json
	echo '{"input": "'$$(openssl rand -hex 512)'"}' > data/args_512.json
	echo '{"input": "'$$(openssl rand -hex 1024)'"}' > data/args_1024.json
	echo '{"input": "'$$(openssl rand -hex 2048)'"}' > data/args_2048.json
	echo '{"input": "'$$(openssl rand -hex 4096)'"}' > data/args_4096.json
	echo '{"input": "'$$(openssl rand -hex 8192)'"}' > data/args_8192.json
	echo '{"input": "'$$(openssl rand -hex 16384)'"}' > data/args_16384.json
	echo '{"input": "'$$(openssl rand -hex 32768)'"}' > data/args_32768.json
	echo '{"input": "'$$(openssl rand -hex 65536)'"}' > data/args_65536.json

compile:
	cairo-compile --proof_mode --output target/sha256.casm.json src/lib.cairo

artifacts:
	cairo-run --program target/sha256.casm.json --program_input data/args_$(SIZE).json --layout recursive --proof_mode --air_public_input target/public_input.json --air_private_input target/private_input.json --trace_file target/trace --memory_file target/memory

prove:
	time cpu_air_prover --parameter_file target/prover_params.json --prover_config_file prover_config.json --private_input_file target/private_input.json --public_input_file target/public_input.json --out_file target/proof.json

prove-stwo:
	time adapted_stwo --priv_json target/private_input.json --pub_json target/public_input.json --proof_path target/proof.json
