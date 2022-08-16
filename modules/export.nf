process export{

    container 'nextstrain/base'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(metadata)
    file(tree)
    file(branch_lengths)
    file(traits)
    file(nt_muts)
    file(aa_muts)
    file(colors)
    file(lat_longs)
    file(auspice_config)

    output:
    path "auspice.json"

    shell:
    '''
    if [ -n "!{colors}" ]; then colors="--colors !{colors}"; else colors=""; fi
    if [ -n "!{lat_longs}" ]; then lat_longs="--lat-longs !{lat_longs}"; else lat_longs=""; fi
    if [ -n "!{auspice_config}" ]; then auspice_config="--auspice-config !{auspice_config}"; else auspice_config=""; fi

    augur export v2 \
      --tree !{tree} \
      --metadata !{metadata} \
      --node-data !{branch_lengths} \
        !{traits} \
        !{nt_muts} \
        !{aa_muts} \
      $colors \
      $lat_longs \
      $auspice_config \
      --output auspice.json
    '''
}
