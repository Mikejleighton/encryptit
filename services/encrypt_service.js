
// Service that is used for encrypting and decrypting files. 
var encrypt_service = {

    // Encrypt a file. 
    encrypt_file: (file, password, result) => {

        // Read the file. 
        var reader = new FileReader();

        // When the file is read. 
        reader.onload = function (e) {

            // Encrypt the file. 
            var encrypted = CryptoJS.AES.encrypt(e.target.result, password)
            result(encrypted)
        }
        reader.readAsDataURL(file)
    },

    // Decrypt the file. 
    decrypt_file: (file, password, result) => {

        // Read the file. 
        var reader = new FileReader();

        // When the file is read. 
        reader.onload = function (e) {

            // Decrypt the file. 
            var decrypted = CryptoJS.AES.decrypt(e.target.result, password).toString(CryptoJS.enc.Utf8);
            if(!/^data:/.test(decrypted)){
                alert("Invalid pass phrase or file! Please try again.");
                result(null, false)
                return
            }
            result(decrypted, true)
        }
        reader.readAsText(file)
    }
}

// Export to the rest of the application. 
services.encrypt_service = encrypt_service
