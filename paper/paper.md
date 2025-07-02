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
  - name: Amanda Muñoz-Juan
    orcid: 0000-0001-9549-782X
    affiliation: 1, 2
  - name: Anna Laromaine
    orcid: 0000-0002-4764-0780
    corresponding: true # (This is how to denote the corresponding author)
    affiliation: 1
affiliations:
 - name: Institut de Ciencia de Materials de Barcelona (ICMAB-CSIC),Campus UAB Bellaterra, Barcelona, Spain
   index: 1
 - name: (Current: Department of Molecular Biology and Genetics, Aarhus University, Aarhus, Denmark)
   index: 2
date: 
bibliography: paper.bib
---

# Summary

*Caenorhabditis elegans* is a widely used animal model for biomedical research. The length of the nematode is a quantifiable parameter commonly used to assess its development and evaluate its health. Although most measurements are performed manually, software that automates this process exists. However, most available tools are designed for stereomicroscope images, and none work reliably for optical microscopy images. Here, we present WorMe, a user-friendly software that measures *C. elegans* length in optical microscopy images. The program is versatile in handling various image types, and can analyse multiple images collectively. Furthermore, the user can accept or discard the detected objects, separate joined worms, correct erroneous measurements, and manually add new worms. Then, the length results are presented in a spreadsheet file, with each measurement linked to its image. Graphic data can also be exported.

# Statement of Need
*Caenorhabditis elegans* is a transparent nematode widely used as a model organism for whole animal studies. Its small size, short life cycle, and compliance with the 3R principles for animal welfare in research allow for cost-effective and medium to high-throughput experiments [@Kaletta2006]. It is a robust early-stage research and toxicology studies model since around 60-80% of human genes have a homolog in *C. elegans* [@Markaki2020].

Body size is a crucial endpoint used to assess the nematode’s development, as dietary changes or altered temperatures are shown to decrease body length [@Tain2008; @So2011; @Muoz-Juan2024]. Furthermore, in toxicity studies, the nematode’s body length is used to assess whether exposure inhibits growth [@Schrter2024; @Jung2015; @Srinivasan2023].

The manual measurement of *C. elegans* length from microscopy images is a widely used methodology. It is typically performed with FIJI-ImageJ, an image analysis software [@Schindelin2012]. However, this method is time-consuming and imprecise, since it involves manually tracing a line along the middle of each worm. Thus, the measured length would vary across attempts and experimenters.

Many software solutions have been developed to automate and improve this process, such as the WormSizer plugin for FIJI [@Moore2013], WormToolBox from CellProfiler [@Whlby2012], WormLength from QuantWorm [@Jung2014], Anilength [@Jung2021] or WorMachine [@Hakim2018], among others. However, most are designed to measure length from stereomicroscope images, as they have high enough magnification to measure worm length but low enough magnification so that the images include a large number of worms, albeit with low quality. 

However, no software has been found for length determination from compound microscopy images. Compound microscopes offer higher magnification, which allows for other measurements such as pharynx pumping rate, fluorescence imaging, or more accurate and reliable length measurements.

However, despite the wide range of software available for the image analysis of *C. elegans*, no software has been found for length determination from optical microscopy images. Optical microscopes offer higher magnification, which allows for other measurements such as pharynx pumping rate, fluorescence imaging, or more accurate and reliable length measurements. 

In this work we present WorMe, a *Caenorhabditis elegans* length determination software. WorMe is a MATLAB Runtime software that automates the nematode's length measurements from compound microscopy images. It is open-source and user-friendly, since it works from a graphical user interface. WorMe is also versatile, because it has a wide range of settings to process many kinds of images, and it ensures data reliability since the user selects the worms to be analysed. It is also fast, as the process is computationally optimized.

# Brief Description of the Program Use and Features
WorMe is a software program implemented in *MATLAB version 9.11 (R2021b)* [@matlab], using the *Image Processing Toolbox* [@matlabimages], *Computer Vision Toolbox* [@matlabvision], *Image Acquisition Toolbox* [@matlabimaq], and *Statistics and Machine Learning Toolbox* [@matlabstats]. It is deployed as an executable using MATLAB Runtime, so it can be installed and run without a MATLAB license. It is also possible to visualize and run the code from the main script `WM_length_determination.m` from the MATLAB Desktop interface.

When the program is started, it prompts the user to provide the images for analysis, where one or multiple images can be selected. The scale is then set by selecting the scale bar or writing the scale value in pixels per unit.

Then, the images are processed to obtain the worms as binary objects. This step is done, as is common, by converting the image to grayscale (MATLAB function `im2gray`), improving the contrast (`imadjust`), binarizing the image (`imbinarize`), and removing noise and filling holes (`bwareaopen`, `imopen`, `imclose`, `imfill`, `imclearborder`). The user can select from a list of different sets of image modifications or apply their own if none display a workable result. 

Afterwards, the program will skeletonize the worm object (using `bwmorph` among other MATLAB functions), prune the branches, and elongate the main line, which is a longitudinal line along the centre of the nematode. Then, the user can visualize and select which *C. elegans* to measure, and exclude undesirable objects. The selection process has been optimized to be fast and easy to use, for example, through the implementation of keyboard shortcuts. Furthermore, the length value is shown in real time, which ensures the measurements' reliability.

In this process, there are some tools that can assist with worm selection. If two worms are connected, their binary object can be split, and the program will reprocess the skeleton for each new object. If the skeleton line does not span the entire worm, it can be extended. Similarly, if it is partly erroneous, it can be cut and extended again. Lastly, a worm can be added via manual analysis if it is not detected.

Finally, the results panel will return descriptive statistics of the length measurements, which can be exported to a spreadsheet. Since there is a measurement bias between lines from the skeletonization of worm objects in WorMe and lines drawn manually in FIJI, corrected results are included to allow comparison with manual measurements. Furthermore, graphic data such as the binary images, indexed images, or PascalVOC data for other morphology measurements or AI model training can also be exported.

The user manual provides a more detailed explanation and examples of use. This document and the software binaries are provided in the [GitHub code repository](https://github.com/group-nn-at-icmab-csic/WorMe).

# Acknowledgements

We acknowledge discussions with the ICMAB-CSIC Nanoparticles and Nanocomposites group working with *C. elegans*, Dr. Jordi Faraudo (ICMAB) for his help in the GitHub repository and M.D. Míriam Vidal for the initial tests of the software.

This project has been supported financially by the Spanish Government through the XX grant and the Becas de introducción a la investigación JAE Intro in CSIC institutes grants awarded to Josep Llobet Lladó, JAEIntroICU-2021-ICMAB-01, and Núria Garriga-Alonso, JAEINT_24_01745.

# References
