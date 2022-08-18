#!/usr/bin/env nextflow

println("Performing a Nextstrain 'Build' which creates a detailed phylogentic visualization that can be seen with the Nextstain Auspice tool")
println("Author: John Arnn")
println("email: jarnn@utah.gov")
println("")

nextflow.enable.dsl               = 2

params.outdir                     = workflow.launchDir + '/Nextstrain_Build'

// Params go here
params.fastas                         = false
params.multi_fasta                    = false
params.metadata                       = false
params.verify_input                   = false

params.fill_gaps                      =  ''
params.alignment_output               =  ''
params.dropped_strains                =  false
params.outgroup                       =  false
params.group_by                       =  ''
params.sequences_per_group            =  '1'
params.min_date                       =  ''
params.date_confidence                =  ''
params.coalescent                     =  ''
params.date_inference                 =  ''
params.clock_filter_iqd               =  ''
params.time_resolved_construct        =  ''
params.time_resolved                  =  false
params.construct_ancestral_traits     =  false
params.construct_ancestral_sequences  =  false
params.indentify_aa_mutations         =  false
params.columns                        =  ''
params.confidence                     =  ''
params.joint                          =  ''
params.colors                         =  false
params.lat_longs                      =  false
params.auspice_config                 =  false
params.nthreads                       = 'auto'
params.large                          = ''




// Import subworkflows
include {verify_input} from './modules/verify_input.nf'

include {prepare_sequences} from './subworkflows/prepare_sequences.nf'

include {construct_phylogeny} from './subworkflows/construct_phylogeny.nf'

include { export }                from  './modules/export'


// Create Initial Channels

if (!params.fastas && !params.multi_fasta ){
  println("Must provide multifasta or fastas")
  exit 1
}

if (!params.metadata){
  println("Must provide metadata")
  exit 1
}

if( params.fastas ){
  Channel
    .fromPath("${params.fastas}/*{.fa,.fasta,.fna}")
    .collectFile(name: 'sequences.fasta', newLine: true, storeDir: params.outdir)
    .set { multifasta }
}

if( params.multi_fasta && !params.fastas){
  multifasta = Channel.fromPath(params.multi_fasta, type:'file')
}

meta_data = Channel.fromPath(params.metadata, type:'file')

if( params.dropped_strains ){dropped_strains = Channel.fromPath(params.dropped_strains, type:'file')}
else {dropped_strains = Channel.value([])}

if(params.outgroup){outgroup = Channel.fromPath(params.outgroup, type:'file')}
else {outgroup = Channel.value([])}

if(params.colors){colors = Channel.fromPath(params.colors, type:'file')}
else {colors = Channel.value([])}

if(params.lat_longs){lat_longs = Channel.fromPath(params.lat_longs, type:'file')}
else {lat_longs = Channel.value([])}

if(params.auspice_config){auspice_config = Channel.fromPath(params.auspice_config, type:'file')}
else{auspice_config = Channel.value([])}

// Intiate workflow

workflow {

  if(params.verify_input){
    verify_input(multifasta, meta_data, dropped_strains, outgroup, colors, lat_longs, auspice_config )
  }

  prepare_sequences(multifasta, meta_data, dropped_strains, outgroup)

  construct_phylogeny(prepare_sequences.out.aligned, meta_data, outgroup)

  branch_lengths = construct_phylogeny.out.branch_lengths.ifEmpty([])
  tree_time = construct_phylogeny.out.tree.ifEmpty([])
  tree = construct_phylogeny.out.tree.ifEmpty([])
  traits = construct_phylogeny.out.traits.ifEmpty([])
  nt_muts = construct_phylogeny.out.nt_muts.ifEmpty([])
  aa_muts = construct_phylogeny.out.aa_muts.ifEmpty([])

  if (params.time_resolved | params.construct_ancestral_traits | params.construct_ancestral_sequences | params.indentify_aa_mutations){
    export(meta_data, tree_time, branch_lengths, traits, nt_muts, aa_muts, colors, lat_longs, auspice_config)
  }
  else {
    export(meta_data, tree, branch_lengths, traits, nt_muts, aa_muts, colors, lat_longs, auspice_config)
  }
}

workflow.onComplete {
    println("Pipeline completed at: $workflow.complete")
    println("Execution status: ${ workflow.success ? 'OK' : 'failed' }")
}
