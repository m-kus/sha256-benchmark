args:
	python scripts/generate_args.py --input-size 32 > data/args_32.txt
	python scripts/generate_args.py --input-size 64 > data/args_64.txt
	python scripts/generate_args.py --input-size 128 > data/args_128.txt
	python scripts/generate_args.py --input-size 256 > data/args_256.txt
	python scripts/generate_args.py --input-size 512 > data/args_512.txt
	python scripts/generate_args.py --input-size 1024 > data/args_1024.txt
	python scripts/generate_args.py --input-size 2048 > data/args_2048.txt
	python scripts/generate_args.py --input-size 4096 > data/args_4096.txt
	python scripts/generate_args.py --input-size 8192 > data/args_8192.txt
	python scripts/generate_args.py --input-size 16384 > data/args_16384.txt

artifacts:
	cairo1-run src/lib.cairo --layout recursive --args_file data/args_$(SIZE).txt --proof_mode --air_public_input target/public_input.json --air_private_input target/private_input.json --trace_file target/trace --memory_file target/memory

params:
	python scripts/generate_params.py --desired-degree-bound ${BOUND} --last-layer-degree-bound 64 > target/prover_params.json

prove:
	time cpu_air_prover --parameter_file target/prover_params.json --prover_config_file prover_config.json --private_input_file target/private_input.json --public_input_file target/public_input.json --out_file target/proof.json

prove-stwo:
	time cpu_air_prover2 --private_input_file target/private_input.json --public_input_file target/public_input.json --out_file target/proof.json
