document.addEventListener("DOMContentLoaded", function(){

  signUpBtn=document.querySelector("#lay_up");
  postProfDisplay=document.querySelector("#home_post_scroll");
  usrProfLink=document.querySelectorAll(".home_post_u");
  usrProfTp=document.querySelectorAll(".home_post_tp");

  // usrProfLink.addEventListener("mouseover", function(){
  //   usrProfTp.style.opacity=1;
  // });

  function show_tp(){
    usrProfTp.style.opacity=1;
  }

  // usrProfLink.addEventListener("mouseout", function(){
  //   usrProfTp.style.opacity=0;
  // });
  //
  // usrProfLink.addEventListener("click", function(){
  //   postProfDisplay.classList.add("home_display_post");
  // });
  //
  // //  Reset animation after event so it will fire again.
  // usrProfLink.addEventListener("animationend", function(event){
  //   postProfDisplay.classList.remove("home_display_post");
  // })

})
