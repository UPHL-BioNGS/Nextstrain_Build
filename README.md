
# Nextstrain_Build
[Nextstrain](https://nextstrain.org/) is a powerful pathogen surveillance tool that creates interactive visualizations to explore curated datasets and analyses. It is composed of two main programs [Augur](https://docs.nextstrain.org/projects/augur/en/stable/index.html) and [Auspice](https://docs.nextstrain.org/projects/auspice/en/stable/). Augur is a package of bioinformatic tools that creates the JSON files that are used by a web-based interactive visualization program, Auspice.  Nextstrain defines a [‘build’](https://docs.nextstrain.org/en/latest/reference/glossary.html#term-build) as ‘A sequence of commands, parameters and input files which work together to reproducibly execute bioinformatic analyses and generate a dataset for visualization with Auspice.’ This Nextflow workflow aims at making and developing these ‘Builds’ simple and easy. Many Nextstrain projects currently rely on ‘snakemake’ which provides a good example of what Nextstain_Build is trying to do. [Example](https://docs.nextstrain.org/en/latest/guides/bioinformatics/augur_snakemake.html)

# Usage
Nextstrain_Build will create a basic phylogenetic tree from a multi-sequence alignment by just providing a ```--multi_fasta``` file and  ```--metadata``` file in .tsv format. But this is just a starting point for building out a much more detailed analysis. Producing a time resolved tree, finding ancestral traits and sequences, and identifying amino-acid mutations can be included by changing these parameters to true:
```
params.time_resolved                  =  false
params.construct_ancestral_traits     =  false
params.construct_ancestral_sequences  =  false
params.indentify_aa_mutations         =  false

```
Additional config files can also be passed that allow the user to add colors, locations, and edit the Auspice display in detail. 

```
params.colors                         =  false
params.lat_longs                      =  false
params.auspice_config                 =  false
```
[Details on the format for the auspice config file.](https://docs.nextstrain.org/projects/auspice/en/stable/advanced-functionality/view-settings.html)

# To Do 
- [ ] Create module that verifies the fasta file and metadata file
	- Possibly expand to verify all other incoming config files
