## Activity Log

### 8/21/2026
- cloned git repo to windows
- setup this file
- cloned git repo to Ubuntu VM
- Setup Rasberry Pi 4B (4GB ram)
    - interfaced with the camera module 3 using the built in 'apps' (i.e. `rpicam-hello --timeout 10000`) detailed here: https://www.raspberrypi.com/documentation/computers/camera_software.html
    - installed opencv using quick install method detailed here: https://opencv-opencv.mintlify.app/installation#linux


### 8/21-8/27/2026
- research potential project ideas

### 8/27/2026
## repo setup on VM
Start in `/home/ryan/projects/final-project-ryanchallacombe`
Following the procedure here:
https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Setting-up-Buildroot-for-Hardware-Builds

# Step 1
Run:
```
git remote add buildroot-base https://github.com/cu-ecen-5013/buildroot-assignments-base.git
git fetch buildroot-base
git merge buildroot-base/master # resulted in conflict so did....
git config pull.rebase false
git pull buildroot-base master --allow-unrelated-histories
```
Note: documentataion for the class sometimes uses `buildroot-base` and sometimes `buildroot-assignments-base`. It depends on what we named the remove when we added it (I think). We are using `buildroot-base` as seen below:
```
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ git remote -v
buildroot-base  https://github.com/cu-ecen-5013/buildroot-assignments-base.git (fetch)
buildroot-base  https://github.com/cu-ecen-5013/buildroot-assignments-base.git (push)
origin  git@github.com:cu-ecen-aeld/final-project-ryanchallacombe.git (fetch)
origin  git@github.com:cu-ecen-aeld/final-project-ryanchallacombe.git (push)
```
# Step 2
reference: https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Raspberry-Pi-Hardware-Support
```
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ git fetch buildroot-base
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ git merge buildroot-base/hw-rpi
error: The following untracked working tree files would be overwritten by merge:
    README.md
Please move or remove them before you merge.
Aborting
```
Let's move the README.md file temporarily. 
`git merge buildroot-base/hw-rpi`

Then I did an add / commit / push. 

# Step 3
Modified the shared.sh file per this link: https://github.com/cu-ecen-aeld/rpi4_buildroot/blob/master/shared.sh



## Notes