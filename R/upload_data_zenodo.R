#' Upload a file to Zenodo
#' 
#' @param file Path to file to upload.
#' @param zenodo_access_token Path to Zenodo access token. Tokens can be created at 
#' https://zenodo.org/account/settings/applications/tokens/new/ with the "deposit:write" and "deposit:actions" scopes.
#' @param deposit_id The deposit ID of the upload. This should be the last part of the URL for the deposit.
#' @return Returns exit status of curl --upload-file
#' @export
zenodo_upload = function(file, zenodo_access_token, deposit_id){
  
  # Check that a deposit with the indicated ID has been created
  id_check = system(paste("wget --spider", paste0("https://zenodo.org/uploads/", deposit_id)), ignore.stderr = T)
  if(id_check != 0){stop("A Zenodo deposit with the indicated ID does not seem to exist")}
  
  # Check that path to file and access token exists
  if(!file.exists(file)){stop("file does not exist")}
  if(!file.exists(zenodo_access_token)){stop("zenodo_access_token does not exist")}
  
  # Read in the access token
  zenodo_access_token = readLines(zenodo_access_token)
  
  # Get parent directory of file and change into the directory.
  # It seems need to be in the same directory of file to upload it using curl
  current_dir = getwd()
  on.exit(setwd(current_dir))
  parent_dir = dirname(file)
  setwd(parent_dir)
  file = basename(file)
  
  # Create a bucket and upload file
  cmd = paste(
    sprintf("token=%s;", zenodo_access_token), 
    sprintf("deposit_number=%s;", deposit_id), 
    sprintf("filepath=%s;", file), 
    'bucket=$(curl "https://zenodo.org/api/deposit/depositions/${deposit_number}?access_token=$token" | grep -o "bucket[^,]*" | grep -o "https:[^\\"]*");',
    'curl --upload-file "${filepath}" "${bucket}/${filepath}?access_token=${token}"')
  system(cmd)
  return(cmd)
    
}