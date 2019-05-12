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
  hidden var curPageWordCount;
  hidden var wordOffset;
  hidden var wordOffsetArr;
  hidden var isLastPage;
  hidden var pageCount;

  function initialize() {
      WrapText.initialize();
      
      roundMargin = 20;
      curPageWordCount = 0;
      wordOffset = 0;
      wordOffsetArr = [];
      isLastPage = false;
      pageCount = 0;
  }
  
  // Write the text in lines fit on the screen,
  // return posY for next line
  function writeLines(dc, text, font, posY) {
    if (posY >= screenHeight) {
      return posY;
    }
    // Should have some space above
    if (posY == 0) {
      posY = linePadding;
    }
    // On round screens, needs more space from top, otherwise always zero width
    if( screenShape == System.SCREEN_SHAPE_ROUND && posY < roundMargin ) {
      posY = roundMargin;
    }
    
    curPageWordCount = 0;//当前页的字符数量重新统计
    if(wordOffset > 0)
    {
      text = text.substring(wordOffset, text.length());
    }
    var textLen = text.length();
    var height = dc.getFontHeight(font);
    var parts = ["", text];
    while( parts.size() == 2 && (posY - screenHeight).abs()>=height + linePadding) {
      var width = getWidthForLine(posY, height);
      // Now calculate how much fits on the line
      parts = lineSplit(dc, parts[1], font, width);
      drawText(dc, width, posY, font, parts[0]);
      curPageWordCount += parts[0].length();
      if(parts.size() != 2)
      {
        isLastPage = true;
      }
      else
      {
        isLastPage = false;
      }
      posY += height + linePadding;
    }
    
    //分页信息
    if(wordOffset == 0)
    {
      pageCount = textLen/curPageWordCount;
      pageCount += (textLen%curPageWordCount != 0)?1:0;
    }
    var pageString = Lang.format("$1$/$2$", [wordOffsetArr.size()+1, pageCount]);
    dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
    dc.drawText(screenWidth/2, 0, Gfx.FONT_XTINY , pageString, Gfx.TEXT_JUSTIFY_CENTER );
    return posY;
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
  
  // Return the width at certain Y position
  function getWidthAt(posY) {
//    posY = posY % screenHeight;
    if( screenShape == System.SCREEN_SHAPE_RECTANGLE ) {
      return screenWidth;
    }
    var r = screenWidth / 2;
    var dY = posY - screenHeight/2;
    if( dY.abs() >= r ) {
        return 0;
    }
    
    var a = Math.asin(dY.toFloat()/r);
    var w = 2 * (r * Math.cos(a));
    return w.toNumber();
  }
  
  //上翻页
  function rollUp(){
    var len = wordOffsetArr.size();
    if(len>0)
    {
      isLastPage = false;
      wordOffset = wordOffsetArr[len-1];
      if(wordOffset<0)
      {
        wordOffset = 0;
      }
      wordOffsetArr = wordOffsetArr.slice(0, len-1);

//System.println(wordOffsetArr);
      Ui.requestUpdate();
//    System.println("up");
    }
    
  }
    
  //下翻页
  function rollDown(){
    if(!isLastPage)
    {
      wordOffsetArr.add(wordOffset);
      wordOffset += curPageWordCount;
//    System.println(wordOffsetArr);
      Ui.requestUpdate();
//    System.println("dwon");
    }
  }

}
