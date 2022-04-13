const setThemeColor = (color) => {
  const meta = document.querySelector('meta[name="theme-color"]')
  if (meta) {
    meta.setAttribute('content', color)
  }
}

if ("IntersectionObserver" in window) {
  const observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        const { isIntersecting, target } = entry
        if (isIntersecting) {
          if ($(target).hasClass('default-color')) {
            var color = '#273c4c';
          } else if ($(target).hasClass('light-default')) {
            var color = '#ecf2f5';
          } else if ($(target).hasClass('white-default')) {
            var color = 'white';
          } else {
            var color = window.getComputedStyle(target).getPropertyValue("background-color");
          }
          setThemeColor(color)
        }
      })
  }, {
    root: document.getElementById('viewport'),
    rootMargin: "1px 0px -100% 0px",
    treshold: 0.1
  })

  document.querySelectorAll('.section').forEach(section => {
    observer.observe(section)
  })
}
