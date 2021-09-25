# This is a basic workflow that is manually triggered

name: LaunchPushToPublicRepo

# Controls when the action will run. Workflow runs when manually triggered using the UI
# or API.
on:
  workflow_dispatch:
  # Inputs the workflow accepts.
    inputs:
      branchName:
        description: 'Please provide branch name that needs to be committed to public repo'
        default: newBranch
        required: true
      launchHelmVersion:
        description: 'Please provide Launch Helm Chart Version'
        default: '1.0'
        required: true 
      launchAppVersion:
        description: 'Please provide Launch App Version'
        default: '10.5.2'
        required: true

     

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - name: checkout
        uses: actions/checkout@v2
      - name: push directory
        env:
          API_TOKEN_GITHUB: ${{ secrets.API_GITHUB_TOKEN }}
          GITHUB_USERNAME: ${{ secrets.USERNAME }}
        run: |
          cwd=$(pwd)
          echo $cwd
          
          chmod 777 *
          chmod 777 ./.github/scripts/LaunchPushToPublicRepo.sh
          ./.github/scripts/LaunchPushToPublicRepo.sh $cwd ${{ env.GITHUB_USERNAME }}  ${{ github.event.inputs.branchName }} \
            ${{ github.event.inputs.launchHelmVersion }} ${{ github.event.inputs.launchAppVersion }}
