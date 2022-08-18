process align_sequences{

    container 'staphb/augur:16.0.3'

    publishDir = [ path: params.outdir, mode: 'copy' ]

    input:
    file(filtered)
    file(outgroup)

    output:
    path "aligned.fasta", emit: aligned

    shell:
    '''
    if [ -n "!{params.fill_gaps}" ]; then fill_gaps="--fill-gaps"; else fill_gaps=""; fi

    if [ -n "!{params.large}" ]; then \
    sed  '240s/.*/            cmd = "mafft --reorder --large --anysymbol --nomemsave --adjustdirection --thread %d %s 1> %s 2> %s"%(nthreads, shquote(seqs_to_align_fname), shquote(aln_fname), shquote(log_fname))/' /augur-16.0.3/augur/align.py > /augur-16.0.3/augur/align.py && \
    sed  '238s/.*/            cmd = "mafft --add %s --keeplength --reorder --large --anysymbol --nomemsave --adjustdirection --thread %d %s 1> %s 2> %s"%(shquote(seqs_to_align_fname), nthreads, shquote(existing_aln_fname), shquote(aln_fname), shquote(log_fname))/' /augur-16.0.3/augur/align.py > /augur-16.0.3/augur/align.py;
    fi

    augur align \
      --nthreads !{params.nthreads} \
      --sequences !{filtered} \
      --reference-sequence !{outgroup} \
      $fill_gaps \
      --output aligned.fasta
    '''
}
