// Import Moduels
include { index_sequences }                from  '../modules/index_sequences'
include { filter_sequences }                from  '../modules/filter_sequences'
include { align_sequences  }                from  '../modules/align_sequences'


workflow prepare_sequences {
  take:
    multifasta
    meta_data
    dropped_strains
    outgroup
  main:
    index_sequences( multifasta )
    filter_sequences( multifasta, index_sequences.out.sequence_index, meta_data, dropped_strains )
    align_sequences( filter_sequences.out.filtered, outgroup )
  emit:
  aligned = align_sequences.out.aligned
}
