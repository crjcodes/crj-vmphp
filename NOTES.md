# General Notes

* To update the Ubuntu box to a later version, after the box has been downloaded (first vagrant up after a cleanup):
`vagrant box update`
* If it keeps telling you it can't start up the vm because one of that name already exists, Use the Oracle Virtual Box Manager to remove all the files for the VM of that name



# To Correct

## 1 [RESOLVED]
> A Virtualbox Guest Additions installation was found but no tools to rebuild or start them.
> Got different reports about installed GuestAdditions version:
> Virtualbox on your host claims:   5.2.8
> VBoxService inside the vm claims: 5.2.34

See Vagrantfile notes and deploy.sh at end

## 2

> Ign:4 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 binutils amd64 2.30-21ubuntu1~18.04.2Get:5 http://archive.ubuntu.com/ubuntu bionic/main amd64 libc-dev-bin amd64 2.27-3ubuntu1 [71.8 kB]   
> Err:1 http://security.ubuntu.com/ubuntu bionic-updates/main amd64 binutils-common amd64 2.30-21ubuntu1~18.04.2
>   404  Not Found [IP: 91.189.88.142 80]
> Err:2 http://security.ubuntu.com/ubuntu bionic-updates/main amd64 libbinutils amd64 2.30-21ubuntu1~18.04.2
>   404  Not Found [IP: 91.189.88.142 80]
> Err:3 http://security.ubuntu.com/ubuntu bionic-updates/main amd64 binutils-x86-64-linux-gnu amd64 2.30-21ubuntu1~18.04.2
>   404  Not Found [IP: 91.189.88.142 80]

## 3

> Get:41 http://archive.ubuntu.com/ubuntu bionic/main amd64 manpages-dev all 4.15-1 [2217 kB]
> Fetched 38.8 MB in 1min 6s (587 kB/s)
> E: Failed to fetch http://security.ubuntu.com/ubuntu/pool/main/b/binutils/binutils-common_2.30-21ubuntu1~18.04.2_amd64.deb  404  Not Found [IP: 91.189.88.142 80]
> E: Failed to fetch http://security.ubuntu.com/ubuntu/pool/main/b/binutils/libbinutils_2.30-21ubuntu1~18.04.2_amd64.deb  404  Not Found [IP: 91.189.88.142 80]