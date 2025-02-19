#!/bin/bash

# Variables
BUCKET_NAME="your-s3-bucket-name"
SOURCE_DIR="/path/to/jenkins/data" # Adjust this path as needed
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DESTINATION="s3://$BUCKET_NAME/jenkins_backup_$TIMESTAMP"

# Copy files to S3
aws s3 cp $SOURCE_DIR $DESTINATION --recursive

# Check if the command succeeded
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
else
    echo "Backup failed!"
    exit 1
fi





###########################                      OR        u can use below jenkinsfile instead of above


// pipeline {
//     agent any

//     stages {
//         stage('Backup Jenkins Data to S3') {
//             steps {
//                 script {
//                     // Execute the backup script
//                     sh '''
//                     #!/bin/bash
//                     BUCKET_NAME="your-s3-bucket-name"
//                     SOURCE_DIR="/var/lib/jenkins" # Adjust this path as needed
//                     TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
//                     DESTINATION="s3://$BUCKET_NAME/jenkins_backup_$TIMESTAMP"

//                     aws s3 cp $SOURCE_DIR $DESTINATION --recursive

//                     if [ $? -eq 0 ]; then
//                         echo "Backup completed successfully!"
//                     else
//                         echo "Backup failed!"
//                         exit 1
//                     fi
//                     '''
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             echo 'Backup process finished.'
//         }
//         success {
//             echo 'Backup was successful!'
//         }
//         failure {
//             echo 'Backup failed!'
//         }
//     }
// }

