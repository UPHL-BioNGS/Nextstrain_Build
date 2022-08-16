process indentify_aa_mutations{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(tree)
    file(nt_muts)
    file(outgroup)

    output:
    path "aa_muts.json", emit: aa_muts

    shell:
    '''
    augur translate \
      --tree !{tree} \
      --ancestral-sequences !{nt_muts} \
      --reference-sequence !{outgroup} \
      --output-node-data aa_muts.json
    '''
}
