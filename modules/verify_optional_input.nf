process verify_optional_input{

    input:
    val(dummy)

    output:

    shell:
    '''
    echo "!{dummy}"
    '''
}
