const heartIcons = document.querySelectorAll('.fas.fa-heart');

heartIcons.forEach((heartIcon) => {
  heartIcon.addEventListener('click', (event) => {
    event.currentTarget.classList.toggle('clicked')
  })
})
