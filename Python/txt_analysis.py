# -*- coding: utf-8 -*-
"""
Created on Thu Jan 11 15:16:21 2018

@author: sridh
"""
import pandas as pd
from collections import defaultdict
from __future__ import division
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
datas = pd.read_csv("mypersonality_final.csv",encoding = "ISO-8859-1")
from io import BytesIO
from zipfile import ZipFile
from urllib.request import urlopen
#from urllib2 import urlopen
import re
import pandas as pd 
import numpy as ny

url = urlopen('http://www2.compute.dtu.dk/~faan/data/AFINN.zip')
zipfile = ZipFile(BytesIO(url.read()))
afinn_file = zipfile.open('AFINN/AFINN-111.txt')

afinn = dict()
for line in afinn_file:
    parts = line.strip().split()
    if len(parts) == 2:
        afinn[parts[0].decode("utf-8")] = int(parts[1])

needed_columns  = datas[ ['#AUTHID','STATUS']]

stop_words = set(stopwords.words('english'))

unique_post= {}
for index, row in needed_columns.iterrows():
    line_tokens = word_tokenize(row['STATUS'])
    new_line=[]
    for each_word in line_tokens:
        if each_word not in stop_words:
            new_line.append(each_word)
    if row['#AUTHID'] not in unique_post :
        unique_post[row['#AUTHID']] = [new_line]
    else:
        unique_post[row['#AUTHID']].extend(new_line)

for i in unique_post:
    total = 0.
    count =0
    for t in unique_post[i][0]:
        if t in afinn:
            total += afinn[t]
            if afinn[t] >=2:
                count +=1
    unique_post[i].extend([total])
    unique_post[i].extend([count/ len(unique_post[i][0])])
avg = []
for i in unique_post:
    avg.append(unique_post[i][-1])
    print (i, unique_post[i][-1],unique_post[i][-2])

print(len(avg))

newdata = datas.groupby(['#AUTHID'])['sCON'].mean()
newdata = newdata.reset_index()

new_val=  newdata.iloc[:,-1]
vals = []
vals = new_val

import scipy
from scipy.stats import pearsonr
pearsonr(avg,vals)
