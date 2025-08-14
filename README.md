# COMP2005 – Digital Image Processing  
**Daniel Hartgrove – Coursework Report**

---

## Introduction
When writing my processing script, I understood that I had to carefully consider the steps taken to produce a suitable output. My initial thought process for this script was that I would first convert the image to a **green-only colour space**, then use these values to *embinarize* the image.  

The actual process involved:
- Noise reduction of both images.
- Segmenting the image using **Otsu thresholding**.
- Utilising MATLAB’s inbuilt methods.

My aim for the script was to have as few user-supplied parameters as possible, dynamically calculating the adjustments to the image based on factors such as:
- The image dimensions.
- The calculated threshold.

To achieve this, I found many of MATLAB’s inbuilt functions, such as `graythresh`, incredibly useful.

---

## Converting the Image to a New Colour Space
In order to convert the image into a new colour space, I had to consider which space would be needed.  
Since I was processing **plant material**, the most relevant colour to extract was **green**.

I chose to convert the image to a green colour space by:
1. Removing the **red** and **blue** channels *(lines X through Y in the script)*.
2. Converting the result to **grayscale** from the green channel.

The reason for converting to grayscale was:
- To make the process of embinarizing the image less computationally intensive.
- To ensure only one colour channel was being processed.
- The **whitest objects** in the grayscale output correspond to the **greenest areas** in the original image, which would help with thresholding.

---

## Reducing Noise in the Image
To make the process smoother, I decided to reduce noise in the image.  
This would help with identifying plant matter rather than false positives caused by light reflecting off soil, which can appear partially green to the camera sensor.

I opted to use a **filter optimised for edge preservation** in order to:
- Maintain the edges of the plant matter (important for accurate identification).
- Avoid blurring or distorting significant boundaries.

---
