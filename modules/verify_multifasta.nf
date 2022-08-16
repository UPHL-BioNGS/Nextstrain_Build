process verify_multifasta{

    input:
    val(dummy)

    output:

    shell:
    '''
    echo "!{dummy}"
    '''
}
