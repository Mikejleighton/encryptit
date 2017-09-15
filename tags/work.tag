<work>

    <navigation selected="home"></navigation>

    <div class="container">
        <div id="center_loading" class="inner cover">
            <div class="loader"></div>
            <h3 class="cover-heading">{message}</h1>
        </div>
    </div>

    <style>
        #center_loading {
            display: table;
            margin-right: auto;
            margin-left: auto;
        }

        .loader {
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #2c3e50;
            width: 120px;
            height: 120px;
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    </style>

    <script>
        var job = services.job_cache_service
        if (job.file == null) {
            this.message = 'Internal state error'
            return
        } else {
            this.message = 'Working...'
        }

        // Show this screen for atleast 1 sec. 
        window.setTimeout(function () {

            if (job.is_encrypting) {
                var encrypt = services.encrypt_service
                encrypt.encrypt_file(job.file, job.password, (encrypted) => {
                    job.contents = encrypted
                    console.log('file has been encrytped' + job.contents)
                    window.location.href = '#/done'
                })
            } else {
                var encrypt = services.encrypt_service
                encrypt.decrypt_file(job.file, job.password, (decrypted, success) => {

                    if (!success) {
                        return
                    }

                    job.contents = decrypted
                    console.log('file has been encrytped' + job.contents)
                    window.location.href = '#/done'
                })
            }

        }, 1000);
    </script>

</work>