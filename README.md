# MBZIRC Target Detection Dataset

## What is this dataset?

This dataset is created from the tests performed by the AirLab (Carnegie-Mellon University Robotics Institute) for MBZIRC 2017 competition. The dataset contains 1,967 images for the purpose of testing algorithms implemented for the detection of Challenge 1 target. It can also be used for real-time ellipse detection algorithms. 

All the directories contain the images of the target similar to what used in the finals of the competition. The only exception is the `gascola_target` directory, which contains a different (thinner) design, which can be used for testing the performance of the detectors optimized for the MBZIRC target on a slightly different target.

## How can we use it?

Each directory contains a table of ground-truth values in the `ground_truth.txt` file. The first line of the table is the header, which explains each column of the table. 

**Note:** There are a few rows in that don't have the ground truth yet. Currently the values are filled with *-1.000*. They will be replaced with the actual values soon. 

## What is the MATLAB code for?

The code is used for the creation of the ground truth using the output of our algorithm. You can modify the code according to your needs (to read the dataset files, etc.). 

## Who do I talk to?

Please contact *Azarakhsh Keipour (keipour@gmail.com)* with any problems or questions about the dataset.

### License ###
[This software is BSD licensed.](http://opensource.org/licenses/BSD-3-Clause)

Copyright (c) 2018, Carnegie Mellon University
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.