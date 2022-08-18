process verify_input{

    input:
    file(multifasta)
    file(meta_data)
    file(dropped_strains)
    file(outgroup)
    file(colors)
    file(lat_longs)
    file(auspice_config)


    output:

    shell:
    '''
    echo "Work in progress"
    '''
}
