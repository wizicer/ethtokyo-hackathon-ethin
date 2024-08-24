interface MimcSponge {
  multiHash(
    arr: bigint[],
    key: bigint | undefined,
    numOutputs: number | undefined
  ): Uint8Array;
  F: { toString: (arr: Uint8Array, radix: number) => string };
}
declare module 'circomlibjs' {
  export function buildMimcSponge(): Promise<MimcSponge>;
}
