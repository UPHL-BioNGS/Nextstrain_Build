process concat_fastas{

    input:
    file(fastas)

    output:
    path "sequences.fasta" , emit: multifasta

    shell:
    '''
    echo "!{dummy}"
    '''
}
