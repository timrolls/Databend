/*  
 Databend -  Loads an input file, and randomly changes image data, corrupting the image unpredictably 
 
 Copyright (C) 2019 Tim Rolls
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

/*********************************************************************

 Requires an image file in the sketch folder
 
 Pause iterations with space
 Save with R
 
 *********************************************************************/

PImage a;  
boolean paused = false;
int iterations = 100;
int count=0;

String format = "jpg";
String fileName = "input";          //change this or rename your input file
String tempFile = "temp";

void setup() {
  background(0);
  byte[] data=loadBytes(fileName+"."+format);
  a = loadImage(fileName+"."+format);
  saveBytes(tempFile+"."+format, data);
  size(100, 100, P2D);
  surface.setSize(a.width, a.height); //Processing 3 req
}

void draw() {
  byte[] data=loadBytes(tempFile+"."+format);

  if (count<=iterations) {
    for (int i=0; i<4; i++)
    {
      int loc=(int)random(127, data.length-1); //choose byte outside guessed 128 byte header
      data[loc]=(byte)random(249);
    }

    saveBytes(tempFile+"."+format, data);
    a = loadImage(tempFile+"."+format);
    image(a, 0, 0); //redraw modified image
    count++;
  }
}

void keyPressed() {

  if (key == ' ') { //pause on spacebar
    if (paused) {
      loop();
      paused = false;
    } else {
      noLoop();
      paused = true;
    }
  }

  if (key == 'r') {
    saveFrame("output/output_###."+format);
  }
}
