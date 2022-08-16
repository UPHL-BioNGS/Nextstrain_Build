process filter_sequences{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(multifasta)
    file(sequence_index)
    file(meta_data)
    file(dropped_strains)

    output:
    path "filtered.fasta", emit: filtered

    shell:
    '''
    if [ -n "!{params.group_by}" ]; then group_by="--group-by !{params.group_by}"; else group_by=""; fi
    if [ -n "!{params.sequences_per_group}" ]; then sequences_per_group="--sequences-per-group !{params.sequences_per_group}"; else sequences_per_group=""; fi
    if [ -n "!{params.min_date}" ]; then min_date="--min-date !{params.min_date}"; else min_date=""; fi
    if [ -n "!{dropped_strains}" ]; then exclude="--exclude !{dropped_strains}"; else exclude=""; fi

    augur filter \
      --sequences !{multifasta} \
      --sequence-index !{sequence_index} \
      --metadata !{meta_data} \
      $exclude \
      $group_by \
      $sequences_per_group \
      $min_date \
      --output filtered.fasta
    '''
}
