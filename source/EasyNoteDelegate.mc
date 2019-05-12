using Toybox.WatchUi;

class EasyNoteDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new EasyNoteMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}