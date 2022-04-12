# Export Import

Set of tools to enable export and import of meta-data between MobiledgeX installations

## App Export Import

`./app_export.sh USER [DIRECTORY]`

  - Exports all App records for a given user. Each App record is placed in a seperate file and formatted ready for import with 'mcctl create app --date "json string". 

`./app_import.sh -u URL -r REGION [-i IMAGE_PATH] json_file`

  - Imports one app from a file create by app_export.sh.
  - Requires -u for the API URL and -r for Region
  - -i must be specified if the App contains an image_path


