using Toybox.Application;
using Toybox.WatchUi;

class EasyNoteApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    function onSettingsChanged(){
      WatchUi.requestUpdate();   // update the view to reflect changes
    }
    
    // Return the initial view of your application here
    function getInitialView() {
        return [ new EasyNoteView(), new EasyNoteDelegate() ];
    }

}
