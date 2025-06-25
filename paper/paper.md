---
title: 'WorMe: A user-oriented software for *Caenorhabditis elegans* length determination'
tags:
  - Caenorhabditis elegans
  - length determination
authors:
  - name: Josep Llobet Lladó
    orcid: 0000-0002-5644-3834
    equal-contrib: true
    affiliation: 1
  - name: Núria Garriga-Alonso
    orcid: 0009-0007-5552-613X
    equal-contrib: true
    affiliation: 1
  - name: Anna Laromaine
    orcid: 0000-0002-4764-0780
    corresponding: true # (This is how to denote the corresponding author)
    affiliation: 1
affiliations:
 - name: Institut de Ciencia de Materials de Barcelona (ICMAB-CSIC),Campus UAB Bellaterra, Barcelona, Spain
   index: 1
date: 
bibliography: paper.bib
---

# Summary

*Caenorhabditis elegans* is a widely used animal model for biomedical research. The length of the nematode is a quantifiable parameter to assess its development. Currently, there are many tools that automatize this process. However, most of the available tools are designed for images from stereomicroscopes, and none were found that worked reliably for compound microscopy images. Here we present WorMe, a user-friendly software that measures *C. elegans* length in compound microscopy images. The program accepts multiple images as input, which can then be analysed collectively. Furthermore, the user can discard wrongly-detected objects, separate joined worms, correct erroneous measurements and manually add new worms. Then, the results are presented in a spreadsheet file, with each measurement linked to their image. 

# Statement of Need
*Caenorhabditis elegans* is a transparent nematode widely used as a model organism for whole animal studies. Its small size and short life cycle, as well as its compliance with the 3R principles for animal welfare in research allow for cost-effective and medium to high-throughput experiments [@Kaletta2006]. It is a robust model for early-stage research and toxicology studies since around 60-80% of human genes have a homolog in *C. elegans* [@Markaki2020].

Body size is an important endpoint used to assess the nematode’s development, as dietary changes or altered temperatures are shown to decrease body length [@Tain2008; @So2011; @Muoz-Juan2024]. Furthermore, in toxicity studies, the nematode’s body length is used to assess whether exposure inhibits growth [@Schrter2024; @Jung2015; @Srinivasan2023].

The manual measurement of *C. elegans* length from microscopy images is a widely used methodology. It is typically performed with FIJI-ImageJ, an image analysis software [@Schindelin2012]. However, this method is time consuming and imprecise, since it involves manually tracing a line along the middle of each worm. The measured length would thus vary across attempts and experimenters.

To automate and improve this process, many software solutions have been developed, such as the WormSizer plugin for FIJI [@Moore2013], WormToolBox from CellProfiler [@Whlby2012], WormLength from QuantWorm [@Jung2014], Anilength [@Jung2021] or WorMachine [@Hakim2018], among others. However, most are designed to measure length from stereomicroscopy images, as they have high enough magnification to measure worm length, but low enough so the images include a large number of worms.

However, no software has been found for compound microscopy images. Compound microscopes offer higher magnification, which allows for other measurements such as pharynx pumping rate, fluorescence imaging, or more accurate and reliable length measurements.

In this work we present WorMe, a *Caenorhabditis elegans* length determination software. WorMe is a MATLAB Runtime application that automatizes the length measurements from compound microscopy images. It is open-source and user-friendly, since it works from a graphical user interface. WorMe is also versatile, because it has a wide range of settings to process many kinds of images, and it ensures data reliability since the user selects the worms to be analysed in a computationally optimized process.

# Brief Description of the Program Use and Features
WorMe is an application implemented in *MATLAB version 9.11 (R2021b)* [@matlab], using the *Image Processing Toolbox* [@matlabimages], *Computer Vision Toolbox* [@matlabvision], *Image Acquisition Toolbox* [@matlabimaq] and *Statistics and Machine Learning Toolbox* [@matlabstats]. It is deployed as an executable using MATLAB Runtime, so it can be installed and run without a MATLAB license. It is also possible to run the main script `WM_length_determination.m` from the MATLAB interface.

First, the program prompts the user to provide the images to analyse. The user can select one or multiple images as long as the scale is consistent. Said scale is set by selecting the scale bar or by writing the scale value in pixels per unit.

Then, the images are processed to isolate the worms as binary objects. This is done by converting the image to grayscale (MATLAB function `im2gray`), improving the contrast (`imadjust`), binarizing the image (`imbinarize`), and removing noise and filling holes (`bwareaopen`, `imopen`, `imclose`, `imfill`, `imclearborder`). The user can select from a list of different sets of image modifications or apply their own if none display a workable result. The ideal procesing would show a black background with white, separate worms.

Afterwards, the program will skeletonize the binary objects (`bwmorph`) and prune the branches to obtain a line along the center of each nematode. Then, the user can visualize and select the *C. elegans* to measure. If a detected object is not a worm, it can be excluded from measurement. If two worms are connected, their binary object can be split, and the program will reprocess the skeleton for each new object. If the skeleton line does not span the entire worm, it can be extended. Similarly, if it is partly erroneous, it can be cut and extended again. Finally, if a worm is not detected, it can be added via manual analysis.

Finally, the results panel will return a histogram of length results, which can be saved as a spreadsheet. In this document we can also include results that account for manual error, results modified so they would be similar to those obtained from manual measurement in FIJI. These numbers are less accurate than the regular WorMe results, but may be useful to compare them to manual length measurements. Graphic data such as the binary images, indexed images or PascalVOC data for other morphology measurements or AI model training can also be saved.

A more detailed explanation as well as examples of use can be found in the user manual. This document, together with the software binaries are provided in the [GitHub code repository](https://github.com/group-nn-at-icmab-csic/WorMe).

# Acknowledgements

We acknowledge discussions with Dra. Amanda Muñoz, Dra. Sumithra Srinivasan, Dr. Nico Dix, Dr. Pablo Guardia, M.D. Miriam Vidal, Dr. Eduardo Soudah (CIMNE), Dr. Jordi Faraudo (ICMAB), Dr. Vinod Thalakkatukalathil, Dr. Pol Alonso, Dr. Dmytro Kukhtar, Laura Sancho,	Diego Esteban Peñas, (el french guy de Nanomol amic Laura), Dr. Martí Gich, Dra. Anna Roig, Dr. Thomas Meslier, the JEDI Academy UPC-FIB teachers, and the N&N group from ICMAB-CSIC for the discussions and support.

This project has been supported financially by the Spanish Government through the Becas de introducción a la investigación JAE Intro in CSIC institutes grants awarded to Josep Llobet Lladó and Núria Garriga-Alonso.

# References
