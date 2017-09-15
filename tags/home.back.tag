<home>
  <div class="container">

    <navigation selected="home"></navigation>

    <div class="inner cover">
      <p class="lead">Drag a file to encrypt or decrypt it using your browser</p>
      <div id="encrypt_box" class="upload_box">
        <p class="lead">Enrypt</p>
      </div>
      <div class="upload_box">Decrypt</div>
      <a id='linkman' href="http://www.htmlgoodies.com/html5/javascript/drag-files-into-the-browser-from-the-desktop-HTML5.html">Link</a>
    </div>

  </div>

  <script>
    this.on('mount', () => {

      console.log('home mounted')

      if (window.FileReader) {

        console.log('file reader supported')
        

          var status = document.getElementById('encrypt_box');
          var drop = document.getElementById('encrypt_box');
          var list = document.getElementById('encrypt_box');

          function cancel(e) {
            console.log('in cancel')
            e.preventDefault()
            return false;
          }

          function encryptFiles(e){
            console.log('encrypt files')
            e.preventDefault();

            var files = e.dataTransfer.files
            for(var i = 0; i < files.length; i++){
              var file = files[i]
              console.log('files ' + file)

              //encryptTheFile(file)
              decryptTheFile(file)
            }
            return false
          }

          // Tells the browser that we *can* drop on this target
          addEventHandler(drop, 'dragover', cancel)
          addEventHandler(drop, 'dragenter', cancel)
          addEventHandler(drop, 'drop', encryptFiles)
      } else {
        document.getElementById('encrypt_box').innerHTML = 'Your browser does not support the HTML5 FileReader.';
      }


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

      function decryptTheFile(file){

        var reader = new FileReader();
        reader.onload = function(e){
          console.log('reader.onload' + e.target.result)

          password = "thisiscoolwillitwork"
          var decrypted = CryptoJS.AES.decrypt(e.target.result, password).toString(CryptoJS.enc.Utf8);
                                       // .toString(CryptoJS.enc.Latin1);

          if(!/^data:/.test(decrypted)){
              alert("Invalid pass phrase or file! Please try again.");
              return false;
          }

          var a = document.getElementById('linkman')
          a.href = decrypted
          a.download = file.name + '.again'


        }
        reader.readAsText(file)

      }


      function encryptTheFile(file){

        var reader = new FileReader();
        reader.onload = function(e){
          console.log('reader.onload')

          //console.log('result ' + e.target.result)

          // Use the CryptoJS library and the AES cypher to encrypt the 
          // contents of the file, held in e.target.result, with the password

          password = "thisiscoolwillitwork"
          //var encrypted = CryptoJS.AES.encrypt(e.target.result, password);
          //var base64content = e.target.result
          var encrypted = CryptoJS.AES.encrypt(e.target.result, password);

          console.log('not encrypted: ' + e.target.result)

          console.log('encrypted: ' + encrypted)
          // The download attribute will cause the contents of the href
          // attribute to be downloaded when clicked. The download attribute
          // also holds the name of the file that is offered for download.

          //a.attr('href', 'data:application/octet-stream,' + encrypted);
          //a.attr('download', file.name + '.encrypted');

          var a = document.getElementById('linkman')
          a.href = 'data:application/octet-stream,' + encrypted
          a.download = file.name + '.encrypted'


          //var d = CryptoJS.AES.decrypt(encrypted, password).toString(CryptoJS.enc.Utf8);
          //console.log('decrypted ' + d);

          //a.attr('href', 'data:application/octet-stream,' + encrypted);
          //a.attr('download', file.name + '.encrypted');


        }
        reader.readAsDataURL(file)
      }

    })
  </script>

  <style>
    .upload_box {
      border-style: dotted;
      height: 100px;
      margin: 10px;
    }
  </style>
</home>