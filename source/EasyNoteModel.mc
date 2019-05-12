using Toybox.Application;


class EasyNoteModel {
    var noteContent;
    function getContent(){
      noteContent = Application.getApp().getProperty("NoteContent");
	  if(noteContent.equals(""))
	  {
	    noteContent = "内容为空!";
	  }
    }
}