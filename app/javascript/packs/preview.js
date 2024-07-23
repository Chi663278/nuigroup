document.addEventListener('DOMContentLoaded', () => {
  const createImageHTML = (blob) => {
    const modalElement = document.getElementById('modal');
    const imageElement = document.getElementById('new-image');
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-img rounded shadow mb-3');
    blobImage.setAttribute('src', blob);

    imageElement.appendChild(blobImage);
  };

  document.getElementById('user_image').addEventListener('change', (e) => {
    const imageContent = document.querySelector('img.new-img');
    if (imageContent){
      imageContent.remove();
    }

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
  });
});

document.addEventListener('DOMContentLoaded', () => {
  const createImageHTML = (blob) => {
    const modalElement = document.getElementById('modal');
    const imageElement = document.getElementById('new-image');
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-img rounded shadow mb-3');
    blobImage.setAttribute('src', blob);

    imageElement.appendChild(blobImage);
  };

  document.getElementById('post_image').addEventListener('change', (e) => {
    const imageContent = document.querySelector('img.new-img');
    if (imageContent){
      imageContent.remove();
    }

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
  });
});
