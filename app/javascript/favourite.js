const heartIcons = document.querySelectorAll('.fas.fa-heart');

heartIcons.forEach(function(icon) {
    icon.addEventListener('click', function() {
        alert("hi");
        icon.classList.toggle('clicked');
    });
});
