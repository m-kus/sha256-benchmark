use clap::Parser;
use rand::Rng;
use sp1_sdk::{ProverClient, SP1Stdin};
use sha2::{Sha256, Digest};

pub const SHA256_ELF: &[u8] = include_bytes!("../../../elf/riscv32im-succinct-zkvm-elf");

#[derive(Parser)]
struct Args {
    /// Size of the random byte vector to generate
    #[arg(long = "input-size")]
    input_size: usize,
}

fn main() {
    sp1_sdk::utils::setup_logger();

    let args = Args::parse();

    // Generate random bytes
    let mut rng = rand::thread_rng();
    let random_bytes: Vec<u8> = (0..args.input_size).map(|_| rng.gen()).collect();

    let client = ProverClient::new();

    let mut stdin = SP1Stdin::new();
    stdin.write_slice(&random_bytes);

    let (pk, vk) = client.setup(SHA256_ELF);

    let proof = client
        .prove(&pk, stdin)
        .run()
        .expect("failed to generate proof");

    client.verify(&proof, &vk).expect("failed to verify proof");
    
    let actual = proof.public_values.to_vec();

    let mut hasher = Sha256::new();
    hasher.update(&random_bytes);
    let expected = hasher.finalize().to_vec();

    assert_eq!(expected, actual);
}
