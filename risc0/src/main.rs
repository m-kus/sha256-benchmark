use sha256_methods::{SHA256_GEN_ELF, SHA256_GEN_ID};
use risc0_zkvm::{default_prover, ExecutorEnv};
use clap::Parser;
use rand::Rng;
use sha2::{Sha256, Digest};

#[derive(Parser)]
struct Args {
    /// Size of the random byte vector to generate
    #[arg(long = "input-size")]
    input_size: usize,
}

fn main() {
    tracing_subscriber::fmt()
        .with_env_filter(tracing_subscriber::filter::EnvFilter::from_default_env())
        .init();

    let args = Args::parse();

    // Generate random bytes
    let mut rng = rand::thread_rng();
    let random_bytes: Vec<u8> = (0..args.input_size).map(|_| rng.gen()).collect();

    let env = ExecutorEnv::builder()
        .write_slice(&random_bytes)
        .build()
        .unwrap();

    let prover = default_prover();
    let prove_info = prover.prove(env, SHA256_GEN_ELF).unwrap();

    // Check that everything is OK
    prove_info.receipt.verify(SHA256_GEN_ID).expect("failed to verify");

    let actual: Vec<u8> = prove_info.receipt.journal.decode().unwrap();

    let mut hasher = Sha256::new();
    hasher.update(&random_bytes);
    let expected = hasher.finalize().to_vec();

    assert_eq!(expected, actual);
}
