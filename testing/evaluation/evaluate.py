#!/usr/bin/env python3
#-*- coding: utf-8 -*-

import csv
import matplotlib.pyplot as plt

# Registered users in gallery
gallery_ids = ['bill','doubleb','tommy','harley','mlion','redlucy','robman','zuck']

IMPOSTORS=0.0
with open('./results.csv', 'r') as res:
    reader = csv.DictReader(res)
    for row in reader:
        if row['Real name'] not in gallery_ids:
            IMPOSTORS=IMPOSTORS+1.0

res.close()

FAR=[] # False acceptance rate
FRR=[] # False rejection rate
THS=[] # Thresholds

threshold = 0.00
MAX_FAR=-1

with open('./results.csv', 'r') as resultscsv:
    while int(threshold) < 1:
        GA=0.0 # Genuine Acceptance
        FR=0.0 # False Rejection
        GR=0.0 # Genuine Rejection
        FA=0.0 # False Acceptance
        resultscsv.seek(0)
        reader = csv.DictReader(resultscsv)
        for row in reader:
            real_name = row['Real name']
            dist = row['Distance']
            if dist != 'null':
                distance=float(dist)
            else:
                distance=dist
            identity = row['Id']
            if real_name in gallery_ids:
                if real_name == identity:
                    if distance <= threshold:
                        # If the real name is in the gallery, the user is registered,
                        # and if the identity matches we have a genuine acceptance (GA)
                        GA=GA+1.0
                    else:
                        # The user is allowed, but the threshold is not surpassed
                        FR=FR+1.0
                else:
                    if identity != 'null':
                        # If the real name is in the gallery, but the identity doesn't match
                        # but it isn't null, there is a false acceptance
                        FA=FA+1.0
                    else:
                        # If the identity is null, we just have a false rejection
                        FR=FR+1.0
            else:
                if identity != 'null':
                    # If the real name is not in the gallery, but we have a match it is
                    # false acceptance
                    FA=FA+1.0
                else:
                    # Real name not in gallery and no match, so genuine rejection
                    GR=GR+1.0
            if (FR+GR) > MAX_FAR: 
                MAX_FAR=(FR+GR)

        
        print(FA,FR,GA,GR,threshold,IMPOSTORS)
        
        FRR.append( GA/60 )
        FAR.append( ((FR+GR)/IMPOSTORS-1)/MAX_FAR )

        THS.append( threshold )
        threshold = threshold + 0.001

plt.plot( THS, FAR, "g" )
plt.plot( THS, FRR, "r" )

plt.tick_params(axis='both',bottom=True, top=True, left=True, right=True, direction='in', which='major', grid_color='blue')
plt.grid(linestyle='--', linewidth=0.5, alpha=0.15)
plt.title("FAR (green) & FRR (red)\nGraphic representation of the system with threshold step of 0.001")

plt.show()
