run:
	RUST_LOG="[executor]=info" RISC0_DEV_MODE=1 cargo run --bin sha256 -- --input-size $(SIZE)

prove:
	cargo build --release
	time cargo run --release --bin sha256 -- --input-size $(SIZE)
