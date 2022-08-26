#!/usr/bin/env python

import pandas as pd
import argparse
import os
import sys

# USAGE: verify.py metadata.file fasta.file

metadata=sys.argv[1]
fasta=sys.argv[2]

data=pd.read_csv(metadata, sep='\t')
columns=list(data.columns)

if not('strain' in columns):
    print('Metadata file must have "strain" column')
    sys.exit(1)
if not('virus' in columns):
    print('Metadata file must have "virus" column')
    sys.exit(1)
if not('date' in columns):
    print('Metadata file must have "date" column')
    sys.exit(1)

if len(data['strain'][data['strain'].duplicated()]) > 0:
    print("There are duplicated 'strains' in the metadata file:")
    for i,v in data['strain'][data['strain'].duplicated()].iteritems():
        print("'strains': %s" % v)
    sys.exit(1)

samples=[]
with open(fasta) as f:
    for line in f:
        if line[0]=='>':
            samples.append(line[1:-1])

psamples=pd.Series(samples)
if len(psamples[psamples.duplicated()]) > 0:
    print("There are duplicated samples in the fasta file:")
    for i,v in psamples[psamples.duplicated()].iteritems():
        print("Sample: %s; Header %s of the fasta file"%(v,i))
    sys.exit(1)
