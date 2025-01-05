%builtins range_check bitwise

from starkware.cairo.common.cairo_sha256.sha256_utils import finalize_sha256
from starkware.cairo.common.sha256_state import Sha256Input, Sha256ProcessBlock, Sha256State
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc


func main{range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
	alloc_locals;
    local n_instances: felt;
	let (sha256_ptr_start: felt*) = alloc();

	%{
        from starkware.cairo.common.cairo_sha256.sha256_utils import (
            IV,
            compute_message_schedule,
            sha2_compress_function,
        )
        from random import randrange

        n_instances = 1
        blocks = []
        ids.n_instances = n_instances
        for _ in range(n_instances):
            message = [randrange(0, 1 << 32) for _ in range(16)]
            w = compute_message_schedule(message)
            output = sha2_compress_function(IV, w)
            blocks += message + IV + output
        segments.write_arg(ids.sha256_ptr_start, blocks)
	%}

	finalize_sha256(
		sha256_ptr_start=sha256_ptr_start, sha256_ptr_end=sha256_ptr_start + 32 * n_instances
	);
	return ();
}