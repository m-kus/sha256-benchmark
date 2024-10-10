use std::{
    fs::{create_dir_all, File},
    io::Write,
    path::PathBuf,
};

use sha256_methods::{SHA256_GEN_ELF, SHA256_GEN_ID};
use risc0_zkvm::{default_prover, ExecutorEnv};

fn main() {
    tracing_subscriber::fmt()
        .with_env_filter(tracing_subscriber::filter::EnvFilter::from_default_env())
        .init();

    let data = [0u8; 32];

    let env = ExecutorEnv::builder()
        .write_slice(&data)
        .build()
        .unwrap();

    let prover = default_prover();
    let prove_info = prover.prove(env, SHA256_GEN_ELF).unwrap();

    // Check that everything is OK
    prove_info.receipt.verify(SHA256_GEN_ID).expect("failed to verify");
}
