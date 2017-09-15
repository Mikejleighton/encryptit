
// Service that hold information about the current job. 
// Job is either encrypting or decrypting a file. 
var job_cache_service = {
    is_encrypting : false,
    file : null,
    password : null,
    contents: null
}

// Export to the rest of the application. 
services.job_cache_service = job_cache_service