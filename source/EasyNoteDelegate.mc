using Toybox.WatchUi;

class EasyNoteDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
//        WatchUi.pushView(new Rez.Menus.MainMenu(), new EasyNoteMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    
    function onKey(keyEvent) {
        if(keyEvent.getKey() == KEY_UP)
        {
          textRender.rollUp();
        }
        else if(keyEvent.getKey() == KEY_DOWN)
        {
          textRender.rollDown();
        }
        return true;
    }

}