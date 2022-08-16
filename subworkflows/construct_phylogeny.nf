// Import Moduels
include { basic_construct }                from  '../modules/basic_construct'
include { refine }                         from  '../modules/refine'
include { construct_ancestral_traits }     from  '../modules/construct_ancestral_traits'
include { construct_ancestral_sequences }  from  '../modules/construct_ancestral_sequences'
include { indentify_aa_mutations }          from  '../modules/indentify_aa_mutations'


workflow construct_phylogeny {
  take:
    aligned
    metadata
    outgroup

  main:

    branch_lengths = Channel.value([])
    traits = Channel.value([])
    nt_muts = Channel.value([])
    aa_muts = Channel.value([])


    basic_construct( aligned )

    refine( metadata, aligned, basic_construct.out.tree )

    branch_lengths = refine.out.branch_lengths
    tree = refine.out.tree

    if (params.construct_ancestral_traits){
      construct_ancestral_traits( refine.out.tree, metadata )
      traits = construct_ancestral_traits.out.traits
    }
    if (params.construct_ancestral_sequences){
      construct_ancestral_traits( refine.out.tree, metadata )
      construct_ancestral_sequences( refine.out.tree, aligned )
      traits = construct_ancestral_traits.out.traits
      nt_muts = construct_ancestral_sequences.out.nt_muts
    }
    if (params.indentify_aa_mutations){
      construct_ancestral_traits( refine.out.tree, metadata )
      construct_ancestral_sequences( refine.out.tree, aligned )
      indentify_aa_mutations( refine.out.tree, construct_ancestral_sequences.out.nt_muts, outgroup )
      traits = construct_ancestral_traits.out.traits
      nt_muts = construct_ancestral_sequences.out.nt_muts
      aa_muts = indentify_aa_mutations.out.aa_muts
    }

  emit:
      tree
      branch_lengths
      traits
      nt_muts
      aa_muts
}
