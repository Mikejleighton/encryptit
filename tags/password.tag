<password>

    <navigation selected="home"></navigation>

    <div class="container">
        <div class="jumbotron">
            <div class="form-group {error ? 'has-error' : ''}">
                <label class="control-label" for="inputDefault">{message}</label>
                <input type="password" class="form-control" id="inputDefault" onkeyup={edit}>
            </div>
            <button type="reset" class="btn btn-primary" onclick={close_action}>Cancel</button>
            <button type="reset" class="btn btn-primary" onclick={work_action}>{button_text}</button>
        </div>
    </div>

    <script>

        this.error = false

        var job_service = services.job_cache_service
        if (job_service.file == null) {
            this.message = 'Internal state error'
            this.button_text = 'Error'
            return
        } else {

            if (job_service.is_encrypting) {
                this.button_text = "Encrypt"
            } else {
                this.button_text = "Decrypt"
            }
            this.message = 'Password'
        }

        close_action(e){
            window.location.href = '#/'
        }

        work_action(e){

            if(job_service.password == null){

                this.error = true
                return
            }

            window.location.href = '#/work'
        }

        edit(e) {
            job_service.password = e.target.value
            console.log(job_service.password)
        }
    </script>

    <style>
        .form_input {
            color: #000000;
        }
    </style>
</password>