process verify_metadata{

    input:
    val(dummy)

    output:

    shell:
    '''
    echo "!{dummy}"
    '''
}
