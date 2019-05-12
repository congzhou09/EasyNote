using Toybox.Graphics;
using Toybox.WatchUi;

class EasyNoteView extends WatchUi.View {

    function initialize() {
        View.initialize();
        textRender = new WrapTextMine();   
        easyNoteModel.getContent();
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

        easyNoteModel.getContent();
        textRender.writeLines(dc, easyNoteModel.noteContent, Graphics.FONT_TINY, 0);      
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
