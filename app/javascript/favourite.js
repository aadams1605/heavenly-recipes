document.addEventListener('DOMContentLoaded', function() {
  const heartIcon = document.getElementById('heartIcon');

  heartIcon.addEventListener('click', function() {
    console.log("Heart icon clicked");
    heartIcon.classList.toggle('clicked');
  });
});
