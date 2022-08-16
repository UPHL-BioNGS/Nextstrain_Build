process construct_ancestral_sequences{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(tree)
    file(aligned)

    output:
    path "nt_muts.json", emit: nt_muts

    shell:
    '''
    if [ -n "!{params.inference}" ]; then inference="--inference !{params.inference}"; else inference=""; fi

    augur ancestral \
      --tree !{tree} \
      --alignment !{aligned} \
      --output-node-data nt_muts.json \
      $inference
    '''
}
