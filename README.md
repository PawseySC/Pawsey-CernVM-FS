# Pawsey-CernVM-FS

## What is the aim of this document?

This document is designed to provide current users at [Pawsey Supercomputing Centre](https://pawsey.org.au) easy access to a reference dataset repository, through CernVM-FS.

## What is CernVM-FS and why is it useful?

"The CernVM File System (CernVM-FS) is a read-only file system designed to deliver scientific software onto virtual machines and physical worker nodes in a fast, scalable, and reliable way. Files and file metadata are downloaded on demand and aggressively cached." - [CernVM-FS](https://cvmfs.readthedocs.io/en/stable/cpt-overview.html)

CernVM-FS is a useful solution for ensuring access to commonly used datasets is centralised and easy, and the datasets always updated on the main repository server (Stratum 0), mirrored by replica web servers (Stratum 1), fetched by the proxies (Stratum 2), and accessible to the clients (Stratum 3).

At Pawsey Supercomputing Centre, at present, users on the [Nimbus cloud service](https://pawsey.org.au/systems/nimbus-cloud-service/) can access the Galaxy Project's CernVM-FS data repository webserver /cvmfs/data.galaxyproject.org.

## Installation

Setting up CernVM-FS access on Nimbus instances is simple and quick. It requires only running three lines of code:

    git clone https://github.com/PawseySC/Pawsey-CernVM-FS.git
    cd Pawsey-CernVM-FS

    # for Galaxy repos
    sudo ./cvmfs-client-setup.sh \
        --stratum-1 cvmfs1-mel0.gvl.org.au \
        --stratum-1 cvmfs1-ufr0.galaxyproject.eu \
        --stratum-1 cvmfs1-tacc0.galaxyproject.org \
        --stratum-1 cvmfs1-iu0.galaxyproject.org \
        --stratum-1 cvmfs1-psu0.galaxyproject.org \
        --proxy cvmfs-cachingproxy.pawsey.org.au \
        pubkeys/cvmfs-config.galaxyproject.org.pub \
        pubkeys/data.galaxyproject.org.pub \
        pubkeys/main.galaxyproject.org.pub \
        pubkeys/sandbox.galaxyproject.org.pub \
        pubkeys/singularity.galaxyproject.org.pub \
        pubkeys/test.galaxyproject.org.pub \
        pubkeys/usegalaxy.galaxyproject.org.pub

    # for AARNet repos
    sudo ./cvmfs-client-setup.sh \
        --stratum-1 bcws.test.aarnet.edu.au \
        --proxy cvmfs-cachingproxy.pawsey.org.au \
        pubkeys/containers.biocommons.aarnet.edu.au.pub pubkeys/data.biocommons.aarnet.edu.au.pub pubkeys/tools.biocommons.aarnet.edu.au.pub

## Using CernVM-FS

Users will simply access the data sets as though part of their file system, e.g. accessing the Galaxy project's data repository web server (Stratum 1) is as simple as this:

    ls /cvmfs/data.galaxyproject.org
    
Other repositories can be accessed via the following:

    ls /cvmfs/containers.biocommons.aarnet.edu.au
    ls /cvmfs/data.biocommons.aarnet.edu.au
    ls /cvmfs/tools.bioommons.aarnet.edu.au
    ls /cvmfs/singularity.galaxyproject.org
    ls  /cvmfs/main.galaxyproject.org
    ls  /cvmfs/cvmfs-config.galaxyproject.org

Once the above path(s) is(are) cached, the user can explore all repositories under /cvmfs. When running analyses, the reference file need only be pointed to the appropriate directory path.
    
## Acknowledgements

This work is jointly supported by Pawsey Supercomputing Centre and the Australian BioCommons. Special thanks to QCIF for providing the simple setup code.

## See also

- [CernVM-FS setup default](https://github.com/qcif/cvmfs-setup-example)
- [CernVM-FS documentation](https://cvmfs.readthedocs.io/en/stable/)
