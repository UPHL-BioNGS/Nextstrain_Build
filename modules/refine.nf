process refine{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(metadata)
    file(aligned)
    file(tree)


    output:
    path "tree.nwk" , emit: tree
    path "branch_lengths.json" , emit: branch_lengths

    shell:
    '''
    if [ -n "!{params.time_resolved}" ]; then timetree="--timetree"; else timetree=""; fi
    if [ -n "!{params.date_confidence}" ]; then date_confidence="--date-confidence"; else date_confidence=""; fi
    if [ -n "!{params.coalescent}" ]; then coalescent="--coalescent !{params.coalescent}"; else coalescent=""; fi
    if [ -n "!{params.date_inference}" ]; then date_inference="--date-inference !{params.date_inference}"; else date_inference=""; fi
    if [ -n "!{params.clock_filter_iqd}" ]; then clock_filter_iqd="--clock-filter-iqd !{params.clock_filter_iqd}"; else clock_filter_iqd=""; fi
    if [ -n "!{params.time_resolved_construct}" ]; then args="!{params.time_resolved_construct}"; else args=""; fi
    augur refine \
      --tree !{tree} \
      --alignment !{aligned} \
      --metadata !{metadata} \
      --output-tree tree.nwk \
      $timetree \
      $coalescent \
      $date_confidence \
      $date_inference \
      $clock_filter_iqd \
      $args \
      --output-node-data branch_lengths.json
    '''
}
