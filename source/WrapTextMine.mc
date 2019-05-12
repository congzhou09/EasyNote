// Copyright 2017 by HarryOnline
// https://creativecommons.org/licenses/by/4.0/
//
// Wrap text so lines will fit on the screen

using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;
using Toybox.Timer;

class WrapTextMine extends WrapText {

  function initialize() {
      WrapText.initialize();
  }
    
  function lineSplit(dc, text, font, width) {
    var os = 0;
    var parts = wordSplit(text, os);
    var count = 0;
    while (parts.size() == 2 && count < 15) {
//      System.println(parts[0].length());
      var newParts = wordSplit(text, parts[0].length());
      if (dc.getTextWidthInPixels(newParts[0], font) > width ) {
          break;
      }
      count ++;
      parts = newParts;
    }
    return parts;
  }
  
  function wordSplit(subject, start) {
    var len = subject.length();
    var substr = subject.substring(start, len);
    var ptr = 1;//英文环境下通过空格断词的代码修改，因为中文环境认为任意两个字符之间就可以断词
    return (start+ptr>=len) ? [subject] : [subject.substring(0, ptr+start), subject.substring( ptr+start, len)];
  }

  // Find alignment, draw the text
  function drawText( dc, width, posY, font, text ) {
//    if( screenShape != System.SCREEN_SHAPE_RECTANGLE || rectangleAlignment == Gfx.TEXT_JUSTIFY_CENTER ) {
    if( rectangleAlignment == Gfx.TEXT_JUSTIFY_CENTER ) {
      dc.drawText(screenWidth/2, posY, font, text, Gfx.TEXT_JUSTIFY_CENTER );
    } else if( rectangleAlignment == Gfx.TEXT_JUSTIFY_LEFT ) {
      dc.drawText(screenWidth/2 - width/2, posY, font, text, Gfx.TEXT_JUSTIFY_LEFT );
    } else {
      dc.drawText(screenWidth/2 + width/2, posY, font, text, Gfx.TEXT_JUSTIFY_RIGHT );
    }
  }

}
