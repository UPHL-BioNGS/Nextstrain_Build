process construct_ancestral_traits{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(tree)
    file(metadata)

    output:
    path "traits.json", emit: traits

    shell:
    '''
    if [ -n "!{params.columns}" ]; then columns="--columns !{params.columns}"; else columns=""; fi
    if [ -n "!{params.confidence}" ]; then confidence="--confidence"; else confidence=""; fi

    augur traits \
      --tree !{tree} \
      --metadata !{metadata} \
      $columns \
      $confidence \
      --output-node-data traits.json
    '''
}
