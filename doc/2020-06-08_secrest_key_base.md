
Generate a new secret by running rake secret copy the output
Run rails credentials:edit --environment production and enter the value from step 1 as the value of the secret_key_base key in the file.
Make sure RAILS_MASTER_KEY is passed in as a variable to your container. This is used by Rails to decrypt production.yml.enc file.

## using vscode

in ~/.bash_profile

export EDITOR=code -w