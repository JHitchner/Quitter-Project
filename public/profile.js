var profileModal =document.getElementById("edit_form");
var editLink = document.getElementById("edit_link");
var updateBtn = document.getElementById("submit_edit");


editLink.addEventListener("click", function(){
  profileModal.style.display= "block";
});

updateBtn.addEventListener("click", function(){
  profileModal.style.display = "none";
});
