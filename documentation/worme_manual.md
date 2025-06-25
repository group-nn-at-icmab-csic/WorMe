# User Manual - WorMe: *Caenorhabditis elegans* length determination


## Table of Contents

[Introduction](#introduction)  
[Software description, use and features](#software-description-use-and-features)  
[Installation](#installation)  
[Use of the program](#use-of-the-program)   
[Example of usage](#example-of-usage)  
[Software Methodology](#software-methodology)  
[Comparison to ImageJ and WorMachine](#comparison-to-imagej-and-wormachine)  

<br>


## Introduction

*Caenorhabditis elegans* is a widely used animal model for biomedical research. The length of the nematode is a quantifiable parameter to assess its development. Currently, there are many tools that automatize this process. However, most of the available tools are designed for images from stereomicroscopes, and none were found that worked reliably for compound microscopy images. 

Here we present WorMe, a *Caenorhabditis elegans* length determination software. WorMe is a MATLAB Runtime application that automatizes the length measurements from compound microscopy images. It is open-source and user-friendly, since it works from a graphical user interface. WorMe is also versatile, because it has a wide range of settings to process many kinds of images, and it ensures data reliability since the user selects the worms to be analysed in a computationally optimized process.

The program accepts multiple images as input, which can then be analysed collectively. Furthermore, the user can discard wrongly-detected objects, separate joined worms, correct erroneous measurements and manually add new worms. Then, the results are presented in a spreadsheet file, with each measurement linked to their image. 

## Software description, use and features
### Brief description of the program 

WorMe is an open-source application implemented in *MATLAB version 9.11 (R2021b)* and deployed as an executable using MATLAB Runtime, so it can be installed and run without a licence. It provides automatic detection and measurement of the length of *C. elegans* from microscopy images. It consists of a linear set of pannels that correspond to image processing, worm selection and results.  

WorMe takes the selected images and processes them until it gets individual worms as binary objects, which are skeletonized. Afterwards, the user selects which objects are worms, and the program measures the length of the skeletonization, which corresponds to the length of the worm. This manual selection ensures the quality and reliability of the data, as the user can see what is being measured.

Then, the program presents the length measurements in a spreadsheet. In this step, the program can account for manual error, and it can transform the results into values that would be equivalent to those obtained from manual measurements in programs such as FIJI ImageJ.

Furthermore, the program also provides graphic data, such as binary images, indexed images or PascalVOC data, which would be useful for training Deep Learning models. 

A tutorial can be found in [Use of the program](#use-of-the-program), and an explanation of the used functions, error correction, and optimization can be found in [Software Methodology](#software-methodology).

<div align="center"> <img src="images/use_of_the_program/WM_summary.png" alt="Summary of the program usage" width="100%">  

_Figure 1: Use of the program_
</div>

## Installation

WorMe is a MATLAB based software that **does not require a MATLAB licence**. It can be easily installed and executed in one of these two options:  
- Install as local software from the [executable file](https://github.com/group-nn-at-icmab-csic/WorMe/releases) (.exe). This does not require a MATLAB licence, because the program is compiled.
- Execute [the source code](https://github.com/group-nn-at-icmab-csic/WorMe/releases) from the MATLAB Desktop environment software (version >2021b). This requires a MATLAB licence but it has a slightly faster execution time.

The program requires at least 4GB of available disk space, as well as a Windows Operating System. 

### Installation and use from the executable (.exe)

WorMe Length determination can be **easily installed from the [executable file](https://github.com/group-nn-at-icmab-csic/WorMe/releases)** as a local software in Windows. **It does not require a MATLAB licence**.  
The step-by-step installation will automatically download and install MATLAB Runtime R2021b (9.11) and WorMe Length determination as system software. [MATLAB Runtime](https://mathworks.com/products/compiler/matlab-runtime.html) is a collection of the libraries required to run MATLAB aplications, in this case WorMe Length determination.

<div align="center">
  <img src="images/use_of_the_program/WM_install.png" alt="Installation Process" width="60%">
  <br>
  <em>Figure 2: WorMe installer that triggers the installation of MATLAB runtime R2021b</em>
</div>
<br>

### Installation and use from the source code 

The program can also be used by by running the main script [`WM_length_determination.m`](https://github.com/group-nn-at-icmab-csic/WorMe/blob/main/Length_determination/WM_length_determination.m) in MATLAB version R2021b or greater. However, a MATLAB licence is required.  

In this case, the program uses a few toolboxes which are needed for its execution (See: [How to add Add Ons in MATLAB](https://es.mathworks.com/help/matlab/matlab_env/get-add-ons.html)):
- [Computer Vision Toolbox](https://es.mathworks.com/products/computer-vision.html)
- [Image Processing Toolbox](https://es.mathworks.com/products/image-processing.html)
- [Image Acquisition Toolbox](https://es.mathworks.com/products/image-acquisition.html)
- [Statistics and Machine Learning Toolbox](https://es.mathworks.com/products/statistics.html)

The use of the program from the MATLAB Desktop environment software is slightly faster, but the local-installed program is also optimal.

## Use of the program

The use of WorMe is based in five continuous steps:  

→ [Image selection](#image-selection): Select the images to analyse.<br>
→ [Scale setting](#scale-setting): Set the measuring scale.<br>
→ [Image processing](#image-processing-panel): Configure the image modification parameters. <br>
→ [Worm selection](#selection-panel): Select worm objects manually.<br>
→ [Results](#results-panel): Read and download the results (data and image objects). <br>

For a fast tutorial, please refer to the repository's [README file](../README.md). For a video tutorial, please proceed to [Example of usage](#example-of-usage).

### Image selection

The program is designed for compound microscopy images with standard proportions, but it can operate with different resolutions and different kinds of microscope images. To change the selected images, the program must be restarted.

> [!IMPORTANT]
> Sometimes, an "Invalid or deleted object" error will appear due to exiting the program before going through all the steps. If the error persists when starting the program again, the easiest solution is to delete the `Documents/WorMe_Length_Results` folder.

#### Image formats
WorMe can operate with a wide range of image formats, including RGB and grayscale images.

Compatible image types are: `.jpg`, `.png`, `.jpeg`, `.tif`, `.tiff`, `.jfif` and `.bmp`.

Non-compatible image types are: `.gif` and `.webp`.

Nevertheless, WorMe is designed for single-layer images. Therefore, it is not compatible with multi-layer or multi-page optical microscopy `.tiff` images. 

#### Image resolution
The selected images can have any resolution, and it is not necessary for it to be uniform between them. 

However, the use of large resolution microscopy images (over 25000 x 25000 px) is possible but not recommended as it would lead to long waiting times due to the logistics of the image processing. Therefore, we recommend lowering the image resolution before measuring worm length.

#### Desired image quality
The program can adapt to any image quality. Even so, it works best with images that are clear, with regular brightness and contrast, without dirt, and with separate worms that are not touching, coiled or tangled.

Examples of desirable and undesirable images can be found below, in Tables 1 and 2, respectively. Of course, as long as the worms in undesirable images are recognizable by the naked eye, they can still be measured manually within WorMe.

In the experimental design, one may consider using cleaning methods of the final plate before image adquisition, which would improve the image analysis step.  

<div align="center">
<table>
  <tr>
    <td>a)<img src="images/use_of_the_program/good_images/Image_988.jpg" alt="Image_988" width="100%"></td>
    <td>b)<img src="images/use_of_the_program/good_images/Image_961.jpg" alt="Image_961" width="100%"></td>
    <td>c)<img src="images/use_of_the_program/good_images/Image_980.jpg" alt="Image_980" width="100%"></td>
  </tr>
  <tr>
    <td>d)<img src="images/use_of_the_program/good_images/Image_1729.jpg" alt="Image_1729" width="100%"></td>
    <td>e)<img src="images/use_of_the_program/good_images/Image_7884.jpg" alt="Image_7884" width="100%"></td>
    <td>f)<img src="images/use_of_the_program/good_images/Image_972.jpg" alt="Image_972" width="100%"></td>
  </tr>
</table>

_Table 1: Examples of desirable images. The background is bright, clean and with regular contrast, and the worms are not coiled or touching. The exceptions are e) where a worm is coiled at the top, and f) where there are some bubbles, but as they are far from the other worms, they do not impede analysis._
</div>

<div align="center">
<table>
  <tr>
    <td>a)<img src="images/use_of_the_program/bad_images/Image_7892.jpg" alt="Image_7892" width="100%"></td>
    <td>b)<img src="images/use_of_the_program/bad_images/P1011659.JPG" alt="Image P1011659" width="100%"></td>
    <td>c)<img src="images/use_of_the_program/bad_images/Image_7881.jpg" alt="Image_7881" width="100%"></td>
  </tr>
  <tr>
    <td>d)<img src="images/use_of_the_program/bad_images/P1011853.JPG" alt="Image P1011853" width="100%"></td>
    <td>e)<img src="images/use_of_the_program/bad_images/P1011646.JPG" alt="Image P1011646" width="100%"></td>
    <td>f)<img src="images/use_of_the_program/bad_images/Image_834.jpg" alt="Image_834" width="100%"></td>
  </tr>
</table>

_Table 2: Examples of undesirable images. a, b) Dirty and blurry images, but the worms might be detected correctly since they are clear. c) The worms are too coiled, which will impede skeletonization. d) The worms are touching, and they will need to be separated for analysis. e) Dirty image with irregular background, the worms will not be recognized. f) Non-worm objects are crossed with worm objects, which will impede correct detection_
</div>

### Scale setting
In the first step, the program will prompt the user to select the image or images to analyse. These must have the same magnification, as the program will use the same scale to calculate length. After selecting the images, the program will show the scale determination panel, with three options:

- Select automatically: Zoom to the scale bar, click the Select bar button, double-click the scale bar, then click the Scale value button and input the number represented by the scale bar. Then, press Done.

- Select by a line: Zoom to the scale bar, click the Draw line button, draw a line along the scale bar and double-click to confirm, then input the length unit in the Scale Value button and press Done.

- Introduce numerical value: Input the Scale Value in pixels per unit, and press OK. Usually used after determining this number with one of the previous two methods for the same or similar images, shown as Scale Value before pressing Done, as seen in the image below.

<div align="center"> <img src="images/use_of_the_program/WM_scale.png" alt="Scale determination process"  width="55%">  

_Figure 3: Scale determination options. The input value for the first two options is 200. The scale value is seen in the first two options to be 0.855 pixels per unit, which is the number to input for the last option. The units, in this case, will be &mu;m._
</div>

> [!TIP]
> The last used scale numerical value can be found at `Documents/WorMe_Length_Results/Results_out/Internal_code_files/escale_line.txt` 

### Image processing panel

After setting the scale, WorMe shows the image processing panel, shown in Figure 4 below. In it, the user determines the modifications that will be done to all images. 

The aim of this panel is to isolate each worm as a binary object. This means applying the right filters until the background is black and the worms are white and separate from each other, and there are no other white areas. The white area is also known as a mask.

<div align="center"> <img src="images/use_of_the_program/WM_processing.png" alt="Image Processing Panel" width="65%">

_Figure 4: Image processing panel, with (1) Filters, (2) the main panel, (3) Processings and (4) Image Properties_
</div>

The panel consists of four sections:
1. Filters: Consists of different buttons that can be used to set filters to the images. Normally, it is not used. They consist of converting the image to grayscale (im2gray), improving the contrast (imadjust), binarizing the image (Binarize, flip and Binarize by value), and removing noise and filling holes (AreaOpen, Close, Open, imfill, imclearborder).
2. Image processing panel: Consists of the image display and the following buttons:
    - Skeletonize: Shows the skeletons in the binarized objects with a red line, which is what is measured for worm length.
    - Original: Shows the original image
    - Masked: Shows the worm masks. More information in [Image data export](#image-data-export).
    - Modified: Shows the binarized image.
    - Arrow: Shows the next image.
    - Magnifying glass: Zooms in the image
    - Analyse: Runs the image analysis and continues to the next step
3. Processings: Consists of three sections and one button:
    - Temporal section: Shows temporary modifications. Useful to add more filters, or start from the original image.
    - Saved section: Shows finished modifications. Usually, one of these will work as needed for the next step.
    - New processment button: Adds a new Temporal modification, which can be used to add custom filters. 
    - Modifications section: Lists the filters applied to get the current displayed image from the original image.
4. Image properties: Shows which image is currently in display.

Usually, selecting one of the sets of modifications present in the Saved section of Processings is enough to obtain a good modified image. For example, as seen in Figure 4, the first modification shows a modified image of Table 1a) which has a black background with all worms in white and no noise, besides the scale bar. This is a good modification which will enable WorMe to get accurate length measurements.

Sometimes, however, none of the modifications are good. This usually happens when attempting to analyse images that are not compound microscopy images. For example, fluorescence images tend to have black worms and white background, and stereomicroscopy images tend to miss worms due to differences in lighting at different parts of the image.

In this case, it might be worthwhile to attempt a new image processing. The steps to take are the following:
1. In (3) Processings, click the New processment button. This will add `Modif_img_06.txt` at the Temporal section.
2. With `Modif_img_06.txt` selected, add some (1) Filters. The results of the filters can be seen step by step on the Image display, so one can undo if the results are not as expected.
    1. Convert the image to grayscale (im2gray)
    2. Improve the contrast (imadjust)
    3. Binarize the image. This is a useful step for improving worm visualization.
        - If binarization with the Binarize button needs improvement, try changing the value and using the Binarize by value button
        - If, after binarizing, the worms are black and the background white, use the flip button.
4. Clean up the image by removing noise and filling holes (AreaOpen, Close,
Open, imfill, imclearborder). Not all filters might be needed.
3. With the save icon button in the Saved section, you can save the applied filters for
images of the same type. These can be imported with the import icon button.
4. Press the Analyse button in the (2) Image Processing Panel. 

### Selection panel

After pressing the Analyse button, WorMe will show the selection panel, found in Figure 5 below. In it, the images are processed individually according to the earlier modifications. For each binary object, there is a skeletonization and branch reduction process, which is further explained in [Skeletonize and branch reduction](#skeletonize-and-branch-reduction), and the length of the resulting skeleton will represent the length of the worm. The user must assess each of the obtained binary objects.

The aim of this panel is to select the binary objects that correctly depict a worm, correct the objects that are worms but have incorrect skeletonization and reject the rest. 

The manual selection is time consuming, but it ensures the quality of the measurement data, as the user is aware of what is being measured and how. Furthermore, the computational time of the process has been optimized by working with indexated data, which can be seen in [Computational optimization](#computational-optimization).

<div align="center"> <img src="images/use_of_the_program/WM_selection.png" alt="Image Selection Panel" width="65%">

_Figure 5: Image selection panel, with (1) the main panel, (2) Filters, (3) Tools, (4) Selection and (5) Image properties_
</div>

The panel consists of five sections:
1. Main panel: Shows the processed binary objects surrounded in red bounding boxes. As the selection progresses, it shows accepted objects in green (such as the worm with length 744), rejected objects in red, and the current object in a bold line (such as the worm with length 800).
2. Filters: Consists of input areas that can filter binary objects. For example, to remove small dirt objects from the selection process.
    - Max circularity: Filters by circularity
    - Min area: Filters small objects by mask area
    - Min length: Filters short objects by skeletonization length
3. Tools: Consists of tools that can modify the binary object's mask. All of them can be used by clicking once to extend a line, and twice to finish and confirm. The mask of the current binary object will be shown as a grey overlay.
    - Scissors (R): Permits cutting the current binary object in two.
    - New line (F): Permits adding a new worm. It will be automatically selected as correct.
    - Extend line (C): Permits extending the current binary object. For example, to include a tail that was not previously detected.
4. Selection: Consists of buttons to accept or reject worms.
    - Undo (W): Undoes the last action.
    - Orange arrows (Q, E): Skip to the next image, or go back to the previous one.
    - Red cross (A): Rejects current binary object.
    - Green checkmark (D): Accepts current binary object
5. Image properties: Shows which image is in display.
    - Original (S): Shows the original image with no bounding boxes.
    - Magnifying glass: Zooms in the current Main panel.
    - Binarized object: Shows the binarized object in the main panel.
    - Tutorial: Shows keyboard shortcuts for Tools, Selection and Image Properties buttons. They have been added between brackets next to the button name.
    - Done: Finishes worm selection and continues to the next step.

The process of worm selection is detailed in the following steps:
1. The object to analyse is surrounded by a bounding box. 
2. If it is a worm, and its skeletonization is correct, press the green checkmark. If it is not a worm, press the red cross. Then, the program will go back to step (1) for the next binary object.
3. If it is a worm, but its skeletonization is incorrect, the Tools will be used to correct it.
    - If two worms are connected, use the Scissors to split the mask in two. Then, two binary objects will be separated.
    - If the worm's head or tail is not included in the skeleton, use Extend line from within the existing mask to extend the skeleton.
    - If the worm is too coiled and thus the skeleton does not follow its length, use the Scissors to cut off the wrong part, then use Extend line to add the rest.
    - If the worm was not detected, use New line to add a new binary object. This binary object will be automatically accepted as a worm.
4. After correction, the program will go back to step (1) with the new binary objects.
5. When all objects have been sorted, press the Done button to continue to the next step.

There are other steps that can be taken to streamline or correct the selection process:
- Filtering: Sometimes, the dirt in the image will be detected as very small worms. If it could not be fixed with image processing, it can be filtered out by setting a minimum length for potential worms.
- Undo button: if there is a mistake (for example, accepting a non-worm, or making an error with a Tool), it can be undone with this button.
- Orange arrow: if all objects in the image have been sorted, the program will automatically continue to the next. However, the arrows can be used to navigate between images.
- Done button: if some images want to be discarded (for example, if they have a different scale), it is not needed to discard all their binary objects. The selection can be finished at any moment by pressing the Done button. 
- Keyboard shortcuts: their use permits faster worm selection.

### Results panel

Finally, WorMe will show the Results panel, which can be seen in Figure 6. This is the final panel where the user can see the aggregated results of the measurements from all the analysed images, and they can export this data.

<div align="center"> <img src="images/use_of_the_program/WM_results.png" alt="Results Panel" width="65%">

_Figure 6: Results panel_
</div>

In this panel, the user can see a histogram which contains the length results, as well as the descriptive statistics of selected worms. This length data can be saved from the Export button in `.xls`, `.xlsx`, `.csv` or `.txt` format. Furthermore, there is an "Export manual error corrected data" checkbox which, when marked, will add manual error corrected data to the Export file. This correction allows the data to be compared to manually measured data from ImageJ or similar image analysis. More information can be found in [Manual length error correction](#manual-length-error-correction).

Graphic data, which consists of Binary Images, Indexed Images and PascalVOC files from both accepted and discarded binary objects, can also be obtained from the Export Graphic Data button. This data can be useful for both _a posteriori_ worm morphology analysis as well as Deep Learning model development. More information can be found in [Image data for the analysis and deep learning use](#image-data-for-the-analysis-and-deep-learning-use). 

> [!TIP]
> The image processing parameters can be found at `Documents/WorMe_Length_Results/Results_out` with the date and hour of the analysis.


### Example of usage

Three sets of _C. elegans_ microscopical example images have been provided in these repository. These are images at different stages of the nematodes' growth, and can be found at [C24](examples/Example_images_C24), [C48](examples/Example_images_C48) and [C72](examples/Example_images_C72).

In each of these folders, you can also find three other files which were obtained after WorMe measurements:
- `C_XX_length_results.csv`, for the worms' length results,
- `C_XX_graphic_results.zip`, for image results,
- `C_XX_parameters.txt`, for the scale values, image processment and selection tools used during the analysis.

In this section, we present two different examples of the use of WorMe. A [graphic tutorial](#graphic-tutorial), which shows the analysis of the C48 example folder, and a [fast tutorial](#fast-tutorial), which explains the most basic usage of the WorMe program.

#### Graphic tutorial
<br>
<p align="center"><strong><span style="font-size:18px;">Select the images</span></strong></p>
First, the user selects the images to analyze. The program will save the image paths.
<p align="center">
  <img src="images/example_use/a1.gif" width="60%" />
</p>

<p align="center"><strong><span style="font-size:18px;">Set the scale</span></strong></p>

Then, the user needs to set the scale. One way to do it is by tracing a line along the scale bar.

<p align="center">
  <img src="images/example_use/a2.png" width="60%" />
</p>

This is done on a series of steps as follows:

<p align="center">
  <img src="images/example_use/a3.gif" width="60%" />
</p>


<br>
<p align="center"><strong><span style="font-size:18px;">Configure the image modifications</span></strong></p>
Once the scale is set, the image needs to be processed. This consists of applying filters until the background is black and the worms are white and separate from each other. The white areas will be binary objects, and these will be the basis for the length analysis.

First, the user should check whether one of the Saved image processings works well for the selected images. If none do, the user should start a new processing and set the image filters manually.

<p align="center">
  <img src="images/example_use/a4.gif" width="60%" />
</p>

<p align="center"><strong><span style="font-size:18px;">Select the worms</span></strong></p>
Next, the user will manually sort the binary objects according to whether they are a worm or not. In case a worm was not detected or it was detected wrongly, the Tools can edit the binary objects by:

- Scissors: Cutting the object in two.
- New Line: Adding a new object.
- Extend Line: Lengthen the object.


<p align="center">
  <img src="images/example_use/a6.gif" width="60%" />
</p>

<p align="center"><strong><span style="font-size:18px;">Obtain the results</span></strong></p>

Then, the user can save the length results of the selected worms in a spreadsheet, as well as [the manual error bias correction](#manual-length-error-correction) values.

<p align="center">
  <img src="images/example_use/a7.gif" width="60%" />
</p>

Furthermore, the user can obtain the binary objects files, which may be useful to analyse the morphology of the worms, or to train deep learning models.

<p align="center">
  <img src="images/example_use/a8.gif" width="60%" />
</p>


#### Fast tutorial

There are five steps to use WorMe. 

1. **Image selection**: Select the images to analyse. We will use this image as an example.
<div align="center"> <img src="../examples/Example_images_C48/Image_972.jpg" alt="Image_972" width="70%">
</div>

> [!IMPORTANT]
> Sometimes, an "Invalid or deleted object" error will appear due to exiting the program before going through all the steps. If the error persists when starting the program again, the easiest solution is to delete the `Documents/WorMe_Length_Results` folder.

2. **Scale setting**: Set the measuring scale by selecting the scale bar. With "Select Automatically" the user must double click the scale bar and then input the displayed length number. In this example, it is 200.

3. **Image processing**: Configure the image modifications. Select from the Saved options in Processings the one that shows the worms the best. In this case, we used `Modif_Example_4.txt`. Then, press Analyse.

<div align="center"> <img src="images/use_of_the_program/WM_fastuse_1.png" alt="WM_fastuse_1" width="70%">
</div>

4. **Worm selection**: Select the worm objects manually. If the marked object is a worm, press the green checkmark. If it is not, the red cross. The Tools can modify the objects: the Scissors cut the current object in two, the New Object allows the user to trace a new object, and the Extend Object allows the user to lengthen the current object. Then, press Done.

<div align="center"> <img src="images/use_of_the_program/WM_fastuse_2.png" alt="WM_fastuse_2" width="70%">
</div>

5. **Results**: Press the export button to save the data. Select the "Export manual error corrected data" if the data requires comparison with other manual methods of measurement such as ImageJ.


## Software Methodology


[Image and data processing](#image-and-data-processing)  
[Skeletonize and branch reduction](#skeletonize-and-branch-reduction)  
[Endline elongation](#endline-elongation)  
[Length determination](#length-determination)  
[Manual length error correction](#manual-length-error-correction)  
[Image data](#image-data)  
[Computational optimization](#computational-optimization)




### Image and data processing

WorMe is based in MATLAB, and uses a wide range of image processing tools which allows to easily visualize and analyse the image in a fast and optimized way, as well as the data treatment.  

Once the images are loaded and the scale i settled, the user configure the image modification. In this step, the RGB image becomes to a grayscale, to become a binary image which objects of interest will be saved.  

<p align="center">
  <img src="images/Process_imatge/img6.png" width="60%" />
</p>

An RGB image means Red-Green-Blue image. We can understand an image as a 3 numerical matrix which every matrix have the 0 to 255 values of red, green and blue pixels. The combination of the three colors in every pixel results a color pixel. For example, orange is (255, 165, 0).  

<p align="center">
  <img src="images/Process_imatge/img2.png" width="85%" />
</p>


<p align="center">
  <img src="images/Process_imatge/img4.png" width="15%" />
</p>

This is converted to grayscale image. In this case, the image is just a matrix of 0 to 255 pixels, where the ranges of colours for every pixels goes from 0 as black to 255 as white, being in a gray scale of colors. As it is understood as a matix, we can operate with the values of it, increasing or decreasing it, filtering and having numerical operations.  

<p align="center">
  <img src="images/Process_imatge/img1.png" width="60%" />
</p>

In order to obtain a single region of the image (Region of Interest: ROi), we filter some desired values of the image by a threshold, and discrimine the parts of the image we are interested in, or not. This results in an image called mask, where every pixel would have the value of zero (0) or one (1).

<p align="center">
  <img src="images/Process_imatge/img5.png" width="60%" />
</p>
<p align="center">
  <em>Fig 5. Example of a Region of Interest. </em>
</p>


On this matrix we can operate easily, and we can finally reduce our parts of interest (worms), in order to obtain the pixels which configurate it and, in our case, obtain the length of the figures.  

<p align="center">
  <img src="images/Process_imatge/img7.png" width="40%" />
</p>

The processing of the images is developed by the user in modification panel. Image must be converted from Red-Green-Blue (RGB) to grayscale, to binary image, in order to isolate in these the desired objects, which are the worms.  

 We can operate with and analyse the objects in the binary image, for example isolating objects of interest, or analysising the morphology properties like length, circularity, area, etc. In WorMe there is many tools for operate with the objects, with the aim to obtain a mask in which we had the worms.


#### Image processing using MATLAB tools
The image processing functions used in the program are part of the MATLAB Toolboxes. For the image processment and analysis, the toolboxes [MATLAB Image Processing Toolbox](https://es.mathworks.com/products/image-processing.html), and the [MATLAB Computer Vision Toolbox](https://es.mathworks.com/products/computer-vision.html) offered a wide, useful and optimized variety of image processment and analysis functions.  
Some of the image functions mainly used in the progarm are:  
`imcrop()`:   Allows to easily cut the image from specific coordinates. This may help to opearte and select the objects and ROi.  
`im2gray()`:   Automatically converts the RGB image into grayscale.  
`imadjust()`:   Automatically adjust and normalize the greyscale values of the image.  
`imbinarize()`:   Binarize the image from a threshold, which may be statistically determined.  
`bwareaopen()`:   Allows to easy and fast cleaning of the small objects in the image.  
`imopen()` and `imclose()`:   Allows to reduce or expand the binarized objects, in order to reduce or increase their properties (ex: worm tail and profile).  
`imclearborder()`:   Automatically deletes the objects that touch the edges of the image.  
`imfill()`:   Automatically fills the binary objects, allowing the analysis of that ones.  
`bwskel()`: Skeletonization of the binary image. Useful for to obtain the main central line of *C. elegans*.

These functions are executed in the `processament_imatge_llistat` funcion in the program, which works based in the descrived list from Processment pannel of image modification and its values.  

<p align="right">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/Logos/Matlab_Logo.png" width="15%">
</p>

The implementation of the functions in the program has been tested and adapted to the *C. elegans* microscopical images. Numerous test has been developed in order to accurate the optimus functions and their configuration for the kind of images and its ROi. For example, most of the functions has been adapted to percentual values from the image, not by unique numerical values, in order to adapt the processment to the user images.  


<p align="center">
  <img src="images/Process_imatge/img3.png" width="60%" />
</p>
<p align="center">
  <em>Fig 6. Selection of the regions of interest (worms) of the initial image. </em>
</p>



### Skeletonize and branch reduction

Once the worm binary object is obtained, in order to obtain its length the image is skeletonized, then the branches are pruned to obtain the main length, and then the endpoints are extended. By this operations, we went from a binary object to have their main central line, which is analogue at the manual drawed one.

The skeletonization is the reduction from the binary object to a line. It is achieved by gradually reducing the surroundings of the image until achieves a line. In MATLAB it is developed by the `bwskel()` function [10]. In the program, the main function that develops the skeletonization and obtain the length of the worm object is `esqueletonitzacio_josep_optim()`.  

The prune of the short branches in the skeleton image is developed by the own made function `large_skel_iter()`. This returns the main branch from a skeletonized object.

Finally, because the skeletonization endpoints used to not touch the borders of the object, a function was created for lengthen the lines from endpoints to the object (see: [Endline elongation](#endline-elongation)).

<div align="center"> <img src="images/WM_branch_reduction.png" alt="Image Processing Panel" width="70%"> </div>



#### Endline elongation
Before we figure out about the [manual length error](#manual-length-error-correction), in order to approximate the measure from the head to the tail of the C. elegans, the start and finals of the reduced-skeletonized line was elongated to the final of the object, beacuse in the skeletonization the lines doesnt reach the finals.    
This function is developed by the function  `extendre_skel_estes_nou()`, inside the `esqueletonitzacio_josep_optim()`.  

<div align="center">
  <img src="images/branch2.png" alt="Image 1" width="45%" style="margin-right: 2%;">
  <img src="images/branch1.png" alt="Image 2" width="45%">
</div>

<div align="center">
  <img src="images/branch_cut_1.png" alt="Image 1" width="15%" style="margin-right: 25px;">
  <img src="images/branch_cut_2.png" alt="Image 2" width="15%" style="margin-left: 25px;">
</div>
<p align="center">
  <em>Figure X: (Left) Image processing panel. (Right) Another panel.</em>
</p>


<div align="center">
  <img src="images/branch7.png" alt="Image 1" width="25%" style="margin-right: 2%;">
  <img src="images/branch8.png" alt="Image 2" width="25%">
</div>

<p align="center">
  <em>Figure X: (Left) Image processing panel. (Right) Another panel.</em>
</p>




### Length determination

The main objective of the progarm is automatically determine the length of *C. elegans*.  
The manual length of *C.elegans* can be obtained using ImageJ [5], drawing manually a polyline from the tail to the head of C. elegans going through the middle of the worm as much accurate as it is possible.  
<br>

The function in which the length is obtained is in `esqueletonitzacio_josep_optim()`. Length is obtained thorugh the function `llargada_josep()`, and the corrected length (see: [Manual length error correction](#manual-length-error-correction)), from `llargada_josep_Fiji()`.  
<br>

WorMe performs an analog line drawing methodology for the length determination of the worms. In WorMe, a line is automatically obatined from the head to the tail of the worm mask object. This allows to obatin an theorically more accurate line than manually obtained.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/Fiji_vs_WorMe.png" width="80%">
</p>


The length of the worm in ImageJ is defined as the sum of the Euclidean distance of the dotted points descrived in the manually drawing process through the worm.  


<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/Fiji_measure.png" width="50%">
  <br>
  <em>Measurement with polyline using ImageJ</em>
</p>

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/img_ex_2.png" width="50%">
    <br>
  <em> Skeletonized and elonged line from a C.elegans mask using WorMe.</em>
</p>



The length in WorMe is based also in the Euclidean points, but in this case every pixel in the line is a point to consider in the length determination. The difference of number of points give a slightly measurement bias between WorMe and ImageJ (used in bias correction, see: [Manual length error correction](#manual-length-error-correction)).  




<div align="center">
  <img src="https://github.com/user-attachments/assets/e8926716-39b0-4de9-b299-8ab3f117f81d" alt="image-20230801-155918" width="40%">
  <br>
  <em>Euclidean distance</em>
</div>


In order to simplify and optimize the algorithm, the distance between pixels is obtained directly from the infered Euclidean principle distance of pixels, bein 1 for vertical or horizontal pixels, or $\sqrt{2}$ in the diagonal ones (See: `llargada_josep()` function).

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/i1.png" width="30%">
  <br>
  <em>Reference: <a href="https://es.mathworks.com/help/images/distance-transform-of-a-binary-image.html?lang=en">MATLAB: Distance Transform of a Binary Image</a></em>
</p>


<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/dist_img_skel_BO.png" width="65%">
</p>


Once the pixel-level distance is obtained, it is divided by the scale ratio, in order to obtain the empirical measurement of the worm.  
<br>



### Manual length error correction

Exist a meaningful difference between the measurements obatined by a manual drawing points, as it is in the ImageJ measurements, and the measures obtained from a skeletonized pruned line throughout the worm mask object, as is the case in WorMe. The difference of both methods is giving a statistical bias between the measurements of a set of *C. elegans* images using both methods.  
To compare the results of the software with the manual ones was the main way to validate the reliability of the use of the program. We compared continously our results with the manual measured results, in order to check the inference automatization in the use of the program.     

<br>
Curiously, we find the measurements was similar in some worms and not in others, without a simply shape difference between them.  
<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/comparison1_BO.png" width="100%">
</p>

We analysed the measurements noy just in worms but in straight drawed lines. First we analysed horizontal, vertical and diagonal lines, and the programa didn't give us bias with it. This struggles us because we validate the measurements with the software with this kind of control but not with empirical worm images. That fact made us to find the way to improve the software analysis of the image to find the possible causes, in example we thought that bias was due to the [endline elongation](#endline-elongation).  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/comparison3_BO.png" width="100%">
</p>


<br>
When we change the main validation control developed by lines, adding polylines, we saw there was difference between the measurements, and we research on it.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/comparison2_BO.png" width="100%">
</p>

We find that in ImageJ the manual length obtantion is made from a drawed polyline. The distance in this case is obtained throught the Eucledian distance between these dotted points. We figure out that exist a difference if the distance in a line is obtained thorught every pixel (which was our case), or if it is obtained every certain pixels.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/All_joined_horiz_bo.png" width="75%">
</p>

We saw if we drawed a polyline with our software the results was very similar, because the euclidean distance was obtained continuing the same methodology.  
Then we probe to obtain the distance from every certain pixels, in order to automatically emulate the manual measurement. We probe different distances, and conclude that if the measurement was made from the eucledian distance from every 5 pixels in the line of the worm, we obtained values like the ones obtained from the manual measurements. We conclude, this correction was made by 



<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/comparison5_BO.png" width="100%">
</p>

Finally, we conclude if the bias manual error correction was applied, which means to measure the same line every 5 pixels, emulating the manual measurement, the measures was same as the manually obatined through ImageJ and we could validate the length obtaintion of the software.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/comparisons/comparison4_BO.png" width="100%">
</p>


The images made for the validation can be founded in [Worme/examples](https://github.com/group-nn-at-icmab-csic/WorMe/tree/main/examples), and the results of the Fiji measurements and their analysis with the correction can be founded in the folder [documentation/Comparison_studies/Fiji_vs_WM](https://github.com/group-nn-at-icmab-csic/WorMe/tree/main/documentation/Comparison_studies/Fiji_vs_WM). You can also find the exportation file of prove for the distance of the pixel validation in the [documentation/Comparison_studies/Pixel_dist_bias_proves](https://github.com/group-nn-at-icmab-csic/WorMe/tree/main/documentation/Comparison_studies/Pixel_dist_bias_proves) folder.

<br> 

In WorMe, `llargada_josep_Fiji()` obatins the length of the skeletonize applying the manual factor correction. In the program, it is 5, which means 5 pixels every each point.  
`llargada_josep()` obtains the length of the skeletonize image for every pixel. Both are in the main function of length and skeletonization from the mask image `esqueletonitzacio_josep_optim()`.  

<br>
<br>


### Image data

WorMe provides image data useful to be used as golden standard for deep learning models, or for the object analysis.  

WorMe does not use artificial intelligence (AI) despite it is the state-of-the-art of the image processing and analysis. Many software are based on deep learning neural networks for the selection or identification of *C. elegans* in the images. Despite that, the program is consciousness about the data obtaintion and use for the creation of models, and it allows the user to export the graphical data in different formats (PascalVOC, label, binary, etc.) in order to be used for IA model building, and also for the object analysis (width, shape, etc.).

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/asdf.png" width="18%">
</p>

<br>

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/Image_969.jpg" width="50%">
  <br>
  <em> Image example </em>
</p>



#### Binary objects
Binary objects may be useful for the object analysis and also for the segmentation models in deep learning. The program offers the option to export these objects for the user to analyse or use it.  

**Individual masks**
<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/Image_969_01.png" width="50%">
  <br>
  <em> Binary mask 1.</em>
</p>
<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/Image_969_02.png" width="50%">
  <br>
  <em> Binary mask 2.</em>
</p>


**Joined masks**
<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/Image_969_Joined.png" width="50%">
  <br>
  <em> Joined masks.</em>
</p>

<br>

The use of the binary objects is wide. We can see, for example, easily the width of the worm, in different parts of it, or in some regions. Some other research base the shape of the worm to determin the phenotype, among other. The option to use the binary object opens an outlook of possibilities.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/width_BO.png" width="80%">
    <br>
  <em> Width analysis from binary object. </em>  
</p>



#### Indexed images

Indexed images may be useful for the deep learning model creations. Some of the model uses this kind of images in order to create the model.  
We offer two types of idnexed images, where the value of the object is singular for every object, or they have the same one. 


<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/Image_969_label.png" width="50%">
      <br>
  <em> Indexed objects. </em>  
</p>

#### Pascal VOC

PascalVOC is a .xml file which may be useful for the identification by bounding boxes deep learning model creation, among others. Is for this reason that we include it in the graphic export.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/example_use/969_PascalVOC.png" width="50%">
      <br>
  <em> Pascal VOC file. Rounded the bounding box coordinate. </em>  
</p>


#### Examples of graphic export

<br>
You can find examples of exported graphic data in <br>
<a href="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/examples/Example_images_C24/C_24_graphic_results.zip">examples/Example_images_C24/C_24_graphic_results.zip</a>, <br>
<a href="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/examples/Example_images_C48/C_48_graphic_results.zip">examples/Example_images_C48/C_48_graphic_results.zip</a>, <br>
<a href="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/examples/Example_images_C72/C_72_graphic_results.zip">examples/Example_images_C72/C_72_graphic_results.zip</a>.




### Computational optimization

WorMe is a user-based designed software. This implyes that the time in the use of the program must be short, not having many delaying in the use of it.  
The image processment and image data analysis is a process that have a considerable computational times of consume. This means that, for example, in the operation of an image and its analysis (example: opening the image with the function `imread()`, or binarizing a whole image by `imbinarize()`, etc.) the computer is going to need time to computational develop the task. The time consumption also happen with the data save and open. The program’s computational operation has been optimized in order to rely a good timing in the processment and analysis of the image and objecs, and in the time of using by the user. We had to continously consider the software architecture and the data and image acquisition and operation in order to develop a program which process would have a short time of computational consume.  
Softwares like WormMachine are fully user optimized, but some other programs like WormAlign made the user to wait to the processment and analysis of the full stuck of the images.  


<br>
An useful function in MATLAB is the `tic`and `toc` functions to obtain the time of a process.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/use_of_the_program/Elapsed_times.png" width="25%">
</p>
<br>

Most of the functions using the program are MATLAB already made. We use the MATLAB functions as much as we can because they are per se fully optimized functions. Example of them are `imbinarize()`, `imread()`, `imopen()`, and so many other functions.  

<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/Process_imatge/timings.png" width="55%">
  <em> Example of time analysis in the use of the program. </em>  
</p>



#### Image analysis and processment

One of the main time-consuming process in the software is the acquisition, operation and analysis of the images. For example, in a 8Gb RAM i5 CPU (2022) computer the time of consumption for open a image using `imread()`function, is 0,03 seconds, develop the `im2gray()` function 0,002 seconds, `imbrinarize()` 0,03 seconds, etc.  
This time consuming when is punctually applied doesn't cause a sum of delaying times, but when they are stack applyied, the conumption times are summed and there is a big time delaying. For this reason, the program has reduced as much as possible the use of some functions. One example is the opening and save of the image.  
WorMe works with the rute of the files. In the main script `WM_length_determination.m` the variable `theFiles` is saved and used thorughout the program, which contains the rutes of the selected images. In the selection and processment, WorMe develop the functions individually to the mask objects (see: [Work with indexes](#work-with-indexes).   
The program develop the analysis individually of every image, in the moment the user select the function (modify, manually select, etc.). By this way, the functions are individually developed, implying singular functions and short times.  

#### RAM consumption and data acquisition
A big concern about the timings in the use of the program was the RAM consumption, and secondarly the disk memory use. The program just save the rutes of the images in the `theFiles` variable of the main script. All the data is saved in the `Results_out` folder, in the folder of the program if it is used from MATLAB Desktop, or in Documents if the software used is the executable file (compiled one). In `Results_out` folder the `Internal_code_files` folder save the image modifications data, and then from a `date_folder_of_image_names` folder is saved the defined scale (`escala_imatge.mat`), the processment parameters (in the folder `Processment_parameters`), and the main file and most important is the `main_data_analysis.txt`.  
The `main_data_analysis.txt` is the file in which the data of the images are saved. The acquisition and operation to this file was fully optimized in order to obtain good use of the program timings.  
The function `llegir_dades()` is the one used for the reading of the `main_data_analysis.txt` file, where every position is a kind of data (if it is C. elegans, the worm name, length, bounding box coordinates, modifications developed, index of the skeleton, index of the mask (BW), width values, etc.).  
ççç


Note: The data of the program is saved in a `.txt` file and not in a `.mat` file for unkdnowledge. Functions for the `.txt` optimized writting was developed, but lately we saw the save of the data in a `.mat` file was more easy and optimized, but the software structure was already settled and we chose to not change it.  


#### Work with indexes
The program in a strart used to work opening and saving the analysed images, which concerns a big data memory use, and the 





The result is that in 8Gb RAM i5 CPU the elapsed time for a main object processment in the selection panel is 0,03 seconds (← approximate, must validate).

In the selection panel the whole image is processed and their objects are isolated in a MATLAB file, saved in as indexed coordinates because of the computational optimization. For every object the skeletonization and operation is developed and showed, and the selection done by the user is saved. 


WorMe works using the rute of the selected images (in the code: *theFiles* variable). The image data is saved in a , and saves the main data of images and analysis in physical files.  
ççç explicar els passos i com es guarden les dades.








----------------------------------------------


*This project has been granted by the JAE Intro grant for the introduction of young people to the research, by the Ministerio de Ciencia, Innovacion y Universidades ([ciencia.gob.es](https://www.ciencia.gob.es/)) y el Consejo Superior de Investigaciones Científicas ([CSIC](https://www.csic.es/es)).*  
<p align="center">
  <img src="https://github.com/group-nn-at-icmab-csic/WorMe/raw/main/documentation/images/Logos/jae.png" width="30%">
</p>


