<home>
  <navigation selected="home"></navigation>
  <div class="container">

    <div id="encrypt_box" class="jumbotron">
      <h1>Encrypt It</h1>
      <p>To encrypt or decrypt a file simply drag and drop the it over the site, enter the appropriate password, and click next.</p>
      <div class="action_box">
        <div class="action_text">
          <p>Drag Here</p>
        </div>
      </div>
    </div>

  </div>

  <style>
  .action_box {
      border-style: dotted;
      height: 200px;
    }
    .action_txt{
      display: table;
      text-align:center;
      margin-right: auto;
      margin-left: auto;
    }
  </style>

  <script>
    this.on('mount', () => {

      // Check to see if the browser supports file reader. 
      if (!window.FileReader) {
        document.getElementById('encrypt_box').innerHTML =
          'Your browser does not support the HTML5 FileReader.'
      }

      // Function to cancel the default behavior. 
      function cancel(e) {
        e.preventDefault()
        return false
      }

      // Start the encryption or decryption process. 
      function encrypt_or_decrypt_file(e) {
        e.preventDefault()

        // Check to see if we need to encrypt or decrypt. 
        console.log(e.dataTransfer.files[0].name)
        if (e.dataTransfer.files[0].name.includes('encrypted')) {

          console.log('decrypt')
          decrypt_file(e)
        } else {

          console.log('encrypt')
          encrypt_file(e)
        }
      }

      // Start the encryption process for a file. 
      function encrypt_file(e) {

        // Setup encryption for the first file only. 
        services.job_cache_service.is_encrypting = true
        services.job_cache_service.file = e.dataTransfer.files[0]

        console.log('Setup for encryption')

        window.location.href = '#/password'
        return false
      }

      // Start the decryption file. 
      function decrypt_file(e) {

        // Setup decryption for the first file only. 
        services.job_cache_service.is_encrypting = false
        services.job_cache_service.file = e.dataTransfer.files[0]

        console.log('Setup for decryption')

        window.location.href = '#/password'
        return false
      }

      // Cross browser add event handler. 
      function addEventHandler(obj, evt, handler) {
        if (obj.addEventListener) {
          // W3C method
          obj.addEventListener(evt, handler, false);
        } else if (obj.attachEvent) {
          // IE method.
          obj.attachEvent('on' + evt, handler);
        } else {
          // Old school method.
          obj['on' + evt] = handler;
        }
      }

      // Get the encrypt box. 
      var encrypt = document.getElementById('encrypt_box')

      // Encrypt
      addEventHandler(encrypt, 'dragover', cancel)
      addEventHandler(encrypt, 'dragenter', cancel)
      addEventHandler(encrypt, 'drop', encrypt_or_decrypt_file)

    })
  </script>

</home>