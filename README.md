# MRFGF-HDR
Motion-Registration-Free Gradient Fusion for High Dynamic Range Deghosting

### Overview
This package is an implementation of the of the paper HDR Deghosting Using Motion-Registration-Free Fusion in Luminance Gradient Domain, by Cheng-Yeh Liou, Cheng-Yen Chuang and Yi-Chang Lu.

### Prerequisites

Github repositories [Multi-Exposure and Multi-Focus Image Fusion](https://github.com/sujoyp/gradient-domain-imagefusion) and [laplacianBlend](https://github.com/rayryeng/laplacianBlend) are needed to be dowloaded.
Make sure their repositories are placed under src/ folder before running our code.

### Data
The image sequence [pingpong](http://projects.ius.edu.ba/ComputerGraphics/HDR/hdri2014.html) and [SculptureGardenSequence](http://alumni.soe.ucsc.edu/~orazio/deghost.html) are included in Data/ folder.
Users are encouraged to put their own data under the Data/ folder and make neccessary modification on main.m to test our performance on their data.
The exposure time of the image sequence is needed to perform our algorithm. If the exposure time of the image is not accessible by the MATLAB function imfinfo(filename,extension).DigitalCamera.ExposureTime, please specify the exposure time by t = [t1 t2 t3....]. See line 22 in main.m for an example. 


### Running
The package can be executed by running the main.m script.  By default, it will load the 'SculptureGardenSequence' image sequence and produce result on result/ folder.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details


### Citation
Please cite the following work if you use this package.
```javascript
@article{,
  title={HDR Deghosting Using Motion-Registration-Free Fusion in Luminance Gradient Domain},
  author={XXX},
  journal={XXX},
  volume={XX},
  number={XX},
  pages={XXXXXX},
  year={XXXX},
  publisher={XXXXXXX}

}
```

### Contact
Please contact Cheng-Yeh Liou(r05943171@ntu.edu.tw) or Yi-Chang Lu(yiclu@ntu.edu.tw) for any questions.





