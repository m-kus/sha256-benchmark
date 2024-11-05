import argparse
import hashlib
import os


def generate_args(size: int) -> list:
    # Generate random bytes of the specified size
    random_bytes = os.urandom(size)

    preimage = bytes_to_u32_chunks(random_bytes)
    digest = sha256_to_u32_chunks(random_bytes)
    
    # Encode arguments (following Cairo Serde rules)
    return [len(preimage)] + preimage + digest


def bytes_to_u32_chunks(data: bytes) -> list[int]:
    # Ensure the size is a multiple of 4, as each u32 is 4 bytes
    if len(data) % 4 != 0:
        raise ValueError("Size must be a multiple of 4 to encode as 32-bit integers.")
    
    # Convert to list of big-endian unsigned 32-bit integers
    u32_list = [
        (data[i] << 24) | (data[i+1] << 16) | (data[i+2] << 8) | data[i+3]
        for i in range(0, len(data), 4)
    ]
    
    return u32_list


def sha256_to_u32_chunks(data: bytes) -> list[int]:
    # Compute the SHA-256 hash of the input data
    digest = hashlib.sha256(data).digest()
    
    # Split the 32-byte digest into eight 4-byte (u32) big-endian integers
    u32_chunks = [
        (digest[i] << 24) | (digest[i+1] << 16) | (digest[i+2] << 8) | digest[i+3]
        for i in range(0, 32, 4)
    ]
    
    return u32_chunks


def cairo1_run_format(args: list) -> str:
    return f"[{' '.join(map(str, args))}]"


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate SHA256 bench program input")
    parser.add_argument(
        "--input-size",
        dest="input_size",
        type=int,
        default=32,
        help="Size of hash input, in bytes (must be divisible by 4)",
    )
    args = parser.parse_args()
    print(cairo1_run_format(generate_args(args.input_size)))
