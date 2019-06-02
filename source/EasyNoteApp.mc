using Toybox.Application;
using Toybox.WatchUi;

var easyNoteModel = new EasyNoteModel(); //笔记内容管理
var textRender; //笔记内容渲染

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
      EasyNoteView.resetContent();
      WatchUi.requestUpdate();   // update the view to reflect changes
    }
    
    // Return the initial view of your application here
    function getInitialView() {
        return [ new EasyNoteView(), new EasyNoteDelegate() ];
    }

}
