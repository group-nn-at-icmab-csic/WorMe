# User Manual - WorMe: *Caenorhabditis elegans* length determination




## Introduction

(Introducció de l'article JOSS, relativament breu)

<div align="center"> <img src="https://github.com/user-attachments/assets/6ab47a84-05d1-444f-97ac-4e5edccb1be6" alt="selection" width="55%"> </div>



*Còpia intro de l'article ja escrit* ↓


Caenorhabditis elegans is a nematode widely used as model organism because its small size, body transparency, short life cycle, genetic manipulability, and its absence of ethical requirements, which makes it a good candidate for molecular biology and toxicological studies.

Many morphological and biological variables in C. elegans are useful for experimentation, including reproduction rate, mobility, and survival. Among these, body length is a key parameter for analyzing the organism’s growth rate. This variable is particularly relevant in toxicological studies [NN grup article cite] and other experimental contexts.

The length of C. elegans is used to be in the range of 100μm and 800μm (revisar), and it is used to be obtained measuring the head to the tail of the worm, or reverse. This measurement is made by the images or videos obtained from a microscope or stereomicroscope. This process is used to be  made manually by drawing a line for each worm, or computer-automatized by the processing and analysis of the images.


The analysis with stereomicroscpy is widely used for C. elegans morphology measurements, mainly for the high-throughput analysis of images with many worms [cite stereomicroscopy softwares and their use]. This method gives a lower resolution and less details of the worm, compared to the use of a compound microscope, which offer more magnification and precise measurements. The use of compound microscopy for the length measurement is made to ensure the quality and reliability of the measurements, which is desired in cases of time-consuming or high-cost experiments. 

Manual length measurement of C. elegans from microscopy images is a widely used methodology in various laboratories [cite NN group and non-NN group]. However, this process is time-consuming, as it requires the analyst to manually trace a line along each worm to determine its length. Typically, this measurement is performed using general image analysis software equipped with the necessary tools, such as ImageJ [5].

The currently software programs that automatize the length determination of the C. elegans in an image or video are WorMachine [], the CellPose pipelines WormToolbox [], CeSnAP [], WormPose [], Celeganser []. These designed specifically for obtain the length of C. elegans as WormSizer [], AnliLength [], and WormSeg []. This software are designed mainly for the automation analysis of C. elegans in stereomicroscopical images, but not for the images from the compound microscopes.


Here we present the WorMe length determination software. WorMe is a MATLAB-based free software that automatizes the length determination analysis of C. elegans for different types of microscopic images, giving a choiced and reliable data of the length measurements. The WorMe is user-friendly software, open-source, free, and easy to install and use.

The program develops a processment of the microscopical images and return the measurement of each  worms in it. The user chose and rely singulary the measure, and finally obtain the data and image object components.

WorMe is coded in MATLAB, and can be used in Windows, Linux and iOS [to comprove] without the necessity of MATLAB license [MATLAB Runtime cite explanation article]. The program can be downloaded from the repository website [ DOI …].


## Software description, use and features


### Brief description of the program 
*(Còpia del Confluence ↓)*

WorMe has been developed in MATLAB 2024b version, because of the improvements of the updated version, but it can be used as well in MATLAB 2021b. The installation and use of the program doesn’t need the license, and it is done by an executable file.

The objective of WorMe is to provide the automated obtaining of the length of C.elegans from images by directly visualization, in analogy to the manual measurement, ensuring on the same way reliability and origin of the data.

The program works in a lineal set of pannels. There is a first image processment settings, where the user sets the image processing settings. Following it, there is the selection pannel, where the user visualizes the C. elegans measurements and selects manually the correct ones. Finally there is a pannel of data results and image object export. 

The manual measurement selection may be time-consuming step, but it guarantees a quality and reliable data (see Results and Discussion). 

User-based design

The design of the program is based on the user necessities, ensuring being intuitive in the installation and use of the program tools, without the necessity to the user to know about code languages.

The program’s computational operation has been optimized in order to rely a good timing in the processment and analysis of the image and objecs, and in the time of using by the user.



### Installation and requirements

The executable file for the installation of WorMe Length determination can be found in (put here DOI), and the main MATLAB code program in (put here DOI)

WorMe length determination can be installed from the executable file (DOI) as a local software in Windows (and Mac and Linux ?), without the necessity of having MATLAB license, nor other previous specific installations.

<div align="center"> <img src="https://github.com/user-attachments/assets/e6e21505-aa81-4587-b9e6-fa12b1c112a2" alt="frink"> </div>

The installation is made from the executable installation file (.exe), and it installs automatically MATLAB Runtime and WorMe length determination as system software. MATLAB Runtime is a software that allows to use compiled programs from MATLAB without the necessity to have MATLAB or their license. The installation is easy, fast, and intuitive, and just requires an internet connexion and 4 Gb of memory. 

<div align="center"> <img src="https://github.com/user-attachments/assets/67fb5fee-6e24-46b4-8ea7-93fccb3323c6" alt="frink" width="55%"> </div>


The program can also be used in MATLAB, by running the main file code (WM_length_determination_version.m). Note that using the program from MATLAB used to be a bit faster, but the system-installed program is also optimal.

The program use the MATLAB Toolbox packages:
- Computer Vision Toolbox
- Image Processing Toolbox
- Image Acquisition Toolbox
- Statistics and Machine Learning Toolbox

These packages are included in the executable file, but if the program is runned from MATLAB IDLE, it is going to be necessary to add these toolboxes. See: [How to add Add Ons in MATLAB](https://es.mathworks.com/help/matlab/matlab_env/get-add-ons.html).




The requirements of the computer are basic. The program needs between 1,2-2Gb of RAM memory, and a basic CPU (for example Intel Core i3 2GHz). For example, the program works properly 8Gb RAM and an Intel Core i5 CPU of 2.60GHz, in Windows OS.


In case of having MATLAB license, the program can be executed from the main script. This will allow faster 



## Use of the program


The program develop pre-setting steps of processing to the worm images, in order to isolate the worms of it as binary objects, which will be the length obtained and shown to the user in order to select it in a manual way. 

All the program use is descrived in the guide [DOI XXX] and tutorials [DOI XXX] of the program.

<div align="center"> <img src="https://github.com/user-attachments/assets/57ca0220-9afd-4f10-9fe7-58f9b3593712" alt="image-20230728-091743 (1)" width="55%"> </div>

### Image selection and scale setting

WorMe can operate with many types of images. The format of images can be .jpg, .png, jpeg, .tif, .tiff, .jfif, and .bmp, being grayscale or rgb (per a implementar). The program is designed based on the compound microscopical images, with an usually standard proportions (example: 1920x1080), but it can operate with different types of resolutions, as well as different kinds of microscope images. The use of huge resolution microscopical images (ex: 2500x2500 ← comprovar) is possible but not recommended because of the logistics architecture of the computation processment.

In order that the program works in the best way images must be clear, without dirt objects if possible, and with worms not touching between them, or being coiled or tangling. One desired image example is Figure 4.

<div align="center"> <img src="https://github.com/user-attachments/assets/e96185b4-c2f2-4a4e-ad45-2504bc7ef9b6" alt="selection" width="55%"> </div>

In the first step, the user introduces the images to analyze, and set the scale. After it, the modification pannel is shown. In it, the user determines the modifications that will be done into all the image stacks. The aim of this panel is to mainly isolate the worms as binary objects, which will be analysed and selected after.

The user must determine which set of image modifications will be applied to the stack of images. This modifications can be saved and imported, and they are used to be the same for same types of images. The versatility of image processing allows to operate into different kinds of images and objects. 

<div align="center"> <img src="https://github.com/user-attachments/assets/4fea1b09-c7d9-488e-a788-5020dbc65796" alt="image_processing_pannel" width="55%"> </div>



When the modification configuration is determined, start the selection panel. Images are individually processed by the configuration, and every object is analysed. In this step user can select as worm or as not worm the object that is surrounded by a bounding box. The user can move between the images and can finish the selection at the desired moment.

In this panel user can filtrate the objects mainly by length, area and circularity. There is also three tools for the object modification. Scissors allows to crop the objects, which is useful for example if two worms are joined. Draw line allows to draw a line that will be the length of the worm. The extension button is used for extend the objects, something that can be useful when there is a cropped part.


### Selection panel

In the worm selection pannel, the user visualise and selects each worm’s measurement. That may be time-consuming, but the computational and usage have been optimized in order to improve and adapt the process.

In this step the image is processed and the objects are analysed based on the previous defined image processing settings automatically. The computational time consumption of this process has been optimized by working with indexated data (see Computational optimization). 

The user-timing in the selection has been improved (example: shortkeys) trying to accelerate the selection process.

This manual selection panel is time consuming, but ensures the user to be aware in-time of the origin and quality of the measurement data, preventing bias.

<div align="center"> <img src="https://github.com/user-attachments/assets/c81dab40-d041-4889-8f61-d76b0f7fe9ec" alt="selection_pannel" width="55%"> </div>

### Results panel

Finally, after select the worms in the image, apperas the result panel. In this, user can see the an histogram with the results and descriptive statistics of the worms selected. The data of the length measures can be exported, as well as with the manual error correction (see below the apartat ASD). 

User can also export the graphic data. This allows exporting the binary images, labelled images, as well as PascalVOC files of the images which objects were selected. This type of images can be useful for a posteriori object analysis as well as for the use of it in the AI model development.

<div align="center"> <img src="https://github.com/user-attachments/assets/3722f5c4-0e1e-43c1-bcd0-8d894fbdb6ab" alt="image-20230731-164404" width="55%"> </div>


Finally the program visualize the set of length measurement data, and allows to export it. It includes also the option to export the data based in the manual error correction (see XXX). The program also provides the binary object data and other data that may be golden standard for deep learning models.


?
WorMe does not use artificial intelligence (AI) despite it is the state-of-the-art of the image processing and analysis. Many software are based on deep learning neural networks for the selection or identification of C. elegans in the images. Despite that, the program is consciousness about the data obtaintion and use for the creation of models, and it allows the user to export the graphical data in different formats (PascalVOC, label, binary, etc.) in order to be used for IA model building, among other types of analysis.

As is usual, the program does not used to differentiate between coiled and joined worms. Some IA based softwares can approach this differentiation [1-4]. Despite that, the panel offer tools for manually separate and differentiate between two or more joined C. elegans or objects. 

 

State of the art: Artificial intelligence: There is still much to do in C. elegans

Many of the recent software use Deep Learning  (DL) as the basis for image processing. Despite of the it, there is still the necessity of good DL models for develop the image segregation, and to compile image segmented data in C. elegans is still a requirement. 


### Example of usage


## Software Methodology

### Image and data processing

The program uses a wide range of image processing tools, thanks to the MATLAB image processing functions, and allows to visualize the image processing at time. This differentiate from many software in which the image processing have few tools or are automatic, or not visual. To have many tools give versatililty allowing to analyse different types of images and figures in it.

Many of the current software are designed ad hoc, working just in a specific kind of file or image typology, demanding images in a form that many times the users cannot provide, and being in some cases not user-friendly.

--

The processing of the images is developed by the user in modification panel. Image must be converted from Red-Green-Blue (RGB) to grayscale, to binary image, in order to isolate in these the desired objects, which are the worms.

A RGB image is a color image. An image can be understood as a matrix where every pixel have a value. In case of RGB the image is composed for three matrix which values range from 0 to 255. The colour of every pixel is defined by the value combination of the three matrix; for example orange colour have (255, 165, 0) value. 

In the transition from colour to grayscale the values of three matrix are sinthetised in one singular matrix, which values range from 0 to 255. In this case, the values will define in the image a proportion of white and black colours [6-7]. As example, in MATLAB this is developed by the im2gray() function [9]. WorMe offer different options for to convert the image from colour to grayscale.

When the image is converted to a binary, the values just range from 0 to 1. This transition is used to do by applying a threshold value, in which the upper or lower values will be segmented, making what is known as a mask. In MATLAB, as example, is applied the function imbinarize() [8].  We can operate with and analyze the objects in the binary image, for example isolating objects of interest, or analysising the morphology properties like length, circularity, area, etc. In WorMe there is many tools for operate with the objects, with the aim to obtain a mask in which we had the worms.

(PHOTO PIXEL RGB VALUES?)

Much of all of the image processing functions are part of the MATLAB Image Processing Toolbox, and the MATLAB Computer Vision Toolbox. MATLAB also use (…) toolbox.

### Skeletonize and branch reduction

Once the worm binary object is obtained, in order to obtain its length the image is skeletonized, then the branches are pruned to obtain the main length, and then the endpoints are extended. By this operations, we went from a binary object to have their main central line, which is analogue at the manual drawed one.

The skeletonization is the reduction from the binary object to a line. It is achieved by gradually reducing the surroundings of the image until achieves a line. In MATLAB it is developed by the bwskel() function [10].

The prune of the short branches in the skeleton image is developed by the own made function large_skel_iter(). This returns the main branch from a skeletonized object.

Finally, because the skeletonization endpoints used to not touch the borders of the object, a function was created for lengthen the lines from endpoints to the object. This function was the extendre_skel_estes_nou() in the program. This allows to approximate the measure from the head to the tail of the C. elegans.

Softwares like WormSizer and AnliLength [] describe the development of the function to prune and extend the skeletonized image.

<div align="center"> <img src="https://github.com/user-attachments/assets/43e8c563-35d0-4d33-a4d0-118e5c1fe800" alt="Images_arrays_4_horitz" width="55%"> </div>


### Length determination

 The length determination of the C. elegans in the image is the main objective of the program.

When the measure of the length is made by manually, using programs like ImageJ [5], usually a polyline is described from the tail to the head of C. elegans, or reverse, going through the middle of the body if possible. The length of the worm is defined from the sum of the Euclidean distance of the points (formula X).

When, in difference, the line is traced throughout the body of the worm, like the line obtained from the skeletonization, the length distance of C. elegans can be calculated also as the sum of the Euclidean points, in this case, between each pixel next to the other, in a one-pixel-width line.

(Descriure la funció en el codi del programa)


<div align="center"> <img src="https://github.com/user-attachments/assets/e8926716-39b0-4de9-b299-8ab3f117f81d" alt="image-20230801-155918" width="55%"> </div>



#### Manual error correction

Between the manual length and the pixel line length is used to there is a substantial difference, being the pixel length measure slightly higher. This is because of the lack of measurement in curved worms when their manual length is developed. The difference exist because the pixels between the pixel line describes a long distance than the two points of the manual annotation.

In the program we stack in the verification of the length result comparison, and realise about this difference. We realise that error appear not in the vertical, horizontal or diagonal forms, but in the curved ones. 

We studied the difference between these annotations, and realized that the error was minimal if the length was taken every 5 pixels of the manual distance. The program offers the possiblity to obtain the data by this bias, in order to adjust the data to the manual inherent error.

A short study showing the difference of results is described in Results - Manual error.

<div align="center"> <img src="https://github.com/user-attachments/assets/79209e6e-f7f4-4780-8808-2669cb26c73a" alt="image-20230801-160416" width="55%"> </div>

<div align="center"> <img src="https://github.com/user-attachments/assets/4cd32ede-43ae-4574-9d73-cc5148c9604b" alt="image-20230801-160530" width="55%"> </div>

One of the main steps for the validation of the program was verification of the data measured with those from manual measurements. From the start, the program attempt to reproduce the same measurement line as the manual measurement.

We used a set of worm images for to develop the comparison, as well as different drawed lines as a kind of stable image control. 

We saw the data didn’t match in the worms, and we improved the reproducivity of line, reaching the point the skeletonized line reach the final parts of the worm (see annex: extend the line to the tail).

We change the controls adding serpentined lines, and the controls then didn’t match.

We analyse the way distance was obtained in manual drawing, seeing the distance was made between the points the user made for to develop the line, and not by the line by itself. 

We figure out the bias was because of this length methodology of measurement. When we develop the euclediant distance every a certain number of pixels throughout the computer-drawn line we had a proportional dismiss of the error which made the data statistically the same. We find the difference was almost non-significant when the distance was almost 5 pixels difference between points.

(grafic distancia per pixel)

### IA data and graphic exportation

Finally the program visualize the set of length measurement data, and allows to export it. It includes also the option to export the data based in the manual error correction (see XXX). The program also provides the binary object data and other data that may be golden standard for deep learning models.

WorMe does not use artificial intelligence (AI) despite it is the state-of-the-art of the image processing and analysis. Many software are based on deep learning neural networks for the selection or identification of C. elegans in the images. Despite that, the program is consciousness about the data obtaintion and use for the creation of models, and it allows the user to export the graphical data in different formats (PascalVOC, label, binary, etc.) in order to be used for IA model building, among other types of analysis.

As is usual, the program does not used to differentiate between coiled and joined worms. Some IA based softwares can approach this differentiation [1-4]. Despite that, the panel offer tools for manually separate and differentiate between two or more joined C. elegans or objects. 

 

State of the art: Artificial intelligence: There is still much to do in C. elegans

Many of the recent software use Deep Learning  (DL) as the basis for image processing. Despite of the it, there is still the necessity of good DL models for develop the image segregation, and to compile image segmented data in C. elegans is still a requirement. 

### Computational optimization

Computational optimization has been a must in the development of the program because of its proper use. Many of the image processing and data handling functions have been optimized, making the program work with indexed image data and disk-storage, among other strategies (See more information in Annex: XXX).

Most of the functions using the program are MATLAB, and we used it as possible because they are per se fully optimized.

The result is that in 8Gb RAM i5 CPU the elapsed time for a main object processment in the selection panel is 0,03 seconds (← approximate, must validate).

In the selection panel the whole image is processed and their objects are isolated in a MATLAB file, saved in as indexed coordinates because of the computational optimization. For every object the skeletonization and operation is developed and showed, and the selection done by the user is saved. 



## Comparison to ImageJ and WorMachine

<div align="center"> <img src="https://github.com/user-attachments/assets/ea355d3d-a75d-4a51-b417-25189e28b717" alt="frink" width="55%"> </div>


