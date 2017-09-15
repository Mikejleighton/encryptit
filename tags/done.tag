<done>

    <navigation selected="home"></navigation>




    <div class="container">
        <div id="encrypt_box" class="jumbotron">
            <h1>Done</h1>
            <p>The file {org_file_name} has been {encrypted}. Press the download button to save the file.</p>
            <p><a id='download_link' class="btn btn-primary btn-lg" href="{link}" onclick={onDone}>Download</a></p>
        </div>


    </div>

    <script>

        onDone(e){
            window.location.href = '#/'
        }

        this.on('mount', () => {

            this.encrypted = 'encrypted'
            this.org_file_name = 'none'

            var job = services.job_cache_service
            if (job.file == null) {
                this.file_name = 'Error'
                console.log('error')

            } else {

                // Set the file name. 
                var down = document.getElementById('download_link')

                if (job.is_encrypting) {
                    this.org_file_name = job.file.name
                    this.file_name = job.file.name + '.encrypted'
                    this.link = 'data:application/octet-stream,' + job.contents
                    down.download = job.file.name + '.encrypted'
                } else {

                    this.org_file_name = job.file.name
                    var newName = job.file.name.replace('.encrypted', '')
                    this.file_name = newName
                    this.link = job.contents
                    down.download = newName

                    this.encrypted = 'decrypted'
                }
            }

            this.update()
        })
    </script>
</done>