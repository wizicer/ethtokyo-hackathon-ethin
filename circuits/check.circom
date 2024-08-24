pragma circom 2.1.0;

include "../node_modules/circomlib/circuits/mimcsponge.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

template Main(MAX) {
    // public fields
    signal input pubkey;
    signal input height_commitment;
    signal input weight_commitment[MAX];

    // private fields
    signal input height;
    signal input weight[MAX];

    // check hash
    component height_hasher;
    height_hasher = MiMCSponge(1, 220, 1);
    height_hasher.k <== 0;
    height_hasher.ins[0] <== height;
    height_commitment === height_hasher.outs[0];

    component weight_hasher[MAX];
    for (var i = 0; i < MAX; i++) {
        weight_hasher[i] = MiMCSponge(1, 220, 1);
        weight_hasher[i].k <== 0;
        weight_hasher[i].ins[0] <== weight[i];
        weight_commitment[i] === weight_hasher[i].outs[0];
    }

    // check weight decrease
    component weight_decrease_comparator[MAX - 1];
    for (var i = 2; i < MAX; i++) {
        weight_decrease_comparator[i-1] = LessThan(16);
        weight_decrease_comparator[i-1].in[0] <== weight[i];
        weight_decrease_comparator[i-1].in[1] <== weight[i - 1];
        weight_decrease_comparator[i-1].out === 1;
    }

}

component main{public [pubkey, height_commitment, weight_commitment]} = Main(10);
