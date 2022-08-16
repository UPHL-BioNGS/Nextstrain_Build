process basic_construct{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(aligned)

    output:
    path "tree_raw.nwk" , emit: tree

    shell:
    '''
    augur tree \
      --alignment !{aligned} \
      --output tree_raw.nwk
    '''
}
