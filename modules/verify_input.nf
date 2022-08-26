process verify_input{

    container 'amancevice/pandas'

    input:
    path(multifasta)
    path(meta_data)
    path(dropped_strains)
    path(outgroup)
    path(colors)
    path(lat_longs)
    path(auspice_config)


    output:

    shell:
    '''
    verify.py !{meta_data} !{multifasta}
    '''
}
