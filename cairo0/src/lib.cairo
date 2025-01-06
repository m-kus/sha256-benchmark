%builtins range_check bitwise

from starkware.cairo.common.cairo_sha256.sha256_utils import finalize_sha256
from starkware.cairo.common.sha256_state import Sha256Input, Sha256ProcessBlock, Sha256State
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc


func main{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
	alloc_locals;
    local offset: felt;
	let (sha256_ptr_start: felt*) = alloc();

	%{
        from starkware.cairo.common.cairo_sha256.sha256_utils import (
            IV,
            sha_256_update_state,
        )

        input = bytes.fromhex(program_input['input'])
        input_bitlen = len(input) * 8

        padding = b'\x80' + b'\x00' * ((56 - (len(input) + 1) % 64) % 64)
        padded_input = input + padding + input_bitlen.to_bytes(8, 'big')

        message = [int.from_bytes(padded_input[i:i+4], 'big') for i in range(0, len(padded_input), 4)]
        assert(len(message) % 16 == 0)

        blocks = []
        state = IV
        for i in range(0, len(message), 16):
            output = sha_256_update_state(state, message[i:i+16])
            blocks += message[i:i+16] + state + output
            state = output

        segments.write_arg(ids.sha256_ptr_start, blocks)
        ids.offset = 2 * len(message)
	%}

	finalize_sha256(
		sha256_ptr_start=sha256_ptr_start, sha256_ptr_end=sha256_ptr_start + offset
	);
	return ();
}