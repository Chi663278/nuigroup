if (document.URL.match(/new/)){
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img shadow mb-3')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };

    document.getElementById('post_image').addEventListener('change', (e) => {
      const imageContent = document.querySelector('img');
      console.log(imageContent);
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}