process align_sequences{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(filtered)
    file(outgroup)

    output:
    path "aligned.fasta", emit: aligned

    shell:
    '''
    if [ -n "!{params.fill_gaps}" ]; then fill_gaps="--fill-gaps"; else fill_gaps=""; fi

    augur align \
      --sequences !{filtered} \
      --reference-sequence !{outgroup} \
      $fill_gaps \
      --output aligned.fasta

    '''
}
