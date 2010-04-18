Event.observe(window, 'load', function(){
 Event.observe($('addbtn'), 'click', addUser, false);
 Event.observe($('user_name'),'keydown', eventKey, false); 
}, false);


function addUser(){
  var user = $F('user_name');
  var list = $('user_name_auto_complete').getElementsByTagName('li');

  for(var i = 0;i < list.length; i++){
     var name = "";
     if (list[i].textContent != "undefined"){
         name = list[i].textContent;
     } else {
         name = list[i].innerText;
     }
     if (name == user){
         $('addfield').appendChild(list[i].firstChild);
         var h = document.createElement("input");
         h.type = "hidden";
         h.name = "twitter[]";
         h.value = name;
         $('addfield').appendChild(h);
         break;
     }
  }
  $('user_name').value = "";
}


function eventKey(evt) {
  if ( evt.keyCode == Event.KEY_RETURN ){
    addUser();
    return false;
  }

}
