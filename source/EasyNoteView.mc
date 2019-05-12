using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Application;

class EasyNoteView extends WatchUi.View {

    var writer;
    var noteContent;

    function initialize() {
        View.initialize();
        writer = new WrapText();   
        getContent();
    }

    function getContent(){
      noteContent = Application.getApp().getProperty("NoteContent");
	  if(noteContent.equals(""))
	  {
	    noteContent = "内容为空!";
	  }
	  else
	  {
	    System.println(noteContent);
	  }
    }
    // Load your resources here
    function onLayout(dc) {
      
//        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        getContent();
        var posY = 0;
        posY = writer.writeLines(dc, noteContent, Graphics.FONT_TINY, 0);      
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
