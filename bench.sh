#!/bin/bash

# Array of sizes to test
sizes=(32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536)

# Initialize arrays to store results
cairo_results=()
cairo0_results=()
sp1_results=()
risc0_results=()

# CSV output file
csv_file="benchmark_results.csv"

# Function to run benchmark and extract time
run_benchmark() {
    local cmd="$1"
    local output
    if ! output=$(eval "$cmd" 2>&1); then
        echo "err"
    else
        echo "$output" | grep "real" | awk '{print $1}'
    fi
}

echo "Running benchmarks..."

# Cairo benchmarks
cd cairo || exit 1
i=0
for size in "${sizes[@]}"; do
    echo "Running Cairo benchmark for size $size..."
    SIZE=$size make artifacts >/dev/null 2>&1
    cairo_results[i]=$(run_benchmark "make prove-stwo")
    i=$((i+1))
done
cd ..

# Cairo0 benchmarks
cd cairo0 || exit 1
echo "Compiling Cairo0..."
make compile >/dev/null 2>&1
i=0
for size in "${sizes[@]}"; do
    echo "Running Cairo0 benchmark for size $size..."
    SIZE=$size make artifacts >/dev/null 2>&1
    cairo0_results[i]=$(run_benchmark "make prove-stwo")
    i=$((i+1))
done
cd ..

# SP1 benchmarks
cd sp1 || exit 1
echo "Building SP1 program..."
make build >/dev/null 2>&1
i=0
for size in "${sizes[@]}"; do
    echo "Running SP1 benchmark for size $size..."
    sp1_results[i]=$(run_benchmark "SIZE=$size make prove")
    i=$((i+1))
done
cd ..

# RISC0 benchmarks
cd risc0 || exit 1
echo "Building Risc0 program..."
make build >/dev/null 2>&1
i=0
for size in "${sizes[@]}"; do
    echo "Running RISC0 benchmark for size $size..."
    risc0_results[i]=$(run_benchmark "SIZE=$size make prove")
    i=$((i+1))
done
cd ..

# Print ASCII table
printf "+----------+---------------+----------------+----------+----------+\n"
printf "| Size     | Stwo (Cairo)  | Stwo (Cairo0)  | SP1      | RISC0    |\n"
printf "+----------+---------------+----------------+----------+----------+\n"

# Write CSV header
echo "Size,Stwo (Cairo),Stwo (Cairo0),SP1,RISC0" > "$csv_file"

for i in "${!sizes[@]}"; do
    printf "| %-8d | %-13s | %-14s | %-8s | %-8s |\n" \
        "${sizes[i]}" \
        "${cairo_results[i]:-err}" \
        "${cairo0_results[i]:-err}" \
        "${sp1_results[i]:-err}" \
        "${risc0_results[i]:-err}"
    
    # Write to CSV
    echo "${sizes[i]},${cairo_results[i]:-err},${cairo0_results[i]:-err},${sp1_results[i]:-err},${risc0_results[i]:-err}" >> "$csv_file"
done

printf "+----------+---------------+----------------+----------+----------+\n"

echo "Results have been saved to $csv_file"
