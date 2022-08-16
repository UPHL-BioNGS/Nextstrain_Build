process index_sequences{

      container 'nextstrain/base'

      publishDir = [ path: params.outdir, mode: 'copy' ]

      input:
      file(multifasta)

      output:
      path "sequence_index.tsv" , emit: sequence_index

      shell:
      '''
      augur index \
        --sequences !{multifasta} \
        --output sequence_index.tsv
      '''
}
