// Import Moduels
include { verify_multifasta }          from  '../modules/verify_multifasta'
include { verify_metadata }             from  '../modules/verify_metadata'
include { verify_optional_input }       from  '../modules/verify_optional_input'

workflow verify_input {
  take:
    dummy
    multifasta
    meta_data
    dropped_strains
    outgroup
    colors
    lat_longs
    auspice_config
  main:
    verify_multifasta( dummy )
    verify_metadata( dummy )
    verify_optional_input( dummy )

}
